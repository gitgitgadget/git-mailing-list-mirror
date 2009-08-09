From: Joel Mahoney <joelmahoney@gmail.com>
Subject: fatal: bad revision 'HEAD'
Date: Sun, 9 Aug 2009 15:15:46 -0600
Message-ID: <06DCECD0-45F0-4695-86D4-7C54EFE4E640@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 23:16:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaFkg-0004jq-Go
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 23:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbZHIVQS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 17:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbZHIVQS
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 17:16:18 -0400
Received: from mail-pz0-f196.google.com ([209.85.222.196]:35134 "EHLO
	mail-pz0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbZHIVQS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 17:16:18 -0400
Received: by pzk34 with SMTP id 34so2528431pzk.4
        for <git@vger.kernel.org>; Sun, 09 Aug 2009 14:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=dUnhJcb+r7DVcW+96VSVrnMZ/k9tshw4kcoLiCmi5rM=;
        b=SFXa6B2R9BOeZbshBXSaS1tWuGBepPFHC7k7sKdanOboFBvbekgW6MjyFJHrMQUiX7
         fYVL4lkGm/uGoYuxyFzNJJ/mnnHmXc8OPQGUjvdmuavZTkPSbSNw9dTYVig/5Eq2hYve
         GW/BIdh4ENv6OKG5sVARo0hFVksmcfF9We0sE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=kMF/yKHtcYYSmui8l+3APMNiN7ogI2uUpnvmWgrI8xKatDRZwlGr7tlWXJTzK73nYc
         6nqAc2Ik6dqDx2Y6s6amR+LzUJnrJgkJCBILiHzkymf8ZB+ex5nGjBIwTEjxowWfhP9U
         LwnA246sQ76sEiA63zJwU/kWEgoa67G+crziE=
Received: by 10.115.33.4 with SMTP id l4mr5250895waj.38.1249852578985;
        Sun, 09 Aug 2009 14:16:18 -0700 (PDT)
Received: from ?192.168.0.134? ([63.225.113.121])
        by mx.google.com with ESMTPS id k37sm6145308waf.7.2009.08.09.14.16.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 09 Aug 2009 14:16:18 -0700 (PDT)
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125382>

Hello,

I am having trouble installing Ruby on Rails plugins from github.   
when I run e.g. script/install plugin git://github.com/thoughtbot/ 
paperclip.git I get:

 > Initialized empty Git repository in /path/to/my/project/vendor/ 
plugins/paperclip/.git/
 > fatal: bad revision 'HEAD'
 > refusing to pull with rebase: your working tree is not up-to-date

I don't have any problems with git in general, but this error happens  
every time I try to install from github - even when it's a brand new  
rails app.

the github support team tells me it looks like a git issue - any  
suggestions would be appreciated!

thanks,
Joel
