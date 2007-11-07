From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git-clean a builtin
Date: Wed, 7 Nov 2007 11:10:45 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711071110040.4362@racer.site>
References: 7vbqa8j5yr.fsf@gitster.siamese.dyndns.org
 <11944127311587-git-send-email-shawn.bohrer@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Shawn Bohrer <shawn.bohrer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 07 12:11:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpioJ-0006si-AB
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 12:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbXKGLKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 06:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbXKGLKs
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 06:10:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:35568 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751441AbXKGLKs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 06:10:48 -0500
Received: (qmail invoked by alias); 07 Nov 2007 11:10:46 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp024) with SMTP; 07 Nov 2007 12:10:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/p0688DffpLzurB24bahaLEUzKr2yhkm8eB6eeQG
	CXWoOVy+Rx1kZy
X-X-Sender: gene099@racer.site
In-Reply-To: <11944127311587-git-send-email-shawn.bohrer@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63805>

Hi,

you still have quite a number of instances where you wrap just one line 
into curly brackets:

	if (bla) {
		[just one line]
	}

Ciao,
Dscho
