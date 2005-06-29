From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] cvsimport: rewritten in Perl
Date: Wed, 29 Jun 2005 22:40:40 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.29.20.40.37.811830@smurf.noris.de>
References: <pan.2005.06.28.19.23.08.307486@smurf.noris.de> <Pine.LNX.4.63.0506291048140.1667@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Wed Jun 29 22:37:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnjI5-0000KY-BH
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 22:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbVF2Um5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 16:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVF2Um5
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 16:42:57 -0400
Received: from main.gmane.org ([80.91.229.2]:49106 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262626AbVF2UmV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2005 16:42:21 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1DnjG6-0008QL-5j
	for git@vger.kernel.org; Wed, 29 Jun 2005 22:34:10 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Jun 2005 22:34:10 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Jun 2005 22:34:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Nicolas Pitre wrote:

> ftp.kernel.org/pub/scm/linux/kernel/bkcvs/linux-2.5/

Oh well, I'll have a look. (I never bothered with bk2cvs; there's a
better tool which does bk2git directly.)

> New scripts/lxdialog/yesno.c: 0 bytes.

0-byte files are quite common in real-world repositories, so
throwing an error when I see one won't work.

> Can't exec "git-update-cache": Argument list too long at
> /home/nico/bin/git-cvsimport-script line 402, <CVS> line 8254.

That, at least, is easily fixable, I'll do a followup patch.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"A 'meaning of life' removes the overriding fear that existance is
 useless -- while denying the fact that living is its own greatest reward."
          [Fredric Rice, HolySmoke, December 1996]
