From: "David Copeland" <davetron5000@gmail.com>
Subject: Re: Can someone confirm what the contents of refs/heads/master means?
Date: Mon, 8 Dec 2008 17:21:26 -0500
Message-ID: <f95d47890812081421x180ba049p6275cc7bc19eb2c@mail.gmail.com>
References: <f78b0fcc-6165-440a-b76b-b1b0a281b15c@k8g2000yqn.googlegroups.com>
	 <20081208212636.GA6061@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 08 23:23:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9oV5-0005nm-LT
	for gcvg-git-2@gmane.org; Mon, 08 Dec 2008 23:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753909AbYLHWVa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Dec 2008 17:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753882AbYLHWV3
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Dec 2008 17:21:29 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:36077 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753569AbYLHWV2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Dec 2008 17:21:28 -0500
Received: by nf-out-0910.google.com with SMTP id d3so665549nfc.21
        for <git@vger.kernel.org>; Mon, 08 Dec 2008 14:21:26 -0800 (PST)
Received: by 10.103.176.20 with SMTP id d20mr1434223mup.27.1228774886217;
        Mon, 08 Dec 2008 14:21:26 -0800 (PST)
Received: by 10.103.239.6 with HTTP; Mon, 8 Dec 2008 14:21:26 -0800 (PST)
In-Reply-To: <20081208212636.GA6061@atjola.homenet>
Content-Disposition: inline
X-Google-Sender-Auth: 4f1dc1ca9f5fab48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102589>

Ah, that makes sense (I did another clone of another repo and did not
experience this behavior, so now that all makes sense).

Thanks!

Dave

On Mon, Dec 8, 2008 at 4:26 PM, Bj=F6rn Steinbrink <B.Steinbrink@gmx.de=
> wrote:
> On 2008.12.08 11:23:46 -0800, davetron5000 wrote:
>> I'm using git-svn to interact with an SVN repo that has branches.
>>
>> After my clone via:
>>
>> git svn clone $REPO/main -T trunk -b branches -t tags
>>
>> my 'master' branch pointed to one of the branches in svn and not to
>> the main trunk. (my .git/config looked correct for svn interaction,
>> i.e. trunk pointed to the right place).
>
> Just to clear up that bit as well. when the "fetch" finishes (which i=
s
> part of the clone process), git-svn checks if there is a master branc=
h,
> and if not, it creates one from the last commit it created. So if you=
r
> last svn commit was to branch XYZ and not to trunk, master will
> reference that commit on branch XYZ.
>
> Bj=F6rn
>
