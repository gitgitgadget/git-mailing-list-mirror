From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Regarding: git-lost+found
Date: Mon, 14 Nov 2005 05:36:40 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.14.04.36.38.784541@smurf.noris.de>
References: <Pine.LNX.4.63.0511081811080.18406@wbgn013.biozentrum.uni-wuerzburg.de> <7vvez1bjjv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Nov 14 05:40:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbW7I-0004H7-1U
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 05:38:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750906AbVKNEik (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Nov 2005 23:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbVKNEik
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Nov 2005 23:38:40 -0500
Received: from main.gmane.org ([80.91.229.2]:54751 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750906AbVKNEij (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Nov 2005 23:38:39 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EbW5w-00035T-AY
	for git@vger.kernel.org; Mon, 14 Nov 2005 05:37:28 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 05:37:28 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Nov 2005 05:37:28 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11765>

Hi, Junio C Hamano wrote:

>           $ gitk $(cd .git/lost+found/commit && echo ??*)

Along those lines... I just tried that, it found a whole heap of old
commits I didn't yet clean up, and they're sorted by their SHA1.

In other words, actually finding the latest commit in there was a
nontrivial task.

I don't speak tcl, so could somebody please change "gitk -d" to sort its
command line by date (newest first, of course)?  Thanks.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Innocence ends when one is stripped of the delusion that one likes
oneself.
