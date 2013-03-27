From: "J.V." <jvsrvcs@gmail.com>
Subject: more git weirdness (git rebase, merge conflicts
Date: Wed, 27 Mar 2013 12:51:37 -0600
Message-ID: <51533FB9.7070307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 27 19:58:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKvYV-00027t-ML
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 19:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753505Ab3C0S6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 14:58:11 -0400
Received: from mail-da0-f42.google.com ([209.85.210.42]:57442 "EHLO
	mail-da0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753312Ab3C0S6L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 14:58:11 -0400
Received: by mail-da0-f42.google.com with SMTP id n15so4217534dad.29
        for <git@vger.kernel.org>; Wed, 27 Mar 2013 11:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=UFuT+XAP/SbTnAUjEdV10Lo+hsT30Px16o2bsHN3nGM=;
        b=QRk5mTTmVrQEhnvo0YZttZQLIjqa23Lt/lJpVqXYshdBdkrPs0BL04weqDAhNWSNpv
         /W75gfPU8nXCglyIqQmv7AwO3XCrVt5r9xPOV9Zse6QY1jOroEy3e5lj/6cC2mNFT8gs
         Aiu7fYkB69kc1CVGLg8vBzIPcPfQyfocE1+Ow6pfY2CvLCGqmMsRMX7vBBiFicvpfi5j
         e6F52yTHmj0mIECU+LopMXAicZW0IBi/5c+Uyt9EVgTDN72JnWbb7KMyJZWJMrwTtcKN
         tOuGYtAsfvmCrDTEnYPn+BSfa4ezv3dJmNARkztb+NIyfMopjQ52uhZ7FS93lPa+EYOb
         NMJA==
X-Received: by 10.68.243.98 with SMTP id wx2mr31339082pbc.68.1364410299586;
        Wed, 27 Mar 2013 11:51:39 -0700 (PDT)
Received: from [10.16.242.114] ([192.206.100.4])
        by mx.google.com with ESMTPS id kt5sm22372463pbc.30.2013.03.27.11.51.38
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 27 Mar 2013 11:51:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219305>

I have a local/development branch tracked to origin/development.  I made 
no changes to local/dev and did a git pull with rebase, I did not expect 
any conflicts.

I got a conflict and was thrown onto another branch.  I attempted a 
merge (using IntelliJ) accepting everything from the server but a 
variable definition was missing for some odd reason and the merge was 
not successful (merge was resolved but the file would not compile) so I 
decided to simply go back to my dev branch and figure out how to do a 
git pull -f (force overwrite of all local files so that I could get my 
local/dev back into sync with origin/dev.

On my screwed up branch that I was thrust onto:
I typed:
     $git rebase --skip            <= I was stuck in a rebase (rebase 
failed, was thrown onto a tmp branch and thought this would get me out 
of there)

Now I have been sitting here for an hour watching  "Applying: <message" 
scroll by and it looks like the messages are going backwards into the 
past one by one.  What the hell is happening?

     Applying: add log information
     Applying: <previous message
     .... and it goes on and on and on.

All I want to do at this point is to get back to my dev branch and force 
pull from origin/dev while keeping all local files that have not been 
added to my local repo.

How do I stop this madness and get back to local dev and force pull from 
origin/dev     <= which is our master.

Any help would be greatly appreciated.


thanks


J.V.
