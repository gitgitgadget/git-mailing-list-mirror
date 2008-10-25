From: Pascal Obry <pascal@obry.net>
Subject: Re: Problem with git filter-branch
Date: Sat, 25 Oct 2008 22:55:11 +0200
Organization: Home - http://www.obry.net
Message-ID: <490387AF.8080308@obry.net>
References: <4902E7D8.6050401@obry.net> <alpine.DEB.1.00.0810252235040.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 25 22:56:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtqBh-0001Dd-QM
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 22:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbYJYUzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 16:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbYJYUzV
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 16:55:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:22842 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbYJYUzV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 16:55:21 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1387190fgg.17
        for <git@vger.kernel.org>; Sat, 25 Oct 2008 13:55:19 -0700 (PDT)
Received: by 10.86.59.2 with SMTP id h2mr1581262fga.73.1224968119390;
        Sat, 25 Oct 2008 13:55:19 -0700 (PDT)
Received: from ?192.168.0.100? (AVelizy-154-1-40-132.w82-124.abo.wanadoo.fr [82.124.144.132])
        by mx.google.com with ESMTPS id 12sm3122489fgg.0.2008.10.25.13.55.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 25 Oct 2008 13:55:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.17) Gecko/20080914 Thunderbird/2.0.0.17 Mnenhy/0.7.5.0
In-Reply-To: <alpine.DEB.1.00.0810252235040.22125@pacific.mpi-cbg.de.mpi-cbg.de>
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99128>


Hi Johannes,

> It is a (maybe ill-conceived) feature.  When branches are rewritten, their 
> original versions are stored in the refs/original/ namespace.  You can 
> force overwriting with "-f".

Working fine indeed with -f option. What's strange is that it used to
work without the -f option. Would be nice to improve the error message
in this specific case.

Anyway, thanks a lot.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
