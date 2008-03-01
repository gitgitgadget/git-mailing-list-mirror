From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] add pretty format configuration to git
 log/show/whatchanged
Date: Sat, 1 Mar 2008 18:22:10 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803011821420.22527@racer.site>
References: <alpine.LFD.1.00.0802291155550.17889@woody.linux-foundation.org> <1204391724-566-1-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Denis Cheng <crquan@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 19:23:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVWMz-0004Qf-RA
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 19:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbYCASWy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 13:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbYCASWy
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 13:22:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:47995 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751045AbYCASWx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 13:22:53 -0500
Received: (qmail invoked by alias); 01 Mar 2008 18:22:51 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp052) with SMTP; 01 Mar 2008 19:22:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/gHbAGVuPgmaQI08y4KwAIUe9lBCx1Q3cVyesJw5
	q64etqeZKYj2tY
X-X-Sender: gene099@racer.site
In-Reply-To: <1204391724-566-1-git-send-email-crquan@gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75690>

Hi,

On Sun, 2 Mar 2008, Denis Cheng wrote:

> diff --git a/builtin-log.c b/builtin-log.c
> index bbadbc0..0f7ee1f 100644
> --- a/builtin-log.c
> +++ b/builtin-log.c
> @@ -20,6 +20,7 @@
>  
>  static int default_show_root = 1;
>  static const char *fmt_patch_subject_prefix = "PATCH";
> +static const char *fmt_pretty;

I still think this should default to CMIT_FMT_DEFAULT.

Ciao,
Dscho
