From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 12:45:21 +0200
Message-ID: <47188AC1.9010006@op5.se>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com> <20071019073938.GN14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Symonds <dsymonds@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 19 12:46:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IipMn-0002Cc-DV
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 12:46:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbXJSKpa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 06:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755927AbXJSKp3
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 06:45:29 -0400
Received: from mail.op5.se ([193.201.96.20]:51700 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752453AbXJSKp3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 06:45:29 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 6AE8E173067B;
	Fri, 19 Oct 2007 12:45:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[AWL=0.000, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IBxGU+0starw; Fri, 19 Oct 2007 12:45:24 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 1D31D1730674;
	Fri, 19 Oct 2007 12:45:23 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071019073938.GN14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61685>

Shawn O. Pearce wrote:
> 
> What about this on top of Jeff's patch?
> 
> $ git fetch jc
> ...
> ==> git://repo.or.cz/alt-git.git
>  * tag junio-gpg-pub ......................... (new)
>  * tag v1.5.0 .......................... (tag moved)
> 
> $ git fetch me
> ...
> ==> git://repo.or.cz/git/spearce.git
>  * branch gitk -> spearce/gitk ............... (new)
>  * branch maint -> spearce/maint
>  * branch master -> spearce/master
>  * branch next -> spearce/next
>  * branch pu -> spearce/pu ......... (forced update)
>  * branch todo -> spearce/todo ............... (new)
> 
> The width of the terminal is computed to produce the ... padding.
> I used a very narrow terminal to produce the above so it doesn't
> linewrap badly in email.  If we cannot get the terminal width then
> we just don't produce the padding.
> 

Melikes, although using a fairly narrow padding isn't necessarily
a bad idea. I usually hate it when the output on the left is 15 chars
wide, the one on the right is 5-10 chars wide and there are 60 dots
between them. It's ugly and doesn't make it a easier to read.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
