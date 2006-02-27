From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] First cut at libifying revlist generation
Date: Mon, 27 Feb 2006 10:00:09 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602270947380.5937@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0602251608160.22647@g5.osdl.org>
 <7vpsl93395.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 27 10:00:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDeF9-0008JK-0L
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 10:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWB0JAN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 04:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWB0JAN
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 04:00:13 -0500
Received: from wrzx35.rz.uni-wuerzburg.de ([132.187.3.35]:9101 "EHLO
	mailrelay.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932316AbWB0JAK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 04:00:10 -0500
Received: from virusscan.mail (mail04.mail [172.25.1.103])
	by mailrelay.mail (Postfix) with ESMTP id D79931C61;
	Mon, 27 Feb 2006 10:00:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id CA5535F92;
	Mon, 27 Feb 2006 10:00:09 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id AA8F2B03;
	Mon, 27 Feb 2006 10:00:09 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsl93395.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16830>

Hi,

On Sun, 26 Feb 2006, Junio C Hamano wrote:

> Johannes gets a test-pilot star for this.  This also means we need a bit 
> better set of tests.

Well, I don't deserve this. I cheated.

In my personal version of git, there are a few subtle things different 
than in the official version. Most of them, I sent out already, and they 
were rejected, such as 
http://article.gmane.org/gmane.comp.version-control.git/10718, which 
helped me tremendously in identyfing the bug.

But there is also a test case in my version, which was a failure, 
originally. I wrote it to demonstrate that the stupid version of 
git-fetch was stupid. It did not demonstrate that, but rather quite a bit 
of (my) normal usage. That is the reason it takes a really long time for a 
test case, and that in turn is the reason I did not dare to submit it.

Ciao,
Dscho
