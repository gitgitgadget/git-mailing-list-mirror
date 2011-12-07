From: Viresh Kumar <viresh.kumar@st.com>
Subject: Re: Query on git commit amend
Date: Wed, 7 Dec 2011 11:15:10 +0530
Message-ID: <4EDEFD66.4020404@st.com>
References: <4EDDD0E4.6040003@st.com> <87fwgxwvn9.fsf@gmail.com> <7vobvlfowk.fsf@alter.siamese.dyndns.org> <87wra9und4.fsf@gmail.com> <4EDEE988.2070902@st.com> <20111207045325.GA22990@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vijay Lakshminarayanan <laksvij@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 07 06:45:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYAJs-0005xj-Af
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 06:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356Ab1LGFpY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Dec 2011 00:45:24 -0500
Received: from eu1sys200aog110.obsmtp.com ([207.126.144.129]:56153 "EHLO
	eu1sys200aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751077Ab1LGFpX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Dec 2011 00:45:23 -0500
Received: from beta.dmz-ap.st.com ([138.198.100.35]) (using TLSv1) by eu1sys200aob110.postini.com ([207.126.147.11]) with SMTP
	ID DSNKTt79bA5mxIiQl2/Iwl5r4Mlnxmot69mr@postini.com; Wed, 07 Dec 2011 05:45:21 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8C03FA7;
	Wed,  7 Dec 2011 05:36:47 +0000 (GMT)
Received: from Webmail-ap.st.com (eapex1hubcas3.st.com [10.80.176.67])
	by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6C5DDB16;
	Wed,  7 Dec 2011 05:45:13 +0000 (GMT)
Received: from [10.199.82.50] (10.199.82.50) by Webmail-ap.st.com
 (10.80.176.7) with Microsoft SMTP Server (TLS) id 8.3.192.1; Wed, 7 Dec 2011
 13:45:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <20111207045325.GA22990@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186423>

On 12/7/2011 10:23 AM, Bj=F6rn Steinbrink wrote:
> That looks like you did something like:
> export GIT_EDITOR=3D"cat git commit --amend"
>=20
> But the original command was:
>   GIT_EDITOR=3Dcat git commit --amend
>=20
> Notice that there are no quotes and no escaped spaces. This is a
> shortcut to set GIT_EDITOR to "cat" for just this one command (git
> commit --amend).
>=20
> If you want to set the editor in the environment, use just "export
> GIT_EDITOR=3Dcat" or something like that.

Ok. Got it now.

Now, whats the benefit of=20

GIT_EDITOR=3Dcat git commit --amend

over

git commit --amend -C HEAD

?

Obviously if we have more than one commit to handle during a rebase the=
n,
setting editor to cat once, would be good. As now we don't really need =
to
do git commit --amend. We can add commits and continue rebase.
But for single commit probably second one looks easier. Isn't it?
Or maybe the latest patch from Junio is even better.

--=20
viresh
