From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Query on git commit amend
Date: Wed, 7 Dec 2011 05:53:25 +0100
Message-ID: <20111207045325.GA22990@atjola.homenet>
References: <4EDDD0E4.6040003@st.com>
 <87fwgxwvn9.fsf@gmail.com>
 <7vobvlfowk.fsf@alter.siamese.dyndns.org>
 <87wra9und4.fsf@gmail.com>
 <4EDEE988.2070902@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vijay Lakshminarayanan <laksvij@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	Vipin KUMAR <vipin.kumar@st.com>
To: Viresh Kumar <viresh.kumar@st.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 05:53:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY9Vh-0004Gv-PI
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 05:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776Ab1LGExd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 23:53:33 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:33676 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755763Ab1LGExc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 23:53:32 -0500
Received: (qmail invoked by alias); 07 Dec 2011 04:53:30 -0000
Received: from i59F57112.versanet.de (EHLO atjola.homenet) [89.245.113.18]
  by mail.gmx.net (mp055) with SMTP; 07 Dec 2011 05:53:30 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/5HN06MRn59MIvc25rtT89+CzxtiMvUPJ0pk91eE
	iaIIjpYkekFppR
Content-Disposition: inline
In-Reply-To: <4EDEE988.2070902@st.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186422>

On 2011.12.07 09:50:24 +0530, Viresh Kumar wrote:
>=20
> Thanks guys. This whole session was new to me.
>=20
> On 12/7/2011 7:58 AM, Vijay Lakshminarayanan wrote:
> > Junio C Hamano <gitster@pobox.com> writes:
> >=20
> >> > Vijay Lakshminarayanan <laksvij@gmail.com> writes:
> >> >
> >>> >> I've found=20
> >>> >>
> >>> >> $ GIT_EDITOR=3Dcat git commit --amend
> >>> >>
> >>> >> useful.
> >> >
> >> > Are you sure it is a cat?
> > Yes.
>=20
> This didn't worked for me. Got following error:
>=20
> cat: unrecognized option `--amend'
> Try `cat --help' for more information.
> error: There was a problem with the editor 'cat git commit --amend'.
> Please supply the message using either -m or -F option.
> Could not commit staged changes.

That looks like you did something like:
export GIT_EDITOR=3D"cat git commit --amend"

But the original command was:
  GIT_EDITOR=3Dcat git commit --amend

Notice that there are no quotes and no escaped spaces. This is a
shortcut to set GIT_EDITOR to "cat" for just this one command (git
commit --amend).

If you want to set the editor in the environment, use just "export
GIT_EDITOR=3Dcat" or something like that.

HTH
Bj=F6rn
