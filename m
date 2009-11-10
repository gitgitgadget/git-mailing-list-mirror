From: Pascal Obry <pascal@obry.net>
Subject: git-svn problem with v1.6.5
Date: Tue, 10 Nov 2009 23:23:58 +0100
Organization: Home - http://www.obry.net
Message-ID: <4AF9E7FE.3060701@obry.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 10 23:24:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7z8G-00033d-4L
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 23:24:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757510AbZKJWXm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 17:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757384AbZKJWXm
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 17:23:42 -0500
Received: from mail-ew0-f207.google.com ([209.85.219.207]:38135 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754373AbZKJWXl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 17:23:41 -0500
Received: by ewy3 with SMTP id 3so567382ewy.37
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 14:23:46 -0800 (PST)
Received: by 10.213.2.73 with SMTP id 9mr779119ebi.21.1257891825655;
        Tue, 10 Nov 2009 14:23:45 -0800 (PST)
Received: from ?192.168.0.100? (AVelizy-154-1-81-24.w86-205.abo.wanadoo.fr [86.205.111.24])
        by mx.google.com with ESMTPS id 28sm2710558eyg.6.2009.11.10.14.23.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 14:23:45 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132601>


Hello,

A git-svn mirror is created using Git v1.6.4. When I copy this mirror 
into another machine which is using v1.6.5 I get the following error:

$ git svn rebase
fatal: Invalid revision range 
d2cf08bb67e4b7da33a250127aab784f1f2f58d3..refs/remotes/svn/trunk
rev-list --pretty=raw --no-color --reverse 
d2cf08bb67e4b7da33a250127aab784f1f2f58d3..refs/remotes/svn/trunk --: 
command returned error: 128

Using v1.6.4 instead I have no problem. Any idea to track this problem down?

Thanks.

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
