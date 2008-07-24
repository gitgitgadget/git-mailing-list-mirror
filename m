From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 7/9] builtin-checkout-index.c: use parse_options()
Date: Thu, 24 Jul 2008 15:44:26 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807241543190.8986@racer>
References: <1216849332-26813-1-git-send-email-barra_cuda@katamail.com> <1216849332-26813-8-git-send-email-barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 16:47:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM26H-0002uX-GP
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 16:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757383AbYGXOod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 10:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757370AbYGXOob
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 10:44:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:50200 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756649AbYGXOoZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 10:44:25 -0400
Received: (qmail invoked by alias); 24 Jul 2008 14:44:23 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp013) with SMTP; 24 Jul 2008 16:44:23 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/gcNo4EtfgoLLdfJmVq9dheI3StxHBNgWS0eapA6
	GugOyi4O7qMWkO
X-X-Sender: gene099@racer
In-Reply-To: <1216849332-26813-8-git-send-email-barra_cuda@katamail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89890>

Hi,

On Wed, 23 Jul 2008, Michele Ballabio wrote:

> +		{ OPTION_CALLBACK, 'f', "force", &state, NULL,
> +		  "force overwrite of existing files",
> +		  PARSE_OPT_NOARG, parse_state_force_cb, 0 },

I wonder if this could not be written as

		OPT_BOOLEAN('f', "force", &state.force,
			"force overwrite of existing files"),

Ciao,
Dscho
