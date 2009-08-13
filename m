From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/4] fast-import: add option command
Date: Thu, 13 Aug 2009 07:45:39 -0700
Message-ID: <20090813144539.GL1033@spearce.org>
References: <1250140186-12363-1-git-send-email-srabbelier@gmail.com> <1250140186-12363-2-git-send-email-srabbelier@gmail.com> <1250140186-12363-3-git-send-email-srabbelier@gmail.com> <1250140186-12363-4-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 16:45:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbbYt-0005jW-Dk
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 16:45:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbZHMOpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 10:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752907AbZHMOpi
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 10:45:38 -0400
Received: from george.spearce.org ([209.20.77.23]:42671 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbZHMOph (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 10:45:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0DE86381FD; Thu, 13 Aug 2009 14:45:39 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1250140186-12363-4-git-send-email-srabbelier@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125824>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> This allows the frontend to specify any of the supported options as
> long as no non-option command has been given. This way the
> user does not have to include any frontend-specific options, but
> instead she can rely on the frontend to tell fast-import what it
> needs.
> ---

Missing Signed-off-by.
 
> @@ -2460,6 +2465,16 @@ static void parse_one_option(const char *option)
>      }
>  }
>  
> +static void parse_option(void)
> +{
> +    char* option = command_buf.buf + 7;

Git style is "char *option", isn't it?

> +
> +	if (seen_non_option_command)
> +		die("Got option command '%s' after non-option command", option);

Indentation is messed up here.  1 tab per level, please.

-- 
Shawn.
