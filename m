From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: merge-base: update the clean-up postprocessing
Date: Wed, 5 Jul 2006 09:50:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607050946390.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <44AB0948.9070606@gmail.com> <7vy7v8dctz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: A Large Angry SCM <gitzilla@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 05 09:51:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fy2AA-0003VT-Pt
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 09:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932349AbWGEHu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 03:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWGEHu4
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 03:50:56 -0400
Received: from mail.gmx.de ([213.165.64.21]:50142 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932349AbWGEHuz (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jul 2006 03:50:55 -0400
Received: (qmail invoked by alias); 05 Jul 2006 07:50:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp015) with SMTP; 05 Jul 2006 09:50:54 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7v8dctz.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23338>

Hi,

On Tue, 4 Jul 2006, Junio C Hamano wrote:

> This is "for concepts" only -- it still seems to have bugs
> somewhere to break other tests, although it passes your new
> tests.

Doesn't this introduce a nasty O(n*m) performance (where m is the 
number of merge bases, and n the number of traversed commits)? I think 
possibly many commits are traversed multiple times.

BTW ALAS' argument about grafts not only shot down my maximumSkew, but 
AFAICT also the generation number thing. Besides, the generation number 
could be manipulated by a mean-spirited person also.

Ciao,
Dscho
