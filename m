From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Added make options NO_GUI and WITH_P4IMPORT.
Date: Wed, 21 Mar 2007 12:16:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703211213100.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070320114525.GP96806@codelabs.ru> <etpuen$2uo$2@sea.gmane.org>
 <20070321051406.GW96806@codelabs.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Wed Mar 21 12:21:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTysU-0005tB-TO
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 12:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752241AbXCULVL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 07:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752237AbXCULVL
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 07:21:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:44315 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751809AbXCULVK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 07:21:10 -0400
Received: (qmail invoked by alias); 21 Mar 2007 11:16:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp045) with SMTP; 21 Mar 2007 12:16:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+sLN1RNJ+sROoikHyYFtK88Ua8EsfgCLNeoRLl1w
	3o1Lo0eBxFZ6G7
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070321051406.GW96806@codelabs.ru>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42786>

Hi,

On Wed, 21 Mar 2007, Eygene Ryabinkin wrote:

> Will try to implement. But still, NO_GUI should ban the GUI tools from 
> being built and installed, because user can have the Tcl/Tk available, 
> but have no intention to use the git GUI. Am I right?

I am not quite certain if I agree. With a similar reasoning, you could 
introduce a flag to prevent pull-request from being installed, and 
git-tag, or other rarely used functions. Is it so bad to have gitk and 
git-gui installed? I mean, you are likely to just try them (and possibly 
like them!) at some stage, because the graphical representation is so much 
clearer than what _any_ text representation can do.

Ciao,
Dscho
