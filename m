From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: hared GIT repos (was Re: rsync deprecated but promoted?)
Date: Tue, 27 Sep 2005 08:35:37 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.27.06.35.35.834134@smurf.noris.de>
References: <20050925163201.GA29198@tumblerings.org> <4d4586301dca616f42880612fae01492@cream.org> <20050926133204.GB21019@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Tue Sep 27 08:39:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK96I-0007NV-Jw
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 08:38:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbVI0Gh4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 02:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbVI0Gh4
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 02:37:56 -0400
Received: from main.gmane.org ([80.91.229.2]:63435 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964826AbVI0Ghz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Sep 2005 02:37:55 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EK956-0006w8-3t
	for git@vger.kernel.org; Tue, 27 Sep 2005 08:36:48 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Sep 2005 08:36:48 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 27 Sep 2005 08:36:48 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9374>

Hi, Petr Baudis wrote:

> The thing is, rsync is bad - it will happily put
> duplicate, redundant, and especially unwanted data to your repository,
> especially when the shared GIT repositories happen.

Speaking of which -- is anybody working on that one?

I find myself in need of a multiuser shared repository that cannot
be corrupted (i.e. I want to prevent the users from removing objects,
and replacing a ref with something that is not a child of the sha1 that's
already there should also be prevented).

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Beware of bugs in the above code; I have only proved it correct, not tried it.
		-- Donald Knuth
