From: David Kastrup <dak@gnu.org>
Subject: What's with git blame --reverse ?
Date: Mon, 27 Jan 2014 13:45:32 +0100
Organization: Organization?!?
Message-ID: <87y5218ufn.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 27 13:46:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7lZc-0007QR-4j
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 13:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762AbaA0Mpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jan 2014 07:45:47 -0500
Received: from plane.gmane.org ([80.91.229.3]:40321 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753743AbaA0Mpp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 07:45:45 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W7lZQ-0007MH-87
	for git@vger.kernel.org; Mon, 27 Jan 2014 13:45:44 +0100
Received: from x2f3d3f3.dyn.telefonica.de ([2.243.211.243])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Jan 2014 13:45:44 +0100
Received: from dak by x2f3d3f3.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Jan 2014 13:45:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f3d3f3.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:JcDH05496TkxGKB8OtETvbiLKXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241135>


The git blame manual page talks about using git blame --reverse to
figure out when a particular change disappeared, but I cannot make it
produce anything useful regardless of what range I give it.  Using
--root delivers a different state of uselessness.

Can anyone give a recipe for using git blame --reverse on the Git code
base for figuring out anything of relevance?

Since I am in the process of rewriting git-blame, of course I want to
verify that everything works, but while I achieve the same results, they
seem fabulously useless before and after my rewrite.

-- 
David Kastrup
