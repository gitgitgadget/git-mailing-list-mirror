From: Pascal Obry <pascal@obry.net>
Subject: Re: git-svn: .git/svn disk usage
Date: Mon, 03 Dec 2007 07:37:51 +0100
Organization: Home - http://www.obry.net
Message-ID: <4753A43F.9060303@obry.net>
References: <65dd6fd50712022217l5f807f31pf3f00d82c3dccf5c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ollie Wild <aaw@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 07:38:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz4wa-0002t0-1G
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 07:38:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752490AbXLCGh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 01:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752600AbXLCGh6
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 01:37:58 -0500
Received: from smtp2e.orange.fr ([80.12.242.113]:46101 "EHLO smtp2e.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127AbXLCGh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 01:37:57 -0500
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf2e22.orange.fr (SMTP Server) with ESMTP id C9D567000091
	for <git@vger.kernel.org>; Mon,  3 Dec 2007 07:37:56 +0100 (CET)
Received: from [192.168.0.100] (AVelizy-151-1-88-105.w86-205.abo.wanadoo.fr [86.205.126.105])
	by mwinf2e22.orange.fr (SMTP Server) with ESMTP id 84A0F700008F;
	Mon,  3 Dec 2007 07:37:56 +0100 (CET)
X-ME-UUID: 20071203063756543.84A0F700008F@mwinf2e22.orange.fr
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <65dd6fd50712022217l5f807f31pf3f00d82c3dccf5c@mail.gmail.com>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66876>

Ollie,

> I'm curious if other developers have run into this issue.  If so, are
> there any proposals / plans for improving the storage of git-svn
> metadata?

Did you run "git gc" after importing code form the subversion
repository? On my side I found that it has reduced drastically the size
of the local Git repository.

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
