From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow format-patch to create patches for merges
Date: Mon, 26 Jan 2009 16:36:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901261604420.25749@intel-tinevez-2-302>
References: <1232978650-7008-1-git-send-email-nathan.panike@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com, aspotashev@gmail.com
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 16:38:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRTXk-0007qR-9a
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 16:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbZAZPhG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 10:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbZAZPhF
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 10:37:05 -0500
Received: from mail.gmx.net ([213.165.64.20]:41408 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751533AbZAZPhE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 10:37:04 -0500
Received: (qmail invoked by alias); 26 Jan 2009 15:37:02 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp040) with SMTP; 26 Jan 2009 16:37:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184EZMslVc4za1lnB2HVpci/pOe7pf9V2ZELJo4Av
	D2ZSYCES3quizt
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1232978650-7008-1-git-send-email-nathan.panike@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107220>

Hi,

On Mon, 26 Jan 2009, Nathan W. Panike wrote:

> The behavior for git format-patch is to ignore merge commits, producing 
> an empty patch.  The code does not allow the user to change this 
> behavior. This patch changes that behavior by allowing the user to 
> specify -c or -m at the command line to produce a patch for a merge 
> commit.

Your patch is almost perfect, except that you

- lack an explanation when this makes sense (format-patch is commonly used 
  for mail-based patch queues, and only -m 1 would make sense there, and 
  only if you run format-patch with --first-parent),

- did not add your Sign-off :-)

Ciao,
Dscho
