From: Pascal Obry <pascal@obry.net>
Subject: Re: [PATCH] Add format-patch option --no-name-prefix.
Date: Tue, 18 Dec 2007 16:47:03 +0100
Organization: Home - http://www.obry.net
Message-ID: <4767EB77.4060106@obry.net>
References: <1197992574-3464-1-git-send-email-pascal@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 18 16:47:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4efO-0001yx-R1
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 16:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756656AbXLRPrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 10:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757937AbXLRPrK
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 10:47:10 -0500
Received: from smtp2a.orange.fr ([80.12.242.140]:35515 "EHLO smtp2a.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757856AbXLRPrH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 10:47:07 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2a26.orange.fr (SMTP Server) with ESMTP id A61B070000B4
	for <git@vger.kernel.org>; Tue, 18 Dec 2007 16:47:05 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-60-249.w82-124.abo.wanadoo.fr [82.124.126.249])
	by mwinf2a26.orange.fr (SMTP Server) with ESMTP id 7D05370000B0
	for <git@vger.kernel.org>; Tue, 18 Dec 2007 16:47:05 +0100 (CET)
X-ME-UUID: 20071218154705512.7D05370000B0@mwinf2a26.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <1197992574-3464-1-git-send-email-pascal@obry.net>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68765>


To give a bit of context about this patch. I need to send changeset to a
server by e-mail for testing purpose before committing. The server is
assuming that the patch can be applied with "patch -p0 < file" from the
repository root. The option --no-name-prefix does just that, removing
the leading 'a/' and 'b/'.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
