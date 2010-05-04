From: Jonathan Chetwynd <j.chetwynd@btinternet.com>
Subject: preserve permissions?
Date: Tue, 4 May 2010 13:29:50 +0100
Message-ID: <C1288762-C750-4919-A853-5E3229870A59@btinternet.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 04 14:36:21 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9HMA-0000CM-5j
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 14:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758543Ab0EDMgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 08:36:04 -0400
Received: from smtp817.mail.ukl.yahoo.com ([217.12.12.246]:22574 "HELO
	smtp817.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752824Ab0EDMgB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 08:36:01 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 May 2010 08:36:00 EDT
Received: (qmail 67906 invoked from network); 4 May 2010 12:29:20 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=btinternet.com;
  h=DKIM-Signature:Received:X-Yahoo-SMTP:X-YMail-OSG:X-Yahoo-Newman-Property:Message-Id:From:To:Content-Type:Content-Transfer-Encoding:Mime-Version:Subject:Date:X-Mailer;
  b=3W1JaIFvZl5br91mG10MbvrenztCJ/X9AircViKgFIAkf/sJhdagk53m9RmeoEml86tQQjgtRIx+W5QwrtxL7sZBX4IKdCQ0VkSN6S5mea23qdFPDh61cuRi48D4rmpKYU3YE/jOvHXjoMmMvQJN2qdlZ1Y54tOM/8TDYah/ZZE=  ;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=btinternet.com; s=s1024; t=1272976160; bh=OrtUC7d4eELNKQI7xlKWO5jo4JiRIKBc0umKqcsZ1JA=; h=Received:X-Yahoo-SMTP:X-YMail-OSG:X-Yahoo-Newman-Property:Message-Id:From:To:Content-Type:Content-Transfer-Encoding:Mime-Version:Subject:Date:X-Mailer; b=HK3PU2YjJM/dzNVd9Y5CjnnRlaIalMlAU6DQBWy0PjC7+rJsvEaw2DsSrT17g+AsNn4GzE5KMUN8SSMlzhul1ASNCpoWHl7nyK9aqXrT8d4y52wcYjwsfjd9O4EpHzdwice8na/LHiUNBaoZurfm38WGdwzyRq6rDzUULUzgQJY=
Received: from [192.168.1.66] (j.chetwynd@86.178.207.97 with plain)
        by smtp817.mail.ukl.yahoo.com with SMTP; 04 May 2010 12:29:20 +0000 GMT
X-Yahoo-SMTP: OVC5FVSswBCDWxcDEsBFUbxDcwLJHrYb.rbJcbEfg6JJmHR4j0s-
X-YMail-OSG: H2wEHhQVM1neo3OvfTWAFQvhduz6d86p9n01XiOP2k1Ek5xy_JGrfF_vP2usuKxu1YBx6fc9RiMrwt87ediwUcjoNNT8Rgd4Hbx2Ux4ORX77UrfgywPnCFm2yBrCY0znD8WP4CeVmshaWlxRSBr50a9IqXiBntv39vFCs9jGVdxmRCVwPoy6XiKWzEw.ZACM4w6EJhzfnokUmfUQT8k6M1hqNIdPCV8hhaL1Hh_Rft_utQ--
X-Yahoo-Newman-Property: ymail-3
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146311>

git clone ../xsl-test/

the original has a single directory, owner _www, and a few files.

however the clone directory has owner Me.

what is the reason permissions are not preserved?

regards

Jonathan Chetwynd

testing git before moving a development project to git for production
