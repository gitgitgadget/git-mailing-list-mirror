From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] Debian packaging for 0.99.4
Date: Fri, 12 Aug 2005 10:34:45 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.08.12.08.34.45.679778@smurf.noris.de>
References: <pan.2005.08.10.22.11.25.242201@smurf.noris.de> <46a038f9050810155642bb5580@mail.gmail.com> <20050810233953.GV28270@kiste.smurf.noris.de> <E1E33Zb-0004dT-Bx@highlab.com> <46a038f90508102144358a4bcf@mail.gmail.com> <Pine.LNX.4.58.0508102200560.3295@g5.osdl.org> <E1E35vU-0004nP-JR@highlab.com> <Pine.LNX.4.58.0508110915210.3295@g5.osdl.org> <E1E3IOG-0005HO-AK@highlab.com> <20050811201558.GA2874@mars.ravnborg.org> <20050811202410.GB5411@kiste.smurf.noris.de> <42FBCD73.3090507@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Aug 12 10:39:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3V2b-0006ui-Rm
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 10:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbVHLIhW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 04:37:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750792AbVHLIhW
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 04:37:22 -0400
Received: from main.gmane.org ([80.91.229.2]:5303 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750744AbVHLIhW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 04:37:22 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1E3V19-0006lI-Ib
	for git@vger.kernel.org; Fri, 12 Aug 2005 10:35:55 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Aug 2005 10:35:55 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Aug 2005 10:35:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi, Alan Chandler wrote:
> Not sure I understand the proper use of dpkg-divert in Debian, but could 
> _this_ git-core package perhaps ask the user which set of the two 
> packages he wish to keep as git command and use dpkg-divert to change 
> the other to another name to some other name?

IIRC, that's against Policy too, because different users on the system
might have different expectations WRT which git is git.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
You have a strong appeal for members of the opposite sex.
