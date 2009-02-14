From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] config: Use parseopt.
Date: Sat, 14 Feb 2009 20:11:02 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142003300.10279@pacific.mpi-cbg.de>
References: <1234577142-22965-1-git-send-email-felipe.contreras@gmail.com>  <7vab8pweod.fsf@gitster.siamese.dyndns.org>  <94a0d4530902140237o7d26ff4j1c7350d926d12c1a@mail.gmail.com>  <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>
 <94a0d4530902140415j4168d09dh8abac0d6eba0b8cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 20:11:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYPvO-0006qF-Uq
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 20:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbZBNTKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 14:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751758AbZBNTKK
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 14:10:10 -0500
Received: from mail.gmx.net ([213.165.64.20]:50475 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751269AbZBNTKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 14:10:09 -0500
Received: (qmail invoked by alias); 14 Feb 2009 19:10:07 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 14 Feb 2009 20:10:07 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ZxlAvenkZZlmp8EzSRsUViACwLrCLYJg3GRkUDL
	4ylsXmHlTqjdX+
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <94a0d4530902140415j4168d09dh8abac0d6eba0b8cf@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.75
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109893>

Hi,

On Sat, 14 Feb 2009, Felipe Contreras wrote:

> 1) --list when no config file is given uses all the config files,
> wouldn't it make sense to have a --repo option?

The idea of --list is not "cat .git/config".  The idea is to help users or 
scripts to list the current settings (_including_ the global settings).

You can force showing the repo-specific config with "git --file 
.git/config", though.

Ciao,
Dscho
