From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] blame.c: prepare_lines should not call xrealloc for every line
Date: Tue, 04 Feb 2014 21:10:39 +0100
Organization: Organization?!?
Message-ID: <87lhxqwse8.fsf@fencepost.gnu.org>
References: <1391544367-14599-1-git-send-email-dak@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 21:11:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAmKq-0007qR-9Q
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 21:11:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956AbaBDULE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 15:11:04 -0500
Received: from plane.gmane.org ([80.91.229.3]:51563 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932088AbaBDUK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 15:10:59 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WAmKZ-0007ia-7s
	for git@vger.kernel.org; Tue, 04 Feb 2014 21:10:51 +0100
Received: from x2f4740e.dyn.telefonica.de ([2.244.116.14])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 21:10:51 +0100
Received: from dak by x2f4740e.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Feb 2014 21:10:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f4740e.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:tXxs1/EmnVKnxhPo+8cs1sJgPJQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241546>


Whitespace error in line 1778.  Should I be reposting?

-- 
David Kastrup
