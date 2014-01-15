From: David Kastrup <dak@gnu.org>
Subject: Re: Consistency question
Date: Wed, 15 Jan 2014 12:55:02 +0100
Organization: Organization?!?
Message-ID: <87wqi17949.fsf@fencepost.gnu.org>
References: <8761pl8raj.fsf@fencepost.gnu.org>
	<20140115111330.GH14335@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 15 12:55:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3P45-0005MH-Oj
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jan 2014 12:55:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbaAOLzS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jan 2014 06:55:18 -0500
Received: from plane.gmane.org ([80.91.229.3]:38739 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbaAOLzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jan 2014 06:55:16 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1W3P3x-00053A-9b
	for git@vger.kernel.org; Wed, 15 Jan 2014 12:55:13 +0100
Received: from x2f3b11f.dyn.telefonica.de ([2.243.177.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 12:55:13 +0100
Received: from dak by x2f3b11f.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 15 Jan 2014 12:55:13 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f3b11f.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3.50 (gnu/linux)
Cancel-Lock: sha1:98QtKW/IYgZ90SuN/7UnhwwmOYs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240465>

Jeff King <peff@peff.net> writes:

> There are some parts of the code that will behave badly with clock skew.
> For example, "--since" will stop traversing when we hit a certain point.
> It requires a fixed number of "too old" commits before quitting, though,
> in an attempt to bypass small runs of skewed clocks.

That actually turns out to be a somewhat sore point for me: I use
something like

git shortlog -n --since 2013/12/01 --until 2014/01/01 master

for generating statistics on LilyPond when I am doing my monthly report
begging the community for money.

It turns out that the numbers of commits attributed to me tend to go
_down_ quite regularly in the time from starting the report to sending
it out.  Which might also cause me to overlook a particularly
selfpraiseworthy item.

Not sure how feasible it would be to arrive at a stable and
complementary set of --since/--until.

-- 
David Kastrup
