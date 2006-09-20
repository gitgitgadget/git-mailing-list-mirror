From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] sha1_name: accept output of git-describe
Date: Wed, 20 Sep 2006 23:31:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0609202330190.19042@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0609202255290.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v64figrhu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 23:31:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ9fa-0000bo-Hi
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 23:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWITVbj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 17:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbWITVbi
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 17:31:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:14822 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932143AbWITVbi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 17:31:38 -0400
Received: (qmail invoked by alias); 20 Sep 2006 21:31:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 20 Sep 2006 23:31:36 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64figrhu.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27408>

Hi,

On Wed, 20 Sep 2006, Junio C Hamano wrote:

> Shouldn't you also verify the leading ref (most likely a tag)
> exists (and optionally check that it precedes the commit you
> decoded into, but that is probably more expensive than it's
> worth)?

I debated this with myself. But there is the cost, and more importantly 
the possibility that your victim^H^H^H^H^H^Hother side does not have the 
tag at all (for whatever reasons).

Ciao,
Dscho
