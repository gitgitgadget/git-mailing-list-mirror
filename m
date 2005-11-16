From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [RFC] git email submissions
Date: Thu, 17 Nov 2005 00:20:01 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.11.16.23.19.58.895975@smurf.noris.de>
References: <437B4472.1080401@pobox.com> <Pine.LNX.4.64.0511160847250.13959@g5.osdl.org> <437B7213.2020406@zytor.com> <437B73E2.3080903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Nov 17 00:26:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcWdF-0000zF-Jh
	for gcvg-git@gmane.org; Thu, 17 Nov 2005 00:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161012AbVKPXX7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 18:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbVKPXX7
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 18:23:59 -0500
Received: from main.gmane.org ([80.91.229.2]:39895 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161012AbVKPXX6 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 18:23:58 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EcWbI-00009D-TT
	for git@vger.kernel.org; Thu, 17 Nov 2005 00:22:01 +0100
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 00:22:00 +0100
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 17 Nov 2005 00:22:00 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12069>

Hi, Jeff Garzik wrote:

> Smarter programs would send the overall description and pack file as 
> "[patch 0/N]", and then post the for-review patches in separate emails 
> as "[patch M/N]".

So you want to send the stuff twice? Ouch.

Seriously: We can mail patches, and we can re-base our changes.

Anything that's not covered by this is inherently complicated, such that
specifying the starting point(s) of a git-send-pack-mail invocation needs
to be handled by a program, else we *will* get *lots* of pilot errors.

Surprise: We already have a solution: host your archive someplace
and let git push+fetch handle everything.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Alan Turing thought about criteria to settle the question of whether
machines can think, a question of which we now know that it is about
as relevant as the question of whether submarines can swim.
		-- Dijkstra
