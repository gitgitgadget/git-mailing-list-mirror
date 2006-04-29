From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH/RFC] Extended SHA1 -- "rev^#" syntax to mean "all parents"
Date: Sat, 29 Apr 2006 09:59:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604290954370.3701@g5.osdl.org>
References: <7virosalxb.fsf@assigned-by-dhcp.cox.net> <7vaca490ln.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0604291737390.25093@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 29 19:01:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZso2-0007bk-ER
	for gcvg-git@gmane.org; Sat, 29 Apr 2006 19:00:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbWD2RAU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Apr 2006 13:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbWD2RAU
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Apr 2006 13:00:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18910 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750760AbWD2RAT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Apr 2006 13:00:19 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3TGxrtH023820
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 29 Apr 2006 09:59:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3TGxrDC015708;
	Sat, 29 Apr 2006 09:59:53 -0700
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0604291737390.25093@wbgn013.biozentrum.uni-wuerzburg.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19309>



On Sat, 29 Apr 2006, Johannes Schindelin wrote:
> 
> > A short-hand "rev^#" is understood to be "all parents of the
> > named commit" with this patch.
> 
> Just my 2/100: Why not "rev^*"? I could remember that more easily.

Yeah, that (or ^@ - to match shell "$1" "$2" .. "$@") was my reaction too.

The "rev^#" thing should to my mind return the _number_ of parents, the 
same way "$#" does in shell. I actually pronounce that '#' character 
mentally as "number", but maybe that's just because I'm totally mentally 
damaged by shell programming, and everybody else probably calls it "hash" 
(and some people apparently call it "pound", for some really sick reason).

So "rev^#" literally reads as "revision parent number" to me. Useful? 
Maybe. Maybe not.

		Linus
