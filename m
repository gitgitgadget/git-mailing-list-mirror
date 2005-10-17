From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Some curl versions lack curl_easy_duphandle()
Date: Mon, 17 Oct 2005 20:54:08 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510172049330.14782@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510150038550.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmzlbpbwu.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510151348080.12307@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051016215018.GG5509@reactrix.com> <20051017180130.GJ5509@reactrix.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 17 20:56:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERa7m-0000DW-4p
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 20:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVJQSyP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 14:54:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVJQSyO
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 14:54:14 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:54218 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932261AbVJQSyM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 14:54:12 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C7CCE13E5C3; Mon, 17 Oct 2005 20:54:09 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AD4F39EDE2; Mon, 17 Oct 2005 20:54:09 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 993BE99CC3; Mon, 17 Oct 2005 20:54:09 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id BBB6913F09D; Mon, 17 Oct 2005 20:54:08 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20051017180130.GJ5509@reactrix.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10188>

Hi,

On Mon, 17 Oct 2005, Nick Hengeveld wrote:

> On Sun, Oct 16, 2005 at 02:50:18PM -0700, Nick Hengeveld wrote:
> 
> > Is that the correct version number?  I've been using 7.10.6 and 
> > curl_easy_duphandle() has been working fine.
> 
> Apart from the version number question, this patch looks good.

Aaargh! Of course I was looking at the annotate output, which said Nov 9, 
2004. But this is just the last change to the signature of the function!

So, AFAIK Sep 13, 2001, is the correct date, and 0x070900 is the version.

>  Although I'm now wondering whether it makes sense to bother trying to 
> use curl_easy_duphandle() at all and always use get_curl_handle() 
> instead.

There might well be a substantial overhead involved. I haven't measured 
it, but it seems reasonable to assume that duplicating a handle is 
implemented using a shorter code path than creating a handle all over 
again.

Ciao,
Dscho
