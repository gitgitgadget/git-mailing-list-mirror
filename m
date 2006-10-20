From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 13:37:02 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610201335420.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca>
 <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca>
 <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca>
 <87lkncev90.wl%cworth@cworth.org> <453792A8.1010700@utoronto.ca>
 <878xjc2qeb.wl%cworth@cworth.org> <453803E6.2060309@utoronto.ca>
 <87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca>
 <Pine.LNX.4.64.0610192202340.3962@g5.osdl.org> <45387F04.5010101@research.canon.com.au>
 <Pine.LNX.4.63.0610201034170.14200@wbgn013.biozentrum.uni-wuerzburg.de>
 <ehaapb$5t7$3@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Fri Oct 20 13:37:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gasgc-0004at-BP
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 13:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422984AbWJTLhH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 07:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423099AbWJTLhH
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 07:37:07 -0400
Received: from mail.gmx.de ([213.165.64.20]:32903 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1422984AbWJTLhF (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 07:37:05 -0400
Received: (qmail invoked by alias); 20 Oct 2006 11:37:03 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 20 Oct 2006 13:37:03 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ehaapb$5t7$3@sea.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29450>

Hi,

On Fri, 20 Oct 2006, Jakub Narebski wrote:

> Johannes Schindelin wrote:
> 
> > On Fri, 20 Oct 2006, Lachlan Patrick wrote:
> > 
> >> How does git disambiguate SHA1 hash collisions?
> > 
> > It does not. You can fully expect the universe to go down before that 
> > happens.
>  
> Or you can compile git with COLLISION_CHECK
> 
> >From Makefile:
> # Define COLLISION_CHECK below if you believe that SHA1's
> # 1461501637330902918203684832716283019655932542976 hashes do not give you
> # sufficient guarantee that no collisions between objects will ever happen.

You can document your disbelief.

But it does not change a thing. Since v0.99~653, we do not have any 
collision check, even if compiled with COLLISION_CHECK.

Ciao,
Dscho
