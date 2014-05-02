From: David Kastrup <dak@gnu.org>
Subject: Re: Pull is Mostly Evil
Date: Fri, 02 May 2014 17:45:23 +0200
Organization: Organization?!?
Message-ID: <87k3a4xjzg.fsf@fencepost.gnu.org>
References: <5363BB9F.40102@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 02 17:54:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgFnP-0000ZK-0z
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 17:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbaEBPyc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 11:54:32 -0400
Received: from plane.gmane.org ([80.91.229.3]:39653 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753922AbaEBPpn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 11:45:43 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WgFef-0006RT-Aw
	for git@vger.kernel.org; Fri, 02 May 2014 17:45:41 +0200
Received: from x2f3bf8b.dyn.telefonica.de ([2.243.191.139])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 May 2014 17:45:41 +0200
Received: from dak by x2f3bf8b.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 02 May 2014 17:45:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f3bf8b.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Cancel-Lock: sha1:qFPwKq109UMV5frXorOQCi/A78E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247940>

Marc Branchaud <marcnarc@xiplink.com> writes:

> To that end, I suggest that pull's default behaviour should be to do
> *nothing*.  It should just print out a message to the effect that it
> hasn't been configured, and that the user should run "git help pull"
> for guidance.

Fetching is uncontentious, and I _think_ that fast-forwards are pretty
uncontentious as well.

It's just when the merge-left/merge-right/rebase-left/rebase-right
decision kicks in that prescribing one git-pull behavior looks like a
recipe for trouble.

-- 
David Kastrup
