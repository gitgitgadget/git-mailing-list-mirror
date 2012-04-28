From: Yann Hodique <yann.hodique@gmail.com>
Subject: Re: Bug in git-stash(.sh) ?
Date: Sat, 28 Apr 2012 22:23:24 +0200
Message-ID: <87wr4za9mr.fsf@gmail.com>
References: <20379.9312.943088.350379@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: magit@googlegroups.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 28 22:35:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOEMr-0004nH-Qd
	for gcvg-git-2@plane.gmane.org; Sat, 28 Apr 2012 22:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab2D1UfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Apr 2012 16:35:11 -0400
Received: from plane.gmane.org ([80.91.229.3]:52200 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065Ab2D1UfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2012 16:35:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SOEMC-0004Ea-FP
	for git@vger.kernel.org; Sat, 28 Apr 2012 22:35:04 +0200
Received: from aannecy-552-1-169-161.w83-201.abo.wanadoo.fr ([83.201.185.161])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Apr 2012 22:35:04 +0200
Received: from yann.hodique by aannecy-552-1-169-161.w83-201.abo.wanadoo.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Apr 2012 22:35:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: aannecy-552-1-169-161.w83-201.abo.wanadoo.fr
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1.50 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwBAMAAAClLOS0AAAAJ1BMVEUEBgMUFBEnIR07MStT
 QjlvWkyEbl2ccWaVe2mpi3qxj3bDoIz+//wlCgCYAAACWUlEQVQ4EQXBQXIVVRQA0HNvGPNvJ45J
 98epQhIdK6ALsNyA63EPLsEtWFQ5FlLFVDodHVr8fh0dQj/PSQAAgAQAAEgAGG4mEKoSAKyGgerV
 WgIIxKBoWkgAh2GwRmwjqkuAyPNpsNYh0UQCVMXFNA3DVCNVPQFy+PH6qxfD0CJCaxKgIr97+er5
 2u56VyUBhouxb49evZjqSNsiAdrBEu2/r6/H+6L3BITMQdX556+UEAmo0nvheP3DpFdPwOAqCvrZ
 TbBFAnHgMiCclRjGBOLhAmBzpM4T6Mfr8w3othGJc+J63AuwX+qn94kr8sgJQNNa4jSaWNdf30At
 9w1JXhzHYoirT7fwpDNI8ubm6TlWw4r+184aSX/08urKsa+vpyv++eWPFT0Jj4JlOv4UXX/d17eU
 5BNTa2MeLfppev6i2CT9dqcW8njb3np32+iSmpM2whft2cPoDJL2D2D/eHF/64mgKvFhsZvJsw/d
 ZdautpboP9+GxKd3z+JwcNK6hLkF+L0P9e+73lRI6F0H4qkvd7ZeCYzgG/PdaBW9WgLLwjzfXX7Y
 vL+rbosExb6vYluet7ulqd4TMLZFU/Xbx1NTm0ro3HN1mudhX060Q7WEmE5jrfk03ebdAlsl+LuW
 bpm+NY19URWHLSHGsbdZm4fH86nQVQLn+5ytnR2tc9O2h23NKtR0ue7z3v+cTwt1eaghI4ZhaDn1
 u97Wpc2Ndt9aS8TAxXn/8P5Nv1uJDFUZnMba43pa53UN9H2vLjufPX/IiJtjnZYJojqp9zEek2c3
 399MhRAR/gfpVBU4QWr2iwAAAABJRU5ErkJggg==
Cancel-Lock: sha1:kbpZL/5g6oNYFFs/V+dWileIjzI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196500>

>>>>> "Eli" == Eli Barzilay writes:

> [Note: cross-posted to the magit list to see if anyone else has
> this problem.]

> For a while now I had a problem when I try to do stash operations via
> magit -- for example, it shows this in the process buffer:

>   $ git --no-pager stash apply stash@{2012-04-27 08:53:30 -0400}
>   Too many revisions specified: stash@{2012-04-27 08:53:30 -0400}

How exactly do you make magit generate these calls?
AFAICT, Magit should operate on whatever "git stash list" outputs,
meaning stash@{N}. So I guess I'm missing something.

Yann.

-- 
The strictest limits are self-imposed.

  -- FRIEDRE GINAZ, Philosophy of the Swordmaster
