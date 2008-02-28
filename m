From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 33/40] When installing, be prepared that template_dir
 may be relative.
Date: Thu, 28 Feb 2008 15:45:22 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802281542000.22527@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <1204138503-6126-34-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Thu Feb 28 16:46:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUkxr-0007ol-Pa
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 16:46:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758573AbYB1Ppz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 10:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758509AbYB1Ppy
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 10:45:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:45141 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757204AbYB1Ppy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 10:45:54 -0500
Received: (qmail invoked by alias); 28 Feb 2008 15:45:52 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp041) with SMTP; 28 Feb 2008 16:45:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18R96hFz4wRf/AYxs3Gn9KNE/Q11dSyiu2fDGwHIM
	y7Fy+fOXtj5LAB
X-X-Sender: gene099@racer.site
In-Reply-To: <1204138503-6126-34-git-send-email-johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75412>

Hi,

On Wed, 27 Feb 2008, Johannes Sixt wrote:

> @@ -1094,6 +1094,13 @@ remove-dashes:
>  
>  ### Installation rules
>  
> +ifeq ($(firstword $(subst /, ,$(template_dir))),..)

How portable is "firstword"?  Would it not be better to use

ifneq ($(patsubst ../%,,$(template_dir)),)

Hmm?

Ciao,
Dscho
