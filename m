From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] http-backend: Let gcc check the format of more
	printf-type functions.
Date: Sun, 15 Nov 2009 17:39:11 -0800
Message-ID: <20091116013911.GY11919@spearce.org>
References: <1258233058-2348-1-git-send-email-tarmigan+git@gmail.com> <1258233058-2348-2-git-send-email-tarmigan+git@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tarmigan Casebolt <tarmigan+git@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 16 02:39:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9qYo-0002jL-5M
	for gcvg-git-2@lo.gmane.org; Mon, 16 Nov 2009 02:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740AbZKPBjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 20:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbZKPBjG
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 20:39:06 -0500
Received: from george.spearce.org ([209.20.77.23]:56638 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbZKPBjG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 20:39:06 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 98F4C381D5; Mon, 16 Nov 2009 01:39:11 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1258233058-2348-2-git-send-email-tarmigan+git@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132981>

Tarmigan Casebolt <tarmigan+git@gmail.com> wrote:
> We already have these checks in many printf-type functions that have
> prototypes which are in header files.  Add these same checks to
> static functions in http-backend.c
> 
> Signed-off-by: Tarmigan Casebolt <tarmigan+git@gmail.com>
> ---
> 
> Shawn, please consider this patch in addition to the one that you posted 
> that actually fixes the bug.  With this patch, gcc will warn about that bug.

Yup, it would have caught it, thanks.

Acked-by: Shawn O. Pearce <spearce@spearce.org>
 
-- 
Shawn.
