From: David Kastrup <dak@gnu.org>
Subject: Re: Potential bug: truncated diff output
Date: Thu, 16 Jan 2014 07:31:34 +0100
Organization: Organization?!?
Message-ID: <87lhyg4eux.fsf@fencepost.gnu.org>
References: <CAAyYaWo7wtsVGGxUeE3wwG6UHZ_qc8wcPu4Dk6=DsF8JtyF6_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 16 07:31:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3gUc-00052d-9P
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 07:31:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619AbaAPGbv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 01:31:51 -0500
Received: from plane.gmane.org ([80.91.229.3]:48277 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759AbaAPGbt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 01:31:49 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W3gUS-0004gT-NN
	for git@vger.kernel.org; Thu, 16 Jan 2014 07:31:44 +0100
Received: from x2f3b11f.dyn.telefonica.de ([2.243.177.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Jan 2014 07:31:44 +0100
Received: from dak by x2f3b11f.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 16 Jan 2014 07:31:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f3b11f.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:7nLOAAAqNFO7VfeWx6s2rzPtJww=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240506>

Misha Penkov <misha.penkov@gmail.com> writes:

> I have a file in a git repo. It has changed during the last two
> commits. I want to see the changes made in these two commits. The
> following command should work:
>
>     git diff HEAD^^
>
> but that doesn't get me the expected results. Read on for details.

> As I mentioned in the first paragraph, I want to generate a patch that
> includes both commits:
>
>     $git diff HEAD^^ HEAD ieicej.cls

> This looks wrong, since it doesn't include the last commit. For
> example, changes to line 3145 are not there. It appears to include
> changes from the second-last commit (e.g. the stuff around line 1714).
>
> My questions:
>
> 1) What am I doing wrong?

You did not commit all your changes.  Some of them are either only in
your working directory, or in working directory and index.

> 2) How can I get the diff to include all the commits in their
> entirety?

It did.

> 3) Is this a bug?

No.

-- 
David Kastrup
