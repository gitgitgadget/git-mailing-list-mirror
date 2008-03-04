From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit f5bbc322 to git broke pre-commit hooks which read stdin
Date: Tue, 4 Mar 2008 12:04:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803041203320.22527@racer.site>
References: <0tableanpe.wl%bremner@pivot.cs.unb.ca> <alpine.LSU.1.00.0803041044120.22527@racer.site> <7vk5ki91zj.fsf@gitster.siamese.dyndns.org> <0t4pbmaew9.wl%bremner@pivot.cs.unb.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: David Bremner <bremner@unb.ca>
X-From: git-owner@vger.kernel.org Tue Mar 04 13:06:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWVu2-0003nc-HG
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 13:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757468AbYCDMFB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 07:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757368AbYCDMFB
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 07:05:01 -0500
Received: from mail.gmx.net ([213.165.64.20]:45236 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756793AbYCDMFA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 07:05:00 -0500
Received: (qmail invoked by alias); 04 Mar 2008 12:04:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp015) with SMTP; 04 Mar 2008 13:04:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+kOhJVUaek5nK+uW0VYbHaioDeGTiqIwn2C6lZAN
	cflwovQ7709Uit
X-X-Sender: gene099@racer.site
In-Reply-To: <0t4pbmaew9.wl%bremner@pivot.cs.unb.ca>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76075>

Hi,

On Tue, 4 Mar 2008, David Bremner wrote:

> >>>>> "Junio" == Junio C Hamano <gitster@pobox.com> writes:
> 
>     Junio> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>     >> Pardon my ignorance, but what business has metastore reading
>     >> stdin?  There should be nothing coming in, so the change you
>     >> mentioned should be correct, and your hook relies on something
>     >> it should not rely on.
> 
>     Junio> It is not metastore.  It is an interactive hook that reads
>     Junio> from the user who is sitting on the terminal and invoked
>     Junio> the git-commit program.
> 
> Yeah, I should have been more explicit. The problem is a line 
> 
>       read -N1 VAR

Can you be even more explicit?  IOW why does this have to be a pre-commit 
hook, and cannot be done before calling git-commit itself?

Ciao,
Dscho
