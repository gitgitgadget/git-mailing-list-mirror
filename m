From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v2] Support copy and rename detection in fast-export.
Date: Sat, 26 Jul 2008 15:21:03 -0500
Message-ID: <20080726202103.GA15769@spearce.org>
References: <200807211216.01694.angavrilov@gmail.com> <alpine.DEB.1.00.0807211207470.3305@eeepc-johanness> <200807262249.18005.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alexander Gavrilov <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 26 22:22:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMqHH-0007K7-9h
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 22:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757490AbYGZUVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 16:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756605AbYGZUVG
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 16:21:06 -0400
Received: from george.spearce.org ([209.20.77.23]:51584 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757490AbYGZUVF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 16:21:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id C6474383A5; Sat, 26 Jul 2008 20:21:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200807262249.18005.angavrilov@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90280>

Alexander Gavrilov <angavrilov@gmail.com> wrote:
> This patch makes fast-export output correct action
> logs when -M or -C are enabled.
...
> +-M, -C::
> +	Perform move and/or copy detection, as described in the
> +	linkgit:git-diff[1] manual page, and use it to generate
> +	rename and copy commands in the output dump.
> ++
> +Note that these options are always accepted by git-fast-import,
> +but before a certain version it silently produced wrong results.
> +You should always check the git version before using them.

Do you mean to say git-fast-export in the end of the first line of
that last paragraph?

-- 
Shawn.
