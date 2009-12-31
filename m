From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [PATCH] Provide a window icon on Windows platforms
Date: Thu, 31 Dec 2009 14:02:40 -0600
Message-ID: <20091231200240.GC13700@unpythonic.net>
References: <1262289470-4208-1-git-send-email-kirillathome@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Kirill <kirillathome@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 31 21:02:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQREM-0002bx-Sy
	for gcvg-git-2@lo.gmane.org; Thu, 31 Dec 2009 21:02:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbZLaUCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2009 15:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbZLaUCm
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Dec 2009 15:02:42 -0500
Received: from dsl.unpythonic.net ([206.222.212.217]:57598 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751129AbZLaUCm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2009 15:02:42 -0500
Received: by unpythonic.net (Postfix, from userid 1000)
	id 0099F24000A; Thu, 31 Dec 2009 14:02:40 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <1262289470-4208-1-git-send-email-kirillathome@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135970>

On Thu, Dec 31, 2009 at 02:57:50PM -0500, Kirill wrote:
> +	set ::tk::AlwaysShowSelection 1
> +
> +	# Spoof an X11 display for SSH
> +	if {![info exists env(DISPLAY)]} {
> +		set env(DISPLAY) :9999
> +	}

these bits look unrelated and should probably be in a separate
submission.
