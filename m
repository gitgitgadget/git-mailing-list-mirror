From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: resumable git-clone?
Date: Wed, 8 Aug 2007 21:35:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0708082134130.21916@wbgn129.biozentrum.uni-wuerzburg.de>
References: <fcaeb9bf0708070623p24f1cae2q2af959a89738c4e8@mail.gmail.com>
 <20070808035946.GP9527@spearce.org> <Pine.LNX.4.64.0708081012110.14781@racer.site>
 <7vlkcl4zcw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 21:35:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIrK1-0001hQ-BO
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 21:35:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762019AbXHHTfx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 15:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761389AbXHHTfx
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 15:35:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:37922 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757474AbXHHTfw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 15:35:52 -0400
Received: (qmail invoked by alias); 08 Aug 2007 19:35:50 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp003) with SMTP; 08 Aug 2007 21:35:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187oikobXY7jrnsZG8duuHM3boMAmgPGt3b0Qrwsj
	N+V9wqW+TF53K6
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vlkcl4zcw.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55343>

Hi,

On Wed, 8 Aug 2007, Junio C Hamano wrote:

> So I've been thinking about teaching the server side, when responding to 
> a fetch request, to be able to say something like "Sorry but this 
> repository is for fetching by people who have at least these commits 
> from that other project I am a fork of." We make that "at least these 
> from that other project" part machine readable, and git-fetch request 
> git-clone makes can redirect itself to fill the prerequisites before 
> attempting to go there again.

Something like the alternates that http transport can use?

> *1* Sheesh.  While I was writing this I noticed that the current
>     'git bundle' is suitable only for incremental sneakernet but
>     not for this particular use case.
> 
>     $ git bundle create 2612.bndl v2.6.12
> 
>     does not work, although
> 
>     $ git bundle create 2612-2613.bndl v2.6.12..v2.6.13
> 
>     does.  We need to fix this.

Yes, I noticed this a long time ago.  Time is lacking...

Ciao,
Dscho
