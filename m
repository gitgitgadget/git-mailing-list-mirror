From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] pretty format now configurable
Date: Fri, 29 Feb 2008 21:51:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802292150350.22527@racer.site>
References: <1204314263-8072-1-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Denis Cheng <crquan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 22:52:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVD9b-0001e6-2J
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 22:52:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934081AbYB2Vvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 16:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934088AbYB2Vvx
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 16:51:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:38699 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934075AbYB2Vvw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 16:51:52 -0500
Received: (qmail invoked by alias); 29 Feb 2008 21:51:50 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp014) with SMTP; 29 Feb 2008 22:51:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19CWJ9CTTlCZKXFOAPKrB8zcsp5KRmE6AA12F0dWM
	cOkwmnFiY2HquD
X-X-Sender: gene099@racer.site
In-Reply-To: <1204314263-8072-1-git-send-email-crquan@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75571>

Hi,

On Sat, 1 Mar 2008, Denis Cheng wrote:

> Signed-off-by: Denis Cheng <crquan@gmail.com>
> ---
>  builtin-log.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/builtin-log.c b/builtin-log.c
> index bbadbc0..0f7ee1f 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -20,6 +20,7 @@
>  
>  static int default_show_root = 1;
>  static const char *fmt_patch_subject_prefix = "PATCH";
> +static const char *fmt_pretty;

Don't you want to initialise this?

Ciao,
Dscho
