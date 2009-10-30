From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 10/19] Allow helpers to request marks for fast-import
Date: Fri, 30 Oct 2009 09:21:00 +0100
Message-ID: <200910300921.00561.johan@herland.net>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com>
 <1256839287-19016-11-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 09:21:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3mjt-0005CJ-DB
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 09:21:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756301AbZJ3IVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 04:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755540AbZJ3IVT
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 04:21:19 -0400
Received: from smtp.getmail.no ([84.208.15.66]:42441 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755275AbZJ3IU6 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 04:20:58 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KSB000VQJ72B8B0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 30 Oct 2009 09:21:02 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KSB0043TJ70OD50@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Fri, 30 Oct 2009 09:21:02 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.10.30.80327
User-Agent: KMail/1.12.2 (Linux/2.6.30-ARCH; KDE/4.3.2; x86_64; ; )
In-reply-to: <1256839287-19016-11-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131678>

On Thursday 29 October 2009, Sverre Rabbelier wrote:
> From: Johan Herland <johan@herland.net>
> 
> The 'marks' capability is reported by the remote helper if it requires
> the fast-import marks database to loaded/saved by any git-fast-import
> process that is provided by the transport machinery. The feature is
> advertised along with exactly one argument: the location of the file
> containing the marks database.
> 
> Signed-off-by: Johan Herland <johan@herland.net>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> 
> 	Unchanged.

Please drop this patch from the series. The functionality is not needed, 
since we'll use the fast-import "option" command from the sr/gfi-options 
series instead.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
