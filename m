From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Extend cat-file to take multiple arguments or read input
 from stdin.
Date: Thu, 15 Nov 2007 04:34:02 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711150432420.4362@racer.site>
References: <fhghqv$98a$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Nov 15 05:34:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsWRA-00018h-0V
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 05:34:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754371AbXKOEeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 23:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754125AbXKOEeW
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 23:34:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:52476 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753196AbXKOEeV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 23:34:21 -0500
Received: (qmail invoked by alias); 15 Nov 2007 04:34:19 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp032) with SMTP; 15 Nov 2007 05:34:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/x9nYb5qzxLt5yI3uQEdEgeFICXOHp3sswbjmmQx
	6RLIHSbz+yKgDI
X-X-Sender: gene099@racer.site
In-Reply-To: <fhghqv$98a$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65054>

Hi,

On Thu, 15 Nov 2007, Han-Wen Nienhuys wrote:

> With this functionality, the entire object database can be dumped with a 
> limited number of processes: two cat-file processes for discovering size 
> and type, and one cat-file process per type.

IMHO a better idea would be a counterpart to fast-import, probably called 
"fast-export".  You'd need only one process then, and it would not only be 
faster, but would be usable by even more people, I guess.

Ciao,
Dscho
