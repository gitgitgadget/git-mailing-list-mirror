From: Pascal Obry <pascal@obry.net>
Subject: Git tree/blob and corresponding commit
Date: Sun, 10 Aug 2008 19:08:27 +0200
Organization: Home - http://www.obry.net
Message-ID: <489F208B.2070006@obry.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 10 19:09:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSEQD-0005UD-HE
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 19:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753298AbYHJRIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 13:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753291AbYHJRIf
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 13:08:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:53806 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286AbYHJRIf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 13:08:35 -0400
Received: by fg-out-1718.google.com with SMTP id 19so873549fgg.17
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 10:08:32 -0700 (PDT)
Received: by 10.86.26.1 with SMTP id 1mr6507350fgz.35.1218388112158;
        Sun, 10 Aug 2008 10:08:32 -0700 (PDT)
Received: from ?192.168.0.100? ( [86.205.108.90])
        by mx.google.com with ESMTPS id l19sm114134fgb.7.2008.08.10.10.08.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Aug 2008 10:08:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr-FR; rv:1.8.1.16) Gecko/20080708 Thunderbird/2.0.0.16 Mnenhy/0.7.5.0
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91859>


Something I'm trying to figure out and can't find the answer myself. I'm 
browsing a tree, for example:

    $ git ls-tree HEAD~100

This list a set of files with the corresponding blob. Each blob has it's 
own SHA1. Fine.

Now given a SHA1 I'd like to know which commit has created (was 
containing) this specific blob?

What is the best way to achieve that?

Thanks.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
