From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Modify/edit old commit messages
Date: Thu, 1 Feb 2007 13:28:44 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702011326130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070201114909.GV8705@enneenne.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Rodolfo Giometti <giometti@enneenne.com>
X-From: git-owner@vger.kernel.org Thu Feb 01 13:28:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCb3a-0007KQ-3G
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 13:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422837AbXBAM2r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 07:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422838AbXBAM2r
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 07:28:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:35282 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422837AbXBAM2q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 07:28:46 -0500
Received: (qmail invoked by alias); 01 Feb 2007 12:28:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp023) with SMTP; 01 Feb 2007 13:28:44 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070201114909.GV8705@enneenne.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38346>

Hi,

On Thu, 1 Feb 2007, Rodolfo Giometti wrote:

> I'm puzzled... how can I modify or edit old commit messages? :)

Short answer: you can't.

Slightly longer answer: since the object name is calculated from data 
including the commit message, there is no way you can change it.

However, you can start from a certain commit in history, and _recommit_ a 
commit. There, you can edit the message and rebase the other commits on 
top of it. NOTE: the resulting commit is _not_ easily mergeable for people 
who track your branch.

Hth,
Dscho
