From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] branch: optionally setup branch.*.merge from upstream
	local branches
Date: Tue, 19 Feb 2008 08:44:23 +0100
Message-ID: <20080219074423.GA3982@steel.home>
References: <1203386832-43969-1-git-send-email-jaysoffian@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 08:45:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRN9y-0007CV-6L
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 08:45:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760821AbYBSHo2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 02:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760744AbYBSHo2
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 02:44:28 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:17397 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756166AbYBSHo1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 02:44:27 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz0wOGI88U=
Received: from tigra.home (Faf77.f.strato-dslnet.de [195.4.175.119])
	by post.webmailer.de (fruni mo46) (RZmta 16.5)
	with ESMTP id D0350dk1J25dWV ; Tue, 19 Feb 2008 08:44:24 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 19459277BD;
	Tue, 19 Feb 2008 08:44:24 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 771DF56D24; Tue, 19 Feb 2008 08:44:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1203386832-43969-1-git-send-email-jaysoffian@gmail.com>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74387>

Jay Soffian, Tue, Feb 19, 2008 03:07:12 +0100:
> diff --git a/cache.h b/cache.h
> index 2b59c44..3c17e2c 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -393,6 +393,14 @@ enum safe_crlf {
>  
>  extern enum safe_crlf safe_crlf;
>  
> +enum branch_track {
> +	BRANCH_TRACK_NEVER = 0,

enums start at 0 anyway, don't they?

> +	BRANCH_TRACK_REMOTE,
> +	BRANCH_TRACK_ALWAYS,
> +};
