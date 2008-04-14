From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-apply: Show a more descriptive error on failure
 when opening a patch
Date: Mon, 14 Apr 2008 15:33:54 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804141532390.28504@racer>
References: <7vtzi5bkdz.fsf@gitster.siamese.dyndns.org> <1208183018-27887-1-git-send-email-albertito@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Alberto Bertogli <albertito@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 16:42:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlPlq-0003yW-M5
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 16:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757013AbYDNOd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 10:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756763AbYDNOd5
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 10:33:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:35828 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757013AbYDNOd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 10:33:57 -0400
Received: (qmail invoked by alias); 14 Apr 2008 14:33:54 -0000
Received: from unknown (EHLO racer.local) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 14 Apr 2008 16:33:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19J2zZ52UBJe6XG8f+svokUlmO8UTmZ66ZbsjQh1F
	1QrIyTyDOiJpbg
X-X-Sender: gene099@racer
In-Reply-To: <1208183018-27887-1-git-send-email-albertito@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79506>

Hi,

On Mon, 14 Apr 2008, Alberto Bertogli wrote:

> +		if (fd < 0) {
> +			error("can't open patch '%s': %s", arg,
> +					strerror(errno));
> +			return 1;
> +		}

Do you absolutely want to retain the curly braces, and have two 
statements?   I would prefer "return error(...)", and if you absolutely 
insist on a return 1: "return !!error(...)".

Ciao,
Dscho
