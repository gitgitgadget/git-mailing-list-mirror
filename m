From: Pascal Obry <pascal@obry.net>
Subject: Re: Subversion integration with git
Date: Thu, 25 Mar 2010 19:23:44 +0100
Organization: Home - http://www.obry.net
Message-ID: <4BABAA30.3080806@obry.net>
References: <3311ED3F-77BC-4F66-80D5-AA9E21ACF0E2@cordelta.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: David Michael Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Thu Mar 25 19:23:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuriP-0004ZW-EU
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 19:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813Ab0CYSX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 14:23:28 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:37408 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529Ab0CYSX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 14:23:27 -0400
Received: by bwz1 with SMTP id 1so1139549bwz.21
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 11:23:26 -0700 (PDT)
Received: by 10.204.126.84 with SMTP id b20mr36066bks.61.1269541405328;
        Thu, 25 Mar 2010 11:23:25 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-77-142.w86-205.abo.wanadoo.fr [86.205.47.142])
        by mx.google.com with ESMTPS id a11sm12025967bkc.15.2010.03.25.11.23.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Mar 2010 11:23:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <3311ED3F-77BC-4F66-80D5-AA9E21ACF0E2@cordelta.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143189>

David,

> My project is still in the preview phase but has enough to import 
> commit-tree structure bar symlinks and executable flags. It imports 
> my 22000+ commit 2.8GB dump in 4 minutes. It is currently 840 
> non-comment lines of C. I aim to produce output that git-svn can
> take over from.

Impressive numbers! I've converted many projects using git-svn and yes
it is slow. Just curious, does it handles branches? Can it handles not
standard layout (trunk/branch/tags)? When you have a git-svn compatible
output I would be willing to test it on a project.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
