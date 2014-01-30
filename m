From: David Kastrup <dak@gnu.org>
Subject: Re: Strange merge output.
Date: Thu, 30 Jan 2014 12:24:31 +0100
Organization: Organization?!?
Message-ID: <87y51x4sr4.fsf@fencepost.gnu.org>
References: <55DE3FAC-BD7E-4AB2-8A18-CF85BB859465@kameleoon.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 30 12:24:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8pjk-0004TK-7X
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 12:24:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063AbaA3LYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jan 2014 06:24:44 -0500
Received: from plane.gmane.org ([80.91.229.3]:45792 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751799AbaA3LYn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jan 2014 06:24:43 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W8pjd-0004OA-Gb
	for git@vger.kernel.org; Thu, 30 Jan 2014 12:24:41 +0100
Received: from x2f43172.dyn.telefonica.de ([2.244.49.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 12:24:41 +0100
Received: from dak by x2f43172.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 30 Jan 2014 12:24:41 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f43172.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:V7xfbWSMRKHEYnj6IKip2djZV5A=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241266>

Vincent Bernardi <vincent@kameleoon.com> writes:

> Hi,
> I asked about this problem on #git@freenode and someone suggested I
> submit it to this list. I have a case where the output of a merge
> gives a conflict and produces the following file:
>
> Code Block A
> <<<<<<< HEAD
> =======
> Code Block B
>>>>>>>> branch-B
> Code Block B' (similar to code block B but not exactly the same).
>
> Here is what HEAD looks like 
> Code Block A
> Code Block B' 
>
> and branch-B:
> Code Block A
> Code Block B
>
> I thought that taking a conflicted file like above and removing the
> three following lines:
> <<<<<<< HEAD
> =======
>>>>>>>> branch-B
>
> was supposed to produce *exactly* the branch-B version?

No?  It will produce the branch-B version in the conflicted area, but
that does not mean that conflict resolution might not have been done
outside of that area.

-- 
David Kastrup
