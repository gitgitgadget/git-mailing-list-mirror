From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH 0/4] Recovery after interrupted HTTP(s) fetch
Date: Thu, 15 Sep 2005 12:35:01 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.15.10.34.59.363606@smurf.noris.de>
References: <20050914124206.GC24405@master.mivlgu.local> <7vpsrbjz0t.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0509141325310.26803@g5.osdl.org> <Pine.LNX.4.63.0509141641290.23242@iabervon.org> <Pine.LNX.4.58.0509141411510.26803@g5.osdl.org> <Pine.LNX.4.63.0509141722500.23242@iabervon.org> <7vk6hjfh9u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Thu Sep 15 12:40:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFr8H-0008Uk-F7
	for gcvg-git@gmane.org; Thu, 15 Sep 2005 12:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbVIOKiL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Sep 2005 06:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932561AbVIOKiL
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Sep 2005 06:38:11 -0400
Received: from main.gmane.org ([80.91.229.2]:27050 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932081AbVIOKiJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Sep 2005 06:38:09 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EFr6c-00086Z-7N
	for git@vger.kernel.org; Thu, 15 Sep 2005 12:36:38 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Sep 2005 12:36:38 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 15 Sep 2005 12:36:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8601>

Hi, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
>> Oh, right. Yeah, that's the obvious solution. I'll do that tonight.
> 
> Thanks.  In the meantime I have Sergey's patch in the "pu"
> branch but we can replace it with your fix.

Personally I'd rather combine the two. The point being, broken
repositories do happen -- for instance, when the file system is
inconsistent after a crash, or when the referent of an info/alternates
directory vanishes. :-/

I'd rather have a simple repair flag than do a "download everything again
and then throw most of it away" job when something like that happens.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Experience keeps a dear school, but it's a hell of a campaign tactic.
					-- Poor Jimmy's Almanac
