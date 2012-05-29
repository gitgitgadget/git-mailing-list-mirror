From: "Steven E. Harris" <seh@panix.com>
Subject: Re: How does Git's maintenance policy handle topics that don't start from "master?"
Date: Tue, 29 May 2012 17:24:20 -0400
Organization: SEH Labs
Message-ID: <m2wr3u4r5n.fsf@Spindle.sehlabs.com>
References: <m21um2682e.fsf@Spindle.sehlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 29 23:24:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZTu9-0005Yf-AG
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 23:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898Ab2E2VYd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 17:24:33 -0400
Received: from plane.gmane.org ([80.91.229.3]:57008 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755875Ab2E2VYc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 17:24:32 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SZTu1-0005TW-LP
	for git@vger.kernel.org; Tue, 29 May 2012 23:24:29 +0200
Received: from c-24-23-122-157.hsd1.pa.comcast.net ([24.23.122.157])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 May 2012 23:24:29 +0200
Received: from seh by c-24-23-122-157.hsd1.pa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 29 May 2012 23:24:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-23-122-157.hsd1.pa.comcast.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3.50 (darwin)
Cancel-Lock: sha1:TQMSA7H+X2dt1GimISzCJQZOr1Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198763>

"Steven E. Harris" <seh@panix.com> writes:

> Is there a part of the policy that addresses this case that I missed?

After posting I discovered the "SubmittingPatches" document=C2=B9, whic=
h does
address part of my inquiry:

,----[ Decide what to base your work on ]
| - A new feature should be based on 'master' in general. If the new
|    feature depends on a topic that is in 'pu', but not in 'master',
|    base your work on the tip of that topic.
|=20
| - Corrections and enhancements to a topic not yet in 'master' should
|    be based on the tip of that topic. If the topic has not been merge=
d
|    to 'next', it's alright to add a note to squash minor corrections
|    into the series.
|=20
| - In the exceptional case that a new feature depends on several topic=
s
|    not in 'master', start working on 'next' or 'pu' privately and sen=
d
|    out patches for discussion. Before the final merge, you may have t=
o
|    wait until some of the dependent topics graduate to 'master', and
|    rebase your work.
`----

The last one in particular implies that the topic branch will not be fi=
t
for serious consideration until its dependencies have themselves
graduated to "master."

=46ootnotes:=20
=C2=B9 https://raw.github.com/git/git/master/Documentation/SubmittingPa=
tches
--=20
Steven E. Harris
