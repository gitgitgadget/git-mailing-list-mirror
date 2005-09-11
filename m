From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Multi-ancestor read-tree notes
Date: Sun, 11 Sep 2005 18:45:10 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.11.16.45.08.244699@smurf.noris.de>
References: <Pine.LNX.4.63.0509050049030.23242@iabervon.org> <7vy866i1zc.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0509091337460.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Sun Sep 11 18:48:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEUz6-0000Y7-BG
	for gcvg-git@gmane.org; Sun, 11 Sep 2005 18:47:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964938AbVIKQrH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Sep 2005 12:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbVIKQrH
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Sep 2005 12:47:07 -0400
Received: from main.gmane.org ([80.91.229.2]:20620 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964938AbVIKQrF (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Sep 2005 12:47:05 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EEUxV-00087Y-KV
	for git@vger.kernel.org; Sun, 11 Sep 2005 18:45:37 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 18:45:37 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 11 Sep 2005 18:45:37 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8300>

Hi, Daniel Barkalow wrote:

>  I'm actually interested in doing a big spiffy program 
> to do merges with information drawn as needed from the history, stuff 
> happening on a per-hunk level, and support for block moves.

You should look at "meld", which is a nice Python program to do
graphical merges.

In addition to that, I've written a Python interface for direct
(read-only) access to git objects, so you can do more interesting
things without forking off a lot of programs. Expect that work to appear
here shortly.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"The majority of the stupid is invincible and guaranteed for all time. The
terror of their tyranny, however, is alleviated by their lack of consistency."
-- Albert Einstein
