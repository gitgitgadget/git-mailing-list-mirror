From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Installation failure caused by CDPATH environment variable
Date: Wed, 11 Jul 2007 18:09:34 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707111807470.4516@racer.site>
References: <9693D8E9-6F11-4AA1-AFCA-7E8456FA6420@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Jul 11 19:17:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8fot-00045N-Lm
	for gcvg-git@gmane.org; Wed, 11 Jul 2007 19:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755206AbXGKRRU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 13:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755281AbXGKRRT
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 13:17:19 -0400
Received: from mail.gmx.net ([213.165.64.20]:48389 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755206AbXGKRRT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 13:17:19 -0400
Received: (qmail invoked by alias); 11 Jul 2007 17:17:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 11 Jul 2007 19:17:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19FY2Fv4DJFo7KrfuMu0v9YS9HjXy80M4nbogwJlK
	nWRJJYS+0Wv1BE
X-X-Sender: gene099@racer.site
In-Reply-To: <9693D8E9-6F11-4AA1-AFCA-7E8456FA6420@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52178>

Hi,

On Wed, 11 Jul 2007, Wincent Colaiuta wrote:

> [describes the typical CDPATH problem]

You exported CDPATH.  You're guaranteed to run into problems with that.  I 
doubt that your patch catches all problems in git, and even if we tried to 
avoid breakage, you can only do so much about that.

It is _wrong_ to export CDPATH.

Hth,
Dscho
