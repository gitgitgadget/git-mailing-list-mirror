From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 10:38:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0610201034170.14200@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org> <45357411.20500@utoronto.ca>
 <200610180246.18758.jnareb@gmail.com> <45357CC3.4040507@utoronto.ca>
 <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca>
 <87lkncev90.wl%cworth@cworth.org> <453792A8.1010700@utoronto.ca>
 <878xjc2qeb.wl%cworth@cworth.org> <453803E6.2060309@utoronto.ca>
 <87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca>
 <Pine.LNX.4.64.0610192202340.3962@g5.osdl.org> <45387F04.5010101@research.canon.com.au>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 20 10:39:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GapuG-0000Hm-6S
	for gcvg-git@gmane.org; Fri, 20 Oct 2006 10:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992591AbWJTIjF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 04:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992592AbWJTIjE
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 04:39:04 -0400
Received: from mail.gmx.de ([213.165.64.20]:5277 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S2992591AbWJTIjC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Oct 2006 04:39:02 -0400
Received: (qmail invoked by alias); 20 Oct 2006 08:39:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp010) with SMTP; 20 Oct 2006 10:39:00 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Lachlan Patrick <loki@research.canon.com.au>
In-Reply-To: <45387F04.5010101@research.canon.com.au>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29419>

Hi,

On Fri, 20 Oct 2006, Lachlan Patrick wrote:

> How does git disambiguate SHA1 hash collisions?

It does not. You can fully expect the universe to go down before that 
happens.

The only reasonable worry is about SHA-1 being broken some time in future, 
i.e. being able to construct a malign version of some source code _which 
has the same hash_. There were plenty of discussions about that; Please 
search the mailing list. (The consent was that those do not matter, 
because an existing object will _never_ be overwritten by a fetch, so you 
would not get that invalid object anyway.)

Hth,
Dscho
