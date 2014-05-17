From: Arup Rakshit <aruprakshit@rocketmail.com>
Subject: commit all the untracked files prior adding them to stage using "git add"
Date: Sun, 18 May 2014 00:58:50 +0630
Organization: CognitiveClouds
Message-ID: <1878681.dTqGrk8buZ@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 17 21:35:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlkOI-0004C9-FW
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 21:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbaEQTf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 May 2014 15:35:26 -0400
Received: from nm18-vm10.bullet.mail.sg3.yahoo.com ([106.10.149.105]:20797
	"EHLO nm18-vm10.bullet.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751101AbaEQTfZ (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 May 2014 15:35:25 -0400
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Sat, 17 May 2014 15:35:25 EDT
Received: from [106.10.166.116] by nm18.bullet.mail.sg3.yahoo.com with NNFMP; 17 May 2014 19:29:03 -0000
Received: from [106.10.167.167] by tm5.bullet.mail.sg3.yahoo.com with NNFMP; 17 May 2014 19:29:03 -0000
Received: from [127.0.0.1] by smtp140.mail.sg3.yahoo.com with NNFMP; 17 May 2014 19:29:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s1024; t=1400354943; bh=J7Oz1I6vbgAi7WEzjBkG3aow8vno+lDj9dSw1zw6PUs=; h=X-Yahoo-Newman-Id:X-Yahoo-Newman-Property:X-YMail-OSG:X-Yahoo-SMTP:X-Rocket-Received:From:To:Subject:Date:Message-ID:Organization:User-Agent:MIME-Version:Content-Transfer-Encoding:Content-Type; b=Av5iIW8+cj92t7KwO430luwlxEL8EHq8eOP3a3MGtE9UyE1vjecc0mP/FA7C3D4UW7q/BGyBolaCii09RQ9zUHD+rxDNhNa7G9oRQ+HgWzxL5VrwxQr++l1jSPRu6sfx7jEQHqFqpHRID3bGFhzac7Qw/azx6MUsgLeDE540UNw=
X-Yahoo-Newman-Id: 258905.70938.bm@smtp140.mail.sg3.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: X4x9jAIVM1nTzYnfa2ANwvv2zV5obPYUBzMp_vPxL.utcUe
 GzDZNWawl9egYeX0f4cIK4qWuYN4C02ztEBc6GLZCz28aPTNH02p6Gh3H_KO
 AcRRPBrtnPu1HTWty9JCKmsOHdh8PSqc8FDNnah7P9OuqhSOBJhai4VEkqrB
 MCJpnM00RkFSMtO1_.NB3gBR6f17ByL9vjZXjbHXJmSz9lJBvpcmafngOIkA
 GJNui4LUxC6LE6fqPBvOdTQA7RPzS0NwnIVNpR5xU7yRpJq1RMUaqjnxUqOz
 kxpNwvJCzkB7LmLS.Hke4Dul94EHLr8_lVUxh6h5H7TEDY1KTzVPqe4zS.vh
 65jr_IUmw84IoMc5iOCapuE6He6m2TfR0XIlQTNSzOhmwx1dpGMo_zpRu.hO
 .eKPA4e2LXTOIuCV.B7MQmBcDLosaN6FmjUSLn6jiwViyHJKomOPG7E3kycL
 f8CCzkCwDZYm7_t.c8gFksfQ6YdnHMEp1hksJny8TBiqpyJToZkld.iHanQR
 _2eVLp2WKZ7fdrSlTQdxQlh.rz3sdav0VqQfKvmKGx1yISUezRaEaegv4p46
 3ZudzhDuCL.Rs2tM-
X-Yahoo-SMTP: _NAuC72swBDpdridK5c7mltfXc1K.nFhPY5jXEZ4Gfdya8Gn_0nN
X-Rocket-Received: from linux-wzza.site (aruprakshit@117.254.105.190 with plain [106.10.150.171])
        by smtp140.mail.sg3.yahoo.com with SMTP; 17 May 2014 12:29:03 -0700 PDT
User-Agent: KMail/4.11.5 (Linux/3.11.10-7-default; KDE/4.11.5; i686; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249490>

Here is the currently added files in my repository :

arup@linux-wzza:~/Rails/test_app> git status
# On branch master
#
# Initial commit
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       .gitignore
#       Gemfile
#       Gemfile.lock
#       README.rdoc
#       Rakefile
#       app/
#       bin/
#       config.ru
#       config/
#       db/
#       lib/
#       log/
#       public/
#       test/
#       vendor/
nothing added to commit but untracked files present (use "git add" to track)

Now I am looking for a way to add those in stage and commit also in a single 
line. So I did below :-

arup@linux-wzza:~/Rails/test_app> git commit -m "chapter 19 of Agile Web 
Development with Rails" -a
# On branch master
#
# Initial commit
#
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#       .gitignore
#       Gemfile
#       Gemfile.lock
#       README.rdoc
#       Rakefile
#       app/
#       bin/
#       config.ru
#       config/
#       db/
#       lib/
#       log/
#       public/
#       test/
#       vendor/
nothing added to commit but untracked files present (use "git add" to track)

It did not work. Then using `git commit -h` told me, *-a* will work, for 
*tracked files*. Is there any way to add untracked files in stage, and commit in 
a single line ? 


-- 
===============
Regards,
Arup Rakshit
