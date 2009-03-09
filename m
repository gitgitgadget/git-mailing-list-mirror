From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Append ampersand to "Target" of lnk files created by
	do_cygwin_shortcut
Date: Mon, 9 Mar 2009 16:23:00 -0700
Message-ID: <20090309232300.GK11989@spearce.org>
References: <530ac78e0903091509y5209dec9q4c716d1e400357f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Phil Lawrence <prlawrence@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 00:24:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgopl-0004Ez-4V
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 00:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752525AbZCIXXG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 19:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752204AbZCIXXF
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 19:23:05 -0400
Received: from george.spearce.org ([209.20.77.23]:34688 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbZCIXXE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 19:23:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 0EE6E38211; Mon,  9 Mar 2009 23:23:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <530ac78e0903091509y5209dec9q4c716d1e400357f3@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112761>

Phil Lawrence <prlawrence@gmail.com> wrote:
> From 0780db8d53bdd0bb02b154d23c3c80bcccc0d955 Mon Sep 17 00:00:00 2001
> From: Phil Lawrence <prlawrence@gmail.com>
> Date: Thu, 5 Mar 2009 17:56:58 -0600
> Subject: [PATCH] Append ampersand to "Target" of lnk files created by
> do_cygwin_shortcut
> 
> The git-gui menu item "Repository | Create Desktop Icon" creates a
> shortcut (.lnk file) on the Windows desktop.  The purpose of the
> created shortcut is to make it easy for a user to launch git-gui
> for a particular repo in the future.

Thanks.  The patch was white space damaged, but being only 2
characters it was easier for me to just redo the change than
to ask you to resend the patch.
 
> @@ -54,7 +54,7 @@ proc do_cygwin_shortcut {} {
>                                         $argv0]
>                                 win32_create_lnk $fn [list \
>                                         $sh -c \
> -                                       "CHERE_INVOKING=1 source
> /etc/profile;[sq $me]" \
> +                                       "CHERE_INVOKING=1 source
> /etc/profile;[sq $me] &" \
>                                         ] \
>                                         [file dirname [file normalize [gitdir]]]
>                         } err]} {

-- 
Shawn.
