From: Prenom Nom <utilisateur_768@yahoo.fr>
Subject: git-cvsimport : fatal: 'Root_branche_2_0_*_' is not a valid tag name.
Date: Thu, 12 Feb 2009 08:26:36 +0100
Message-ID: <4993CF2C.6010704@yahoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 12 08:25:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXVwp-0001jt-Dw
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 08:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754110AbZBLHYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 02:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753818AbZBLHYA
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 02:24:00 -0500
Received: from n21.bullet.mail.ukl.yahoo.com ([87.248.110.138]:21017 "HELO
	n21.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752108AbZBLHX7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2009 02:23:59 -0500
X-Greylist: delayed 1534 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Feb 2009 02:23:58 EST
Received: from [217.146.182.178] by n21.bullet.mail.ukl.yahoo.com with NNFMP; 12 Feb 2009 07:23:57 -0000
Received: from [87.248.110.115] by t4.bullet.ukl.yahoo.com with NNFMP; 12 Feb 2009 07:23:57 -0000
Received: from [127.0.0.1] by omp220.mail.ukl.yahoo.com with NNFMP; 12 Feb 2009 07:23:58 -0000
X-Yahoo-Newman-Id: 836184.82182.bm@omp220.mail.ukl.yahoo.com
Received: (qmail 52105 invoked from network); 12 Feb 2009 07:23:57 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Received:X-YMail-OSG:X-Yahoo-Newman-Property:Message-ID:Date:From:User-Agent:MIME-Version:To:Subject:Content-Type:Content-Transfer-Encoding;
  b=UKwEspjXy2lUobtdcIjUmCcAr9eZmtTZY6+BmBQzk2o6TbvLFv9HtGUVJKW46X5e8OyUeTeYgfMR/WrF/VdzTpUFijbsIfFY+dBKhpqNPdIltNxQTACg/pzws5+VRspcVKkMkoEIpp1QW0BI8nvuxlXKYBbnkNJHAeOAsGUP3Xs=  ;
Received: from unknown (HELO ?192.168.0.54?) (utilisateur_768@82.101.43.206 with plain)
  by smtp146.mail.ukl.yahoo.com with SMTP; 12 Feb 2009 07:23:56 -0000
X-YMail-OSG: s.TJP6UVM1m9_Z5M7KkMmvJqz6P4whyAvYtoqCPUT9LnBl.5ihgVAza2xm5P0EDrBwHiS4iEXy3aR3QxyFHXGgnuW2lyNQs83gQXufzcDqCQN7yllcEGy1nm8.2r9Cm9hQGunjxDzVaJJj8XIc6fJi02
X-Yahoo-Newman-Property: ymail-3
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109580>

Hi,
during a run of git-cvsimport, i got this error :
fatal: 'Root_branche_2_0_*_' is not a valid tag name.
Cannot create tag Root_branche_2_0_*_: Bad file descriptor

I can't use -p -b xxx since i would like to test branch merging in git 
so i need HEAD AND some CVS branch (you can't use -b 2 times for cvsps).

So i guess i won't be able to test git branch merging...
