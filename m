From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Thu, 12 Jan 2006 22:53:09 +0100
Message-ID: <43C6CFC5.5010902@op5.se>
References: <BAYC1-PASMTP117A18814EAAFACFE0F31DAE270@CEZ.ICE> <7vzmm1mcfz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 22:53:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExANh-0008On-Vd
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 22:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161328AbWALVxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 16:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161329AbWALVxM
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 16:53:12 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:35244 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1161328AbWALVxK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 16:53:10 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id A85A56BD00; Thu, 12 Jan 2006 22:53:09 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmm1mcfz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14591>

Junio C Hamano wrote:
> 
> If you typed that line, why somebody else's change ended up in
> your working tree is a mystery to me, but let's say an
> office-mate edited things for you and said "this should work.
> test it out and if it is OK commit it for me."  I have seen this
> kind of thing done in real life.
> 

This happens from time to time where I work, but I think it would be 
more useful to have

	--from="Some User <some.user@theoffice.org>"

which would save even more typing.

I had thought of coupling this with some translation-scheme thingie, so 
that "--from=jd" would be automagically converted to the proper name and 
email address. I first came to think about this when I imported most of 
our projects from CVS, but I ended up doing a quick-hack to 
git-cvsimport instead.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
