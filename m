From: Pascal Obry <pascal@obry.net>
Subject: reverting initial commit
Date: Wed, 25 Mar 2009 19:12:56 +0100
Organization: Home - http://www.obry.net
Message-ID: <49CA7428.70400@obry.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 25 19:14:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmXcG-0007Fd-Qi
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 19:14:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730AbZCYSMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 14:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753220AbZCYSMp
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 14:12:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:54959 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbZCYSMp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 14:12:45 -0400
Received: by fg-out-1718.google.com with SMTP id e12so74869fga.17
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 11:12:42 -0700 (PDT)
Received: by 10.86.78.13 with SMTP id a13mr178699fgb.79.1238004761503;
        Wed, 25 Mar 2009 11:12:41 -0700 (PDT)
Received: from ?192.168.0.100? (AVelizy-154-1-49-205.w82-124.abo.wanadoo.fr [82.124.151.205])
        by mx.google.com with ESMTPS id 4sm6320167fgg.0.2009.03.25.11.12.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Mar 2009 11:12:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.21) Gecko/20090302 Thunderbird/2.0.0.21 Mnenhy/0.7.5.0
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114636>


Starting a new project I create a new repo and added some files for the
initial revision of the project, something like:

mkdir repo.git
cd repo.git
git init
touch file
git add file
git ci -m "initial revision"

Now one file was not meant to be committed, I wanted to revert this commit:

git reset HEAD^

fatal: ambiguous argument 'HEAD^': unknown revision or path not in the
working tree.
Use '--' to separate paths from revisions

I understand that HEAD^ does not exist, is there a way to do that?

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
