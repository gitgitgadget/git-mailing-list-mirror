From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: git log filtering
Date: Wed, 07 Feb 2007 22:59:44 -0300
Message-ID: <200702080159.l181xiK3021514@laptop13.inf.utfsm.cl>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com> <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org> <Pine.LNX.4.63.0702071822430.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7v64ad7l12.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org>
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Don Zickus <dzickus@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 03:00:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEya1-0001y7-Lp
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 03:00:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422864AbXBHCAE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 21:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422871AbXBHCAB
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 21:00:01 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:47217 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422864AbXBHCAA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 21:00:00 -0500
Received: from laptop13.inf.utfsm.cl (pc-173-245-83-200.cm.vtr.net [200.83.245.173])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l181xjhI022118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Feb 2007 22:59:46 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.14.0/8.13.8) with ESMTP id l181xiK3021514;
	Wed, 7 Feb 2007 22:59:44 -0300
In-reply-to: <Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org>
Comments: In-reply-to Linus Torvalds <torvalds@linux-foundation.org>
   message dated "Wed, 07 Feb 2007 13:03:05 -0800."
X-Mailer: MH-E 7.4.2; nmh 1.2-20070115cvs; XEmacs 21.5  (beta27)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [0.0.0.0]); Wed, 07 Feb 2007 22:59:46 -0300 (CLST)
X-Virus-Scanned: ClamAV 0.88.7/2533/Wed Feb  7 11:20:47 2007 on inti.inf.utfsm.cl
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.7 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.0.6
X-Spam-Checker-Version: SpamAssassin 3.0.6 (2005-12-07) on inti.inf.utfsm.cl
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39027>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Wed, 7 Feb 2007, Junio C Hamano wrote:
> > This is very tempting but, ... hmmmm...
> 
> I would actually prefer to have it be some marker on the expression 
> itself.
> 
> We already do that '^' handling by hand for "author"/"committer" things. 
> We could do other things like that.
> 
> Although I guess the downside of not doing standard regexps would be too 
> big.

Use Perl's regexps? the pcre library packs them, and they have all sorts of
goodies like markers in the expression itself. 
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
