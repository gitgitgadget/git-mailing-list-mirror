From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Change "refs/" references to symbolic constants
Date: Mon, 19 Feb 2007 23:08:32 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702192307240.14047@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702191839.05784.andyparkins@gmail.com>
 <7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 19 23:09:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJGgy-000438-Sm
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 23:09:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbXBSWIl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 17:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbXBSWIk
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 17:08:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:34694 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965063AbXBSWIj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 17:08:39 -0500
Received: (qmail invoked by alias); 19 Feb 2007 22:08:38 -0000
X-Provags-ID: V01U2FsdGVkX1/3PLRXfZ33zOK6HAg0SiDEzJDzMZzBFoYGIjGI+E
	PvRg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40154>

Hi,

On Mon, 19 Feb 2007, Junio C Hamano wrote:

> These repeated strncmp(p, X, STRLEN_X) almost makes me wonder if we want 
> to introduce:
> 
> 	inline int prefixcmp(a, b)
>         {
>         	return (strncmp(a, b, strlen(b));
>         }
> 
> with clever preprocessor optimization to have compiler do strlen() when 
> b is a string literal.

I am in favour of that. BTW I remember that Han-Wen suggested this some 
time ago, too.

Ciao,
Dscho
