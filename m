From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] No color diff when redirecting to file
Date: Sun, 23 Jan 2011 15:47:17 +0100
Message-ID: <201101231547.18529.j6t@kdbg.org>
References: <201101231410.48528.saschpe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sascha Peilicke <saschpe@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jan 23 15:47:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ph1Dz-0007xF-Jf
	for gcvg-git-2@lo.gmane.org; Sun, 23 Jan 2011 15:47:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314Ab1AWOrW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Jan 2011 09:47:22 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:48747 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751095Ab1AWOrW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Jan 2011 09:47:22 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2A2BDCDF82;
	Sun, 23 Jan 2011 15:47:17 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 96CDA19F6B2;
	Sun, 23 Jan 2011 15:47:18 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <201101231410.48528.saschpe@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165426>

The subject line reads as if you want that color markup appears in a file.

On Sonntag, 23. Januar 2011, Sascha Peilicke wrote:
> Previously, when having color diffs enabled and redirecting 'git diff'
> into a file, one ends up with a messed up file containing termcap color
> stuff. This change disables color when diff output is redirected into a
> file.

But this description and the patch read as if you don't want it.

That said, I cannot reproduce. Perhaps your configuration says 
color.ui=always? If so, then this is expected behavior and not a bug, IMO.

-- Hannes
