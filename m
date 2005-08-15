From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Switching heads and head vs branch after CVS import
Date: Mon, 15 Aug 2005 11:07:12 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.15.09.07.10.118103@smurf.noris.de>
References: <46a038f905081417241f9598cc@mail.gmail.com> <Pine.LNX.4.58.0508141737270.3553@g5.osdl.org> <46a038f905081419057cc6b5cd@mail.gmail.com> <Pine.LNX.4.58.0508141937251.3553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Mon Aug 15 11:10:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4ayB-0007ZZ-AK
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 11:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbVHOJJV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 05:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932331AbVHOJJV
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 05:09:21 -0400
Received: from main.gmane.org ([80.91.229.2]:24530 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932274AbVHOJJU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 05:09:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E4awx-0007O1-T9
	for git@vger.kernel.org; Mon, 15 Aug 2005 11:08:07 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 11:08:07 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 15 Aug 2005 11:08:07 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Linus Torvalds wrote:

>> There may be some surprises in here! gitk --all shows at least one
>> branch opening and merging back into origin, and it has figured it out
>> correctly
>
> Oh, wow. The new cvsimport is obviously being a hell of a lot smarter
> than my original one was. Goodie.

Umm, actually, no, cvsimport doesn't do merges. Dunno where Martin got his
from, but it wasn't me. ;-)

> Sven, Matthias, opinions? I've never used CVS keyword expansion, and 
> always felt it was pointless, but hey..

I have intentionally kept keyword expansion on when I wrote the code,
because matching up the files from CVS with files gathered from tarballs,
Debian repositories, and what-not, becomes a whole lot easier that way.

For me, that's a major use case, esp. with CVS getting confused about its
tags (as people haphazardly copy whole subtrees from one CVS repository
into a different one).

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
I hope you will find the courage to keep on living
despite the existence of this feature.

	-- Richard Stallman
