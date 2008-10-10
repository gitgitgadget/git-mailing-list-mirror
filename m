From: "Michael P. Soulier" <msoulier@digitaltorque.ca>
Subject: git confused by rename
Date: Fri, 10 Oct 2008 10:41:54 -0400
Message-ID: <fb6605670810100741k7cff25c7y4df66834cf7482a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 10 16:44:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KoJCw-0001aW-Ua
	for gcvg-git-2@gmane.org; Fri, 10 Oct 2008 16:43:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757873AbYJJOl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Oct 2008 10:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757700AbYJJOl4
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Oct 2008 10:41:56 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:59461 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757444AbYJJOlz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Oct 2008 10:41:55 -0400
Received: by wa-out-1112.google.com with SMTP id v27so273183wah.21
        for <git@vger.kernel.org>; Fri, 10 Oct 2008 07:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=YSaQT5mFdrevGxW+x5AEhxCpch0siWrSXhRGWNGRAT4=;
        b=l+lbEZLgIg8pelStPii72Q61vhHql8IU76A4v3JGfjIvljTEJkizYGQ/13L+pMBz/9
         DU6wqDD2WyWrnCPbVll3zabGPw7RhoO4V5h8BUt1CmE3YRgqkhC+0co/GXIScYSgsTFg
         k6gLfJK3w9u8Xxo0SAgP+KZbCtO7FPU5opANU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=gtKegSnqyTdhW41P4MOmgDq7RW0ywNMDs7yn5JOD5vYz2VYDyV7KG8Gdh7rY/qF2+t
         zzdsavc8oAzd6dSUaqljiIuHwudjWtLNEZ4vTPACHs6IHEmwOyVqXVTlvfc5+lSpB/NX
         McAnU0ZGvy6QKcCjyArbEbhSzq86cWXpLNkNU=
Received: by 10.114.127.1 with SMTP id z1mr1826553wac.10.1223649714571;
        Fri, 10 Oct 2008 07:41:54 -0700 (PDT)
Received: by 10.114.74.20 with HTTP; Fri, 10 Oct 2008 07:41:54 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: ec471d0e14955220
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97937>

# On branch ajax-callrecording
# Changes to be committed:
#   (use "git reset HEAD <file>..." to unstage)
#
#       modified:   js/urls.py
#       modified:   js/views.py
#       modified:   scrc/urls.py
#       modified:   scrc/views.py
#       new file:   templates/js/scrc.js
#       modified:   templates/js/teleworker.js
#       renamed:    templates/scrc/index.html -> templates/scrc/cres_taps.html
#       modified:   templates/scrc/index.html

Looking at the last two lines here, there is obviously an issue.

I created a new cres_taps.html file, and modified the index.html file, and for
some reason Git thinks that I renamed index.html.

Looks like a bug, unless I'm missing something.

Mike
-- 
Michael P. Soulier <msoulier@digitaltorque.ca>
"Any intelligent fool can make things bigger and more complex... It takes a
touch of genius - and a lot of courage to move in the opposite direction."
--Albert Einstein
