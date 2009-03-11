From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Include log_config module in apache.conf
Date: Wed, 11 Mar 2009 12:46:23 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903111240150.10279@pacific.mpi-cbg.de>
References: <alpine.LNX.1.00.0903102320170.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 12:46:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhMtA-0005l6-F0
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 12:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755235AbZCKLoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 07:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755212AbZCKLoq
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 07:44:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:50315 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755329AbZCKLop (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 07:44:45 -0400
Received: (qmail invoked by alias); 11 Mar 2009 11:44:41 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp036) with SMTP; 11 Mar 2009 12:44:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19uhrN+3FRuSicYINmls/8T3hM7xVK9bFoduFcFTm
	4UcSowWnUfVOvR
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.1.00.0903102320170.19665@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112909>

Hi,

On Tue, 10 Mar 2009, Daniel Barkalow wrote:

> The log_config module is needed for at least some versions of apache to 
> support the LogFormat directive.
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> Johannes, you added the LogFormat line without this; does the test still 
> work for you with this added, or do we need something clever to decide 
> whether the module needs to be loaded or needs to not be loaded?

Sorry, no:

-- snip --
apache2: Syntax error on line 7 of 
/home/schindelin/git/t/lib-httpd/apache.conf: module log_config_module is 
built-in and can't be loaded
-- snap --

Ciao,
Dscho
