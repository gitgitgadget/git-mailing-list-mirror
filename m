From: =?UTF-8?B?SsO2cmc=?= Schaible <joerg.schaible@swisspost.com>
Subject: Re: git svn clone fails
Date: Thu, 03 Sep 2015 14:19:46 +0200
Organization: Swiss Post Solutions
Message-ID: <ms9dt3$851$1@ger.gmane.org>
References: <mpa8th$m80$1@ger.gmane.org> <mppsku$h97$1@ger.gmane.org> <mqk6mb$qi8$1@ger.gmane.org> <20150902022757.GA7143@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 14:20:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXTUw-0008NK-Cg
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 14:20:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753832AbbICMUE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 08:20:04 -0400
Received: from plane.gmane.org ([80.91.229.3]:47709 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965AbbICMUC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 08:20:02 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZXTUg-0008CN-Jt
	for git@vger.kernel.org; Thu, 03 Sep 2015 14:19:54 +0200
Received: from 62.154.225.82 ([62.154.225.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 14:19:54 +0200
Received: from joerg.schaible by 62.154.225.82 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 03 Sep 2015 14:19:54 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 62.154.225.82
User-Agent: KNode/4.14.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277198>

Hi Eric,

Eric Wong wrote:

> J=C3=B6rg Schaible <joerg.schaible@swisspost.com> wrote:
>> Is there really no other place for a bug report? This will simply va=
nish
>> in the list's noise ...
>=20
> These messages do get seen and read.  (And I would not have seen this
> message if it were posted anywhere else).

As first time poster for this list without any response in days I was s=
imply=20
not sure, if it was the correct place to report problems.

> But I don't have much time or motivation to work on git svn since it'=
s
> mostly made itself obsolete for me.

That's our goal also, to make svn obsolete ;-)
All we need is a one time conversion.
=20
> --preserve-empty-dirs probably hasn't seen much real-world use and
> (IIRC) not something that could always be 100% reliable.
>=20
> Regardless of options, git svn does log empty directories, so there's
> also an obscure, probably equally-unused "git svn mkdirs" command whi=
ch
> processes the unhandled.log files inside $GIT_DIR to recreate empty
> directories.  You could give that a try.

I am not sure, what you actually try to tell me here. How can I interfe=
re in=20
the complete "svn clone" process?

Note, that the problem seems really to be caused by some obscure condit=
ion.=20
We can actually clone some svn trees that contain empty directories and=
 they=20
are properly handled with a .gitignore file. However, some fail for unk=
nown=20
reason.

I tried to recreate the situation with a separte non-critical svn=20
playground, but was never able reproduce the problem. svn clone succeed=
ed=20
every time. Not very useful for an error report, I know. :-/

Cheers,
J=C3=B6rg
