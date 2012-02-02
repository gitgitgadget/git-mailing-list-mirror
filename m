From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] Use correct grammar in diffstat summary line
Date: Wed, 1 Feb 2012 18:27:58 -0600
Message-ID: <20120202002757.GA3487@burratino>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <1328100907-20397-1-git-send-email-pclouds@gmail.com>
 <20120201233515.GC29599@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 01:28:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RskXG-0003F7-3L
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 01:28:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab2BBA2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 19:28:17 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:44281 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab2BBA2R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 19:28:17 -0500
Received: by iacb35 with SMTP id b35so2243266iac.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 16:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=f7WoiXEyj3+OsIZM7DYQTs8183WvuOxMI/y/tdmrR68=;
        b=j+1hlE8/NB8T5mZsd4A1C2RNjfPo245JkBVlBqfmIItfkQ50/e4Bmuil9oMUKJkgbb
         j8o3NN+djpmSphErJdxcOabDGOneupZNPi39kRKwb9tFce07RJrWqJF/q1RIjhvF2H6J
         KKYiHB/rJ2yKRQW1ONmwgET6YZz7jCIWk+Jqk=
Received: by 10.42.135.138 with SMTP id p10mr670543ict.25.1328142496518;
        Wed, 01 Feb 2012 16:28:16 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id he16sm1228339ibb.9.2012.02.01.16.28.15
        (version=SSLv3 cipher=OTHER);
        Wed, 01 Feb 2012 16:28:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120201233515.GC29599@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189562>

Jonathan Nieder wrote:

> [...]
>> --- a/t/t1200-tutorial.sh
>> +++ b/t/t1200-tutorial.sh
>> @@ -156,7 +156,7 @@ Updating VARIABLE..VARIABLE
>>  FASTFORWARD (no commit created; -m option ignored)
>>   example |    1 +
>>   hello   |    1 +
>> - 2 files changed, 2 insertions(+), 0 deletions(-)
>> + 2 files changed, 2 insertions(+)
>>  EOF
>
> Yes, this one's necessary.
>
> (*) It's reminding us to update the gitcore-tutorial. :)

Patch for squashing (untested) below.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Documentation/gitcore-tutorial.txt |    2 +-
 Documentation/gittutorial-2.txt    |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index c27d086f..fb0d5692 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -1004,7 +1004,7 @@ Updating from ae3a2da... to a80b4aa....
 Fast-forward (no commit created; -m option ignored)
  example |    1 +
  hello   |    1 +
- 2 files changed, 2 insertions(+), 0 deletions(-)
+ 2 files changed, 2 insertions(+)
 ----------------
 
 Because your branch did not contain anything more than what had
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index f1e4422a..e00a4d21 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -34,12 +34,12 @@ $ echo 'hello world' > file.txt
 $ git add .
 $ git commit -a -m "initial commit"
 [master (root-commit) 54196cc] initial commit
- 1 files changed, 1 insertions(+), 0 deletions(-)
+ 1 file changed, 1 insertion(+)
  create mode 100644 file.txt
 $ echo 'hello world!' >file.txt
 $ git commit -a -m "add emphasis"
 [master c4d59f3] add emphasis
- 1 files changed, 1 insertions(+), 1 deletions(-)
+ 1 file changed, 1 insertion(+), 1 deletion(-)
 ------------------------------------------------
 
 What are the 7 digits of hex that git responded to the commit with?
-- 
1.7.9
