From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Provide a more JavaBeans-style 'getName' accessor
	for the id Signed-off-by: Alex Blewitt <alex.blewitt@gmail.com>
Date: Sun, 10 May 2009 14:19:00 -0700
Message-ID: <20090510211900.GB30527@spearce.org>
References: <1241909854-11498-1-git-send-email-alex.blewitt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: robin.rosenberg@dewire.com, git@vger.kernel.org
To: Alex Blewitt <alex.blewitt@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 10 23:19:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3GQQ-0001Kv-Tv
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 23:19:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753782AbZEJVTA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 May 2009 17:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752509AbZEJVS7
	(ORCPT <rfc822;git-outgoing>); Sun, 10 May 2009 17:18:59 -0400
Received: from george.spearce.org ([209.20.77.23]:51373 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbZEJVS7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 May 2009 17:18:59 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 651F8381D5; Sun, 10 May 2009 21:19:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1241909854-11498-1-git-send-email-alex.blewitt@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118748>

Alex Blewitt <alex.blewitt@gmail.com> wrote:
>  	/**
> +	 * @return string form of the SHA-1, in lower case hexadecimal.
> +	 */
> +	public final String getName() {
> +		return name();
> +	}
> +	/**

Ok, but how about unit tests?

-- 
Shawn.
