From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-mv: succeed even if source is a prefix of destination
Date: Wed, 16 Aug 2006 08:34:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608160833180.28360@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060815205150.GA467@c165.ib.student.liu.se>
 <Pine.LNX.4.63.0608151401510.3965@chino.corp.google.com>
 <Pine.LNX.4.63.0608160209150.28360@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060816054944.GA5218@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Rientjes <rientjes@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 16 08:34:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GDEyp-0000Wc-Kg
	for gcvg-git@gmane.org; Wed, 16 Aug 2006 08:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750951AbWHPGeR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Aug 2006 02:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbWHPGeQ
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Aug 2006 02:34:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:13526 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750951AbWHPGeQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Aug 2006 02:34:16 -0400
Received: (qmail invoked by alias); 16 Aug 2006 06:34:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp022) with SMTP; 16 Aug 2006 08:34:14 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060816054944.GA5218@c165.ib.student.liu.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25500>

Hi,

On Wed, 16 Aug 2006, Fredrik Kuivinen wrote:

> It looks like we need some kind of path normalization before we do those 
> tests.

Yes, you are right. I hoped I did not need to do this... Working on it.

Ciao,
Dscho
