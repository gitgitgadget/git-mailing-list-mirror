From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make rebase--interactive use OPTIONS_SPEC
Date: Sat, 12 Jul 2008 17:28:54 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807121728180.8950@racer>
References: <1215877700-17080-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Sat Jul 12 18:30:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHhzW-0001pf-Pk
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 18:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbYGLQ2z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 12:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752375AbYGLQ2z
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 12:28:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:47374 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751370AbYGLQ2y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 12:28:54 -0400
Received: (qmail invoked by alias); 12 Jul 2008 16:28:52 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp005) with SMTP; 12 Jul 2008 18:28:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+PqD5Ac3mP9EIuaiZZnWYZb/hdGLrndDuUF931Mt
	8yOnJfJgiUh94E
X-X-Sender: gene099@racer
In-Reply-To: <1215877700-17080-1-git-send-email-s-beyer@gmx.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88255>

Hi,

On Sat, 12 Jul 2008, Stephan Beyer wrote:

> +	--onto)
> +		shift
> +		ONTO=$(git rev-parse --verify "$1") ||
> +			die "Does not point to a valid commit: $1"

Didn't you have some check earlier that "--onto" can only be used when 
starting a rebase?

Otherwise: ACK.

Ciao,
Dscho
