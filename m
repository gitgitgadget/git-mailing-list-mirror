From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-config: print error message if the config file cannot
 be read
Date: Tue, 9 Oct 2007 14:16:41 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710091416090.4174@racer.site>
References: <20071009125102.1305.qmail@054bd0fc8effa5.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Tue Oct 09 15:17:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfExR-0000PW-Fs
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 15:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbXJINQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 09:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbXJINQ7
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 09:16:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:38745 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750983AbXJINQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 09:16:59 -0400
Received: (qmail invoked by alias); 09 Oct 2007 13:16:57 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 09 Oct 2007 15:16:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DXjFCfMJD+pyLVq7GYW5qO2awNw+RuyxGM+kP30
	yyUgI6iL61PhA2
X-X-Sender: gene099@racer.site
In-Reply-To: <20071009125102.1305.qmail@054bd0fc8effa5.315fe32.mid.smarden.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60409>

Hi,

On Tue, 9 Oct 2007, Gerrit Pape wrote:

> +		if (git_config(show_all_config) == -1)

I'd rather check for < 0, just for future proofing.

Ciao,
Dscho
