From: "J.V." <jvsrvcs@gmail.com>
Subject: merge help
Date: Tue, 26 Mar 2013 16:07:23 -0600
Message-ID: <51521C1B.3080307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 26 23:07:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKc26-00074D-8l
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 23:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254Ab3CZWH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 18:07:26 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:59662 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529Ab3CZWH0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 18:07:26 -0400
Received: by mail-pd0-f178.google.com with SMTP id u10so3251758pdi.37
        for <git@vger.kernel.org>; Tue, 26 Mar 2013 15:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=h6Zk/T0UKgd2CY9+B8Ik8DAOuf3KbQWyCFtkqGPW8i4=;
        b=A1uuAbM/IW/L8ax2ArrTwFHWnyl6NxL6hArpMLlJnhTb8Eurr237ZIf1ZA6atrx6ID
         z7+2SN+FYYEjsLIUpk+FjOM+iW6B+dyru4/c/5MWxNn2LyRd558lkAxiqR39e1OkwJMa
         S5lMBew4J2M5X6YuGQjZUe/GxP1dmkfL+H8YNiGCxh169RgrJpV8CtuDMDAtUjbFIZgV
         zDOVB8VUOJJ/dICybsHhFzFU8HHrR+TRArLWxgtplJ1AnAwyTXv+cZ+kyUyJIbonRKFS
         Qc+VKsJmq3ue9wgVG8Mtt9bYLBnjjimnsAbgJyW+h9aJ3wXTdUe+FnHlyERrGCGmrBWt
         dO+A==
X-Received: by 10.66.230.164 with SMTP id sz4mr26105150pac.124.1364335645772;
        Tue, 26 Mar 2013 15:07:25 -0700 (PDT)
Received: from [10.16.242.114] ([192.206.100.4])
        by mx.google.com with ESMTPS id qb10sm18838509pbb.43.2013.03.26.15.07.24
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 26 Mar 2013 15:07:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219222>

I have a branch for which I have made 0 (nada) changes.  I did the 
following:

$git pull --rebase --no-stat -v --progress origin mybranch

I get the following

U       java/Profile.java
Pull is not possible because you have unmerged files.
Please, fix them up in the work tree, and then use 'git add/rm <file>'
as appropriate to mark resolution, or use 'git commit -a'.
----------   (there is no local master branch), because of the conflict 
I was put on (no branch)
* (no branch)
   branch1
   dev
   tmpWork

Question 1)
Why did I get a merge conflict if I have not changed any files?


Question 2)
What is the command to show the difference between the files? (is there 
a visual tool that would let me merge)?

Question 3)
What is the command I would type to "accept theirs" and overwrite my local?

After this would I need to $git add & commit & push the file?

If someone could guide me through this initial process, (what is best 
recommended it would be most helpful).

thanks

J.V.
