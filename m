From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: t5541-http-push hanging
Date: Wed, 11 Nov 2009 07:50:25 -0800
Message-ID: <20091111155025.GN11919@spearce.org>
References: <B17AB159-E217-4E1F-BEA3-97E5892C13F4@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 16:50:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8FSp-0002DP-CB
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 16:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757434AbZKKPuU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 10:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757389AbZKKPuU
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 10:50:20 -0500
Received: from george.spearce.org ([209.20.77.23]:47589 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756348AbZKKPuT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 10:50:19 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 701FD381FC; Wed, 11 Nov 2009 15:50:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <B17AB159-E217-4E1F-BEA3-97E5892C13F4@gernhardtsoftware.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132666>

Brian Gernhardt <brian@gernhardtsoftware.com> wrote:
> brian@hermes httpd (master)$ cat error.log 
> [Wed Nov 11 06:19:39 2009] [notice] Apache/2.2.13 (Unix) configured -- resuming normal operations
> [Wed Nov 11 06:19:39 2009] [error] [client 127.0.0.1] git-http-backend(59490) malloc: *** error for object 0x100200340: incorrect checksum for freed object - object was probably modified after being freed.
> [Wed Nov 11 06:19:39 2009] [error] [client 127.0.0.1] *** set a breakpoint in malloc_error_break to debug
> [Wed Nov 11 06:19:40 2009] [error] [client 127.0.0.1] Premature end of script headers: git-http-backend
> [Wed Nov 11 06:24:23 2009] [notice] caught SIGTERM, shutting down--

Yikes, looks like git-http-backend corrupted its heap.

Is this by any chance Mac OS X ?

-- 
Shawn.
