From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] quote_path: convert empty path to "./"
Date: Fri, 7 Dec 2007 18:54:07 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712071853500.27959@racer.site>
References: <20071207165703.GA8889@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 07 19:55:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0iMK-00071A-Un
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 19:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbXLGSzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 13:55:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753971AbXLGSzO
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 13:55:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:40594 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752612AbXLGSzM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 13:55:12 -0500
Received: (qmail invoked by alias); 07 Dec 2007 18:55:10 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp054) with SMTP; 07 Dec 2007 19:55:10 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18gVv1/xTwgppzYt709a70o+sYlZa2XlfOBYFELCp
	hBmgM39wome/6C
X-X-Sender: gene099@racer.site
In-Reply-To: <20071207165703.GA8889@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67440>

Hi,

On Fri, 7 Dec 2007, Jeff King wrote:

>   # Untracked files:
>   #   (use "git add <file>..." to include in what will be committed)
>   #
>   #       subdir/
> 
>   So far, so good.
> 
>   $ cd subdir
>   $ git status
>   ....
>   # Untracked files:
>   #   (use "git add <file>..." to include in what will be committed)
>   #
>   #
> 
>   Oops, that's a bit confusing.
> 
>   This patch prints './' to show that there is some output.

Sounds reasonable.

Ciao,
Dscho
