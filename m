From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v3] remote-curl.c: fix rpc_out()
Date: Tue, 24 Nov 2009 14:43:31 -0800
Message-ID: <20091124224331.GK11919@spearce.org>
References: <20091124095508.d6312ab0.rctay89@gmail.com> <20091124103130.e1bdf09f.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	paulfred <paul.fredrickson@gmail.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 23:43:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND46j-0005Q2-KY
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 23:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934154AbZKXWn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 17:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934135AbZKXWn0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 17:43:26 -0500
Received: from george.spearce.org ([209.20.77.23]:38848 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934028AbZKXWnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 17:43:25 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id EF83F3842F; Tue, 24 Nov 2009 22:43:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091124103130.e1bdf09f.rctay89@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133596>

Tay Ray Chuan <rctay89@gmail.com> wrote:
> Remove the extraneous semicolon (';') at the end of the if statement
> that allowed the code in its block to execute regardless of the
> condition.
> 
> This fixes pushing to a smart http backend with chunked encoding.
> 
> Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>

Acked-by: Shawn O. Pearce <spearce@spearce.org>

Thanks for the fix, I can't believe I made this typo.  :-(

> -	if (max < avail);
> +	if (max < avail)
>  		avail = max;

-- 
Shawn.
