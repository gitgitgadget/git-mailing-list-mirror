From: Pascal Obry <pascal@obry.net>
Subject: git svn and the post-receive hook
Date: Sat, 02 Aug 2008 18:05:16 +0200
Organization: Home - http://www.obry.net
Message-ID: <489485BC.1020607@obry.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 18:06:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPJck-0002Ak-LH
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 18:06:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbYHBQF3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 12:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbYHBQF2
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 12:05:28 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:65000 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057AbYHBQF2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 12:05:28 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1254253fkq.5
        for <git@vger.kernel.org>; Sat, 02 Aug 2008 09:05:26 -0700 (PDT)
Received: by 10.180.234.10 with SMTP id g10mr4472688bkh.16.1217693126523;
        Sat, 02 Aug 2008 09:05:26 -0700 (PDT)
Received: from ?192.168.0.100? ( [82.124.74.244])
        by mx.google.com with ESMTPS id d13sm2519783fka.3.2008.08.02.09.05.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Aug 2008 09:05:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.16) Gecko/20080708 Thunderbird/2.0.0.16 Mnenhy/0.7.5.0
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91150>


At the moment it seems to me that the post-receive hook is not called 
when tracking a remove Subversion repository.

I think it would be nice to call the post-receive hook at the end of:

    $ git svn rebase

Why I need this?

I'd like to check for example that if a file has been added to the 
remote Subversion repository then it is properly added into a MANIFEST 
file. I'd also like to check some style rules. This would help to detect 
some problems when one has no way to add hooks on the Subversion repository.

I have zero experience with Perl so I do not feel like hacking this myself.

What do you think?

Is this already possible (I may have missed something)?

Thanks,
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
