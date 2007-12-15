From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Make config_to_multi return [] instead of
	[undef]
Date: Sat, 15 Dec 2007 16:05:01 +0100
Message-ID: <20071215150501.GM10769@machine.or.cz>
References: <200712151534.50951.jnareb@gmail.com> <200712151536.33296.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 15 16:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3Ya8-0002R5-16
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 16:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757607AbXLOPFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 10:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756988AbXLOPFF
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 10:05:05 -0500
Received: from w241.dkm.cz ([62.24.88.241]:56588 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754212AbXLOPFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 10:05:04 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 932B65A73C; Sat, 15 Dec 2007 16:05:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200712151536.33296.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68391>

On Sat, Dec 15, 2007 at 03:36:32PM +0100, Jakub Narebski wrote:
> From: Petr Baudis <pasky@suse.cz>
> Date: Sat, 8 Dec 2007 12:30:59 +0100
> Subject: [PATCH] gitweb: Make config_to_multi return [] instead of [undef]
> 
> This is important for the list of clone urls, where if there are
> no per-repository clone URL configured, the default base URLs
> are never used for URL construction without this patch.
> 
> Add tests for different ways of setting project URLs, just in case.
> Note that those tests in current form wouldn't detect breakage fixed
> by this patch, as it only checks for errors and not for expected
> output.
> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

Acked-by: Petr Baudis <pasky@suse.cz>

Thank you all for catching the defined($val). :-)

-- 
				Petr "Pasky" Baudis
We don't know who it was that discovered water, but we're pretty sure
that it wasn't a fish.		-- Marshall McLuhan
