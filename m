From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/6] builtin-merge: avoid non-strategy git-merge commands
 in error message
Date: Mon, 28 Jul 2008 15:06:09 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807281505010.2725@eeepc-johanness>
References: <cover.1217207602.git.vmiklos@frugalware.org> <fd19583955e9cea5b78a465d23bc127a51940048.1217207602.git.vmiklos@frugalware.org> <5a003a0e20d0942c946680e4eade8e9d19f0036b.1217207602.git.vmiklos@frugalware.org>
 <9cc2813166c8b20ffb411c3a28ad86665e60033b.1217207602.git.vmiklos@frugalware.org> <10c4292de30b5868bd9fb54b557e8dae827f1241.1217207602.git.vmiklos@frugalware.org> <42e8615f6cbd236e40b19f2a754807f08e4b85a6.1217207602.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Jul 28 15:06:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNSQO-0001wJ-Sc
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 15:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbYG1NFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 09:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751012AbYG1NFE
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 09:05:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:59216 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751070AbYG1NFC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 09:05:02 -0400
Received: (qmail invoked by alias); 28 Jul 2008 13:05:00 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp050) with SMTP; 28 Jul 2008 15:05:00 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184fb1vC8k4wUlIlAfXLZ68E4JKXTTBMsebdM2Cby
	0YjiK6Mj4eAU67
X-X-Sender: user@eeepc-johanness
In-Reply-To: <42e8615f6cbd236e40b19f2a754807f08e4b85a6.1217207602.git.vmiklos@frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.74
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90456>

Hi,

On Mon, 28 Jul 2008, Miklos Vajna wrote:

> -		list_commands("git-merge-", "strategies");
> +		list_commands("git-merge-", "strategies", &not_strategies);

The change in the signature of list_commands() is not part of this patch.  
So at least one of your commits should result in an uncompileable 
revision...

Ciao,
Dscho
