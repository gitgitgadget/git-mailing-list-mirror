From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 8/8] Allow helpers to request marks for fast-import
Date: Sun, 09 Aug 2009 23:25:52 +0200
Message-ID: <200908092325.53040.johan@herland.net>
References: <alpine.LNX.2.00.0908091527480.27553@iabervon.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 23:26:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaFu9-0007e4-PA
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 23:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbZHIVZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 17:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752099AbZHIVZy
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 17:25:54 -0400
Received: from smtp.getmail.no ([84.208.15.66]:40679 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751972AbZHIVZy (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Aug 2009 17:25:54 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO4004KBOV62U20@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Sun, 09 Aug 2009 23:25:54 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KO400EQYOV59D10@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Sun, 09 Aug 2009 23:25:54 +0200 (MEST)
X-PMX-Version: 5.5.5.374460, Antispam-Engine: 2.7.1.369594,
 Antispam-Data: 2009.8.9.211217
User-Agent: KMail/1.11.4 (Linux/2.6.30-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <alpine.LNX.2.00.0908091527480.27553@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125383>

On Sunday 09 August 2009, Daniel Barkalow wrote:
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

Note that this patch can be dropped if Sverre Rabbelier's suggestion of 
adding an "option" command to fast-import is accepted: 
http://thread.gmane.org/gmane.comp.version-control.git/124655

In that case, the CVS helper (or any other helper) can use the "option" 
fast-import command instead of having to tell transport-helper.c to invoke 
fast-import appropriately. Seems like a somewhat cleaner solution to me...


Have fun!

...Johan
