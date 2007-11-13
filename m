From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/11] Introduce git_etc_gitconfig() that encapsulates
 access of ETC_GITCONFIG.
Date: Tue, 13 Nov 2007 21:22:23 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711132121440.4362@racer.site>
References: <1194984306-3181-1-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-2-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-3-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-4-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-5-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-6-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-7-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-8-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-9-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-10-git-send-email-johannes.sixt@telecom.at>
 <1194984306-3181-11-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Tue Nov 13 22:23:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is3Do-0005jv-6Q
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 22:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759246AbXKMVWo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 16:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757713AbXKMVWo
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 16:22:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:60756 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756912AbXKMVWn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 16:22:43 -0500
Received: (qmail invoked by alias); 13 Nov 2007 21:22:41 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp040) with SMTP; 13 Nov 2007 22:22:41 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+UToYdtK6Uuup5szM6+gdCrbDaRzeGTa18opwo2I
	IxQB+UChooS7nb
X-X-Sender: gene099@racer.site
In-Reply-To: <1194984306-3181-11-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64870>

Hi,

On Tue, 13 Nov 2007, Johannes Sixt wrote:

> diff --git a/config.c b/config.c
> index dc3148d..dd7e9ad 100644
> --- a/config.c
> +++ b/config.c
> @@ -452,6 +452,11 @@ int git_config_from_file(config_fn_t fn, const char *filename)
>  	return ret;
>  }
>  
> +const char *git_etc_gitconfig(void)
> +{
> +	return ETC_GITCONFIG;
> +}
> +

Wouldn't this logically belong into environment.c?

Ciao,
Dscho
