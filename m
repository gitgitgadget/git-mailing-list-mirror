From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix renaming branch without config file
Date: Thu, 5 Apr 2007 17:30:05 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0704051728400.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070405144359.4B8832A7C67@potomac.gnat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Geert Bosch <bosch@gnat.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 17:30:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZTuw-0005Vd-Mt
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 17:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767055AbXDEPaK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 11:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767050AbXDEPaJ
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 11:30:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:54350 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1767055AbXDEPaH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 11:30:07 -0400
Received: (qmail invoked by alias); 05 Apr 2007 15:30:06 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp018) with SMTP; 05 Apr 2007 17:30:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Z4RFCdTwZbU8a9G1qvGa9FTtedjkEdTWu1cZWnj
	yxMWm+wSG0xAye
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070405144359.4B8832A7C67@potomac.gnat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43833>

Hi,

On Thu, 5 Apr 2007, Geert Bosch wrote:

> Make git_config_rename_section return success if no config file
> exists.

I don't think this is correct. git_config_rename_section() _should_ return 
an error.

> Otherwise, renaming a branch would abort, leaving the repository in an 
> inconsistent state.

This should take the hint from --rename-section, and print a warning (or 
not).

Ciao,
Dscho
