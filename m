From: Pascal Obry <pascal@obry.net>
Subject: Question about git rebase --onto
Date: Tue, 02 Feb 2010 18:49:29 +0100
Organization: Home - http://www.obry.net
Message-ID: <4B6865A9.60603@obry.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 02 18:49:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcMsF-00056t-R1
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 18:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755013Ab0BBRtK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 12:49:10 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:52607 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024Ab0BBRtI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 12:49:08 -0500
Received: by ey-out-2122.google.com with SMTP id 25so81430eya.5
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 09:49:06 -0800 (PST)
Received: by 10.213.54.13 with SMTP id o13mr1002809ebg.68.1265132946234;
        Tue, 02 Feb 2010 09:49:06 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-45-106.w82-124.abo.wanadoo.fr [82.124.149.106])
        by mx.google.com with ESMTPS id 16sm4684195ewy.10.2010.02.02.09.49.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Feb 2010 09:49:03 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138732>


It seems to me that:

   $ git co topic
   $ git rebase --onto master topic~2 topic

Used to do the job and rebase the topic branch as expected. Today when I
tried with 1.7.0.rc1.10.gb8bb after the rebase above I was left on a
detached head.

Is my recollection wrong? Has this been changed recently?

Thanks,
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
