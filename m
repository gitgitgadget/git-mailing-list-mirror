From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add ability to specify SMTP server port when using
 git-send-email.
Date: Wed, 26 Sep 2007 00:05:02 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709260004090.28395@racer.site>
References: <1190759927-19493-1-git-send-email-glenn@rempe.us>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Glenn Rempe <glenn@rempe.us>
X-From: git-owner@vger.kernel.org Wed Sep 26 01:06:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaJTs-0000U5-HW
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 01:06:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbXIYXGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 19:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751303AbXIYXGI
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 19:06:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:41204 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750931AbXIYXGH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 19:06:07 -0400
Received: (qmail invoked by alias); 25 Sep 2007 23:06:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp039) with SMTP; 26 Sep 2007 01:06:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XT2EGoFnXD5kF2Q6pS4WsMPdOYHuLzpnh3OpJsW
	yukNiMUEXA8WtS
X-X-Sender: gene099@racer.site
In-Reply-To: <1190759927-19493-1-git-send-email-glenn@rempe.us>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59190>

Hi,

On Tue, 25 Sep 2007, Glenn Rempe wrote:

> +if (($smtp_server =~ /:\d+/) && (defined $smtp_server_port)) {

Not that I want to be a PITA, but this breaks down with IPv6, right?

Ciao,
Dscho
