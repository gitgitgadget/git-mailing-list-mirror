From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] Improve message-id generation flow control for
 format-patch
Date: Tue, 19 Feb 2008 13:01:26 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802191300510.30505@racer.site>
References: <cover.1203392527.git.barkalow@iabervon.org> <alpine.LNX.1.00.0802182254110.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 14:02:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRS6z-0004Pq-9L
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 14:02:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbYBSNBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 08:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbYBSNBm
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 08:01:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:36962 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752614AbYBSNBl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 08:01:41 -0500
Received: (qmail invoked by alias); 19 Feb 2008 13:01:39 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp001) with SMTP; 19 Feb 2008 14:01:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18bPXs17u4bMdU+oBOsryvZUsolv2/bd5MBv4AMcq
	PsK2yRJQlInlnC
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LNX.1.00.0802182254110.5816@iabervon.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74397>

Hi,

On Mon, 18 Feb 2008, Daniel Barkalow wrote:

> diff --git a/revision.h b/revision.h
> index 8572315..e3559d0 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -74,7 +74,7 @@ struct rev_info {
>  	struct log_info *loginfo;
>  	int		nr, total;
>  	const char	*mime_boundary;
> -	const char	*message_id;
> +	char		*message_id;
>  	const char	*ref_message_id;
>  	const char	*add_signoff;
>  	const char	*extra_headers;

Mini-nit: technically, ref_message_id should be "char *", too.

Ciao,
Dscho
