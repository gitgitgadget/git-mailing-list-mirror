From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/3] Replace setenv(GIT_DIR_ENVIRONMENT, ...) with
 set_git_dir()
Date: Thu, 22 Nov 2007 01:22:38 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711220121560.27959@racer.site>
References: <11956768414090-git-send-email-prohaska@zib.de>
 <11956768412804-git-send-email-prohaska@zib.de> <11956768413887-git-send-email-prohaska@zib.de>
 <11956768412755-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Dmitry Kakurin <Dmitry.Kakurin@gmail.com>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Nov 22 02:23:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv0mX-0007LD-1S
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 02:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbXKVBWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 20:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752654AbXKVBWs
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 20:22:48 -0500
Received: from mail.gmx.net ([213.165.64.20]:59515 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752268AbXKVBWr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 20:22:47 -0500
Received: (qmail invoked by alias); 22 Nov 2007 01:22:45 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp057) with SMTP; 22 Nov 2007 02:22:45 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+HXyxtyGKHf18wYQcHoeq67UFPwMYgUmiFC5H7qB
	SH/aGz/WI2Mbp/
X-X-Sender: gene099@racer.site
In-Reply-To: <11956768412755-git-send-email-prohaska@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65729>

Hi,

On Wed, 21 Nov 2007, Steffen Prohaska wrote:

> We have a function set_git_dir().  So let's use it, instead of setting 
> the evironment directly.

Does this not have a fundamental issue?  When you call other git programs 
with run_command(), you _need_ GIT_DIR to be set, no?

Ciao,
Dscho
