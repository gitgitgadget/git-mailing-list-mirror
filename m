From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: SVN import
Date: Mon, 10 Oct 2005 15:32:49 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.10.10.13.32.46.778506@smurf.noris.de>
References: <pan.2005.08.19.10.00.49.401829@smurf.noris.de> <pan.2005.10.10.09.45.00.468989@smurf.noris.de> <20051010102651.GA30202@gentoo.org> <20051010111428.GC30202@gentoo.org> <20051010113933.GL567@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Oct 10 15:36:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOxoX-0003E1-WF
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 15:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVJJNfe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 09:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbVJJNfe
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 09:35:34 -0400
Received: from main.gmane.org ([80.91.229.2]:54765 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750787AbVJJNfd (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 09:35:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EOxmw-0002iH-IG
	for git@vger.kernel.org; Mon, 10 Oct 2005 15:33:58 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Oct 2005 15:33:58 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Oct 2005 15:33:58 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9889>

Hi, Matthias Urlichs wrote:

> Hi,
> 
> Elfyn McBratney:
>> Worth noting that the URL is actually:
>> http://netz.smurf.noris.de/git/git.git ;)

The current version seems to actually work with nontrivial repositories
(I'm importing gnupg at the moment, which recently switched from CVS to
SVN).

Also worth noting is that cvs->svn->git is somewhat more faithful WRT
importing CVS archives with "incomplete" or "funky" tags -- it exports
their state correctly to SVN, and my importer should be able to get them
out again. On the minus side, the two cannot generate the same changesets
because cvs2svn rounds timestamps to the next full minute.

Speed: Comparable to the CVS importer when crossing the network: both need
one roundtrip per file. I haven't done any tests with local repositories.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Each morning puts a man on trial and each evening passes judgment.
					-- Roy L. Smith
