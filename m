From: Prenom Nom <utilisateur_768@yahoo.fr>
Subject: git-cvsimport and i18n.commitencoding
Date: Thu, 12 Feb 2009 08:01:02 +0100
Message-ID: <4993C92E.7080909@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 08:07:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXVfN-00068v-6k
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 08:07:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757134AbZBLHFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 02:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757569AbZBLHFq
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 02:05:46 -0500
Received: from n4a.bullet.sp1.yahoo.com ([69.147.64.182]:36950 "HELO
	n4a.bullet.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757399AbZBLHFp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 02:05:45 -0500
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Feb 2009 02:05:45 EST
Received: from [216.252.122.216] by n4.bullet.sp1.yahoo.com with NNFMP; 12 Feb 2009 07:00:05 -0000
Received: from [87.248.110.137] by t1.bullet.sp1.yahoo.com with NNFMP; 12 Feb 2009 07:00:05 -0000
X-yahoo-newman-spamcop: yes
Received: from [217.146.182.178] by n20.bullet.mail.ukl.yahoo.com with NNFMP; 12 Feb 2009 06:58:22 -0000
Received: from [87.248.110.108] by t4.bullet.ukl.yahoo.com with NNFMP; 12 Feb 2009 06:58:22 -0000
Received: from [127.0.0.1] by omp213.mail.ukl.yahoo.com with NNFMP; 12 Feb 2009 06:58:22 -0000
X-Yahoo-Newman-Id: 948499.56279.bm@omp213.mail.ukl.yahoo.com
Received: (qmail 57538 invoked from network); 12 Feb 2009 06:58:22 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
  b=adnAVVfhPfXi/Lz3FJq4pHPdzqQzelHdAyybJ5uXgnjrjpw19LWqNXopw3sAHR0bmefCyVLuwbBQ65fI66J6Fk7q5yIXfua0qBH7j0Hf3ffAsgn9nX55D0PrXcsrpizGNLVapuO5DW6xptoz7zKyr58LIzdTj+Py71VGYV4lpVM=  ;
Received: from unknown (HELO ?192.168.0.54?) (utilisateur_768@82.101.43.206 with plain)
  by smtp133.mail.ukl.yahoo.com with SMTP; 12 Feb 2009 06:58:22 -0000
X-YMail-OSG: zuaAm90VM1mRdeq3eTc5Wlg9IypYiKa9LPF6oqWaC9hvYdXlfSmxw4Pl4hmdCFdAccuKLVQkhqGC5JEcUehwIcFvgdkj5VK9.VjCgVRYnBOlv0AO0Wh_eXH76X9Od0wQb6S3dY0M2428eLTJgC2qPaR9
X-Yahoo-Newman-Property: ymail-3
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109579>

Hi,
i'd like to import a project from CVS. The cvs commits are done using 
Cp1252 encoding charset. The thing is i cannot change the .git/config 
file since the repo is created by git-cvsimport. So how can i use the 
good charset ?
