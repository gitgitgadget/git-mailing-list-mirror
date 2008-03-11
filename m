From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/40] Add target architecture MinGW.
Date: Wed, 12 Mar 2008 00:28:51 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803120028130.3873@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at> <alpine.LSU.1.00.0802281159550.22527@racer.site> <200803052221.12495.johannes.sixt@telecom.at> <200803112230.57004.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Mar 12 00:29:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZDuS-0005DL-0m
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 00:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbYCKX2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 19:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbYCKX2t
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 19:28:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:38469 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751196AbYCKX2s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 19:28:48 -0400
Received: (qmail invoked by alias); 11 Mar 2008 23:28:46 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp001) with SMTP; 12 Mar 2008 00:28:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/46zgc5UP4++jniCQLTHfLE2QrQo3WagwXAlGro8
	SmtYt623K7Cziq
X-X-Sender: gene099@racer.site
In-Reply-To: <200803112230.57004.johannes.sixt@telecom.at>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76901>

Hi,

On Tue, 11 Mar 2008, Johannes Sixt wrote:

> On the positive side, we can now reuse Michal's vsnprintf wrapper, which 
> fixes snprintf, too, (which was not the case previously). Note that on 
> Windows we have to adjust the size parameter.

Actually, I have to admit that I like strbuf_vaddf() more and more.  
Anything you would wish me to implement there?

Ciao,
Dscho
