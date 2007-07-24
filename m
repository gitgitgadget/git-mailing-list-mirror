From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: rfe: bisecting with a tristate
Date: Tue, 24 Jul 2007 23:39:06 +0200
Message-ID: <200707242339.07980.robin.rosenberg.lists@dewire.com>
References: <Pine.LNX.4.64.0707241459460.18990@fbirervta.pbzchgretzou.qr> <200707241907.57857.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0707241818450.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>,
	Jan Engelhardt <jengelh@computergmbh.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 23:38:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDS4u-0007QT-Aa
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 23:38:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbXGXVh5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 17:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752901AbXGXVh5
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 17:37:57 -0400
Received: from [83.140.172.130] ([83.140.172.130]:14534 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752889AbXGXVh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 17:37:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id E78288026C7;
	Tue, 24 Jul 2007 23:30:39 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32132-01; Tue, 24 Jul 2007 23:30:39 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 48489802654;
	Tue, 24 Jul 2007 23:30:39 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0707241818450.14781@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53649>

tisdag 24 juli 2007 skrev Johannes Schindelin:
> And why exactly do you want to make it hard on the user?

Nah, I don't want to do that. Just thinking aloud ;-)
 
> Imagine this history:
> 
> 	A - B - broken - bad - C
> 
> Now you bisect.  It goes to "broken".  You compile.  Darn, does not 
> compile.  Why not have a "git bisect dunno", which considers only the 
> _rest_ of the commits for the next bisection point?  When it finally found 
> the "bad" one, it has to say it broke somewhere between "B..bad".
> 
> Now that would be user friendly, wouldn't it?

It would work fine.

-- robin
