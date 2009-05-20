From: Big Lebowski <duderino.lebowski@gmail.com>
Subject: Getting Commits from One Repository to Another
Date: Wed, 20 May 2009 19:37:54 -0400
Message-ID: <7D9240D0-C8BA-40C6-A89E-8BC7E08B1163@gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 21 01:38:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6vMM-0004Hk-6J
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 01:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbZETXh4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 19:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753341AbZETXh4
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 19:37:56 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:53333 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbZETXhz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 19:37:55 -0400
Received: by gxk10 with SMTP id 10so1396903gxk.13
        for <git@vger.kernel.org>; Wed, 20 May 2009 16:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to
         :content-type:content-transfer-encoding:mime-version:subject:date
         :x-mailer;
        bh=UYi6jwLejmfkJIqGDLwm4pT8YqvbIbmYylGnACsmX5w=;
        b=Xa2Vr1adVhD8p2eo4QIe3exzxjptmZRj9RLohDMCIfuqZfPZFVWVRmD/rgjCY7/quF
         bYgKsrksOyPmxtLeEscBM2cdhp0/QrdBFqVNdj9jddI+tWU2+8q2ABnQ7XPd3n/euo2T
         nYVd+QIPBlZVEEavnDUOyJQf3QIaVm1sRHvzk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:content-type:content-transfer-encoding
         :mime-version:subject:date:x-mailer;
        b=OZBnSYc1oN4GF0R6nKYkF9swppacFa7NuPcrTGjwwqe5mdSBIv1uOV/8uDAhf0IlCX
         2t8u9bFyZUQTBNIt6OwSB3+OYb7M2hR7PNkfRtNN+XovDiJNypp7KLs3vXOi9L2rHF14
         ELJcongX1Z36nmFO9az15jeae25kCjqfEQTLc=
Received: by 10.151.119.5 with SMTP id w5mr3819305ybm.167.1242862676538;
        Wed, 20 May 2009 16:37:56 -0700 (PDT)
Received: from ?172.21.42.131? (pool-173-66-53-162.washdc.fios.verizon.net [173.66.53.162])
        by mx.google.com with ESMTPS id 6sm78517ywn.37.2009.05.20.16.37.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 16:37:55 -0700 (PDT)
X-Mailer: Apple Mail (2.935.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119641>

Hi all,

I hope this isn't a FAQ. I searched, and the closest thing in there  
(which may be what I want, but sounded wrong) was "How to share  
objects between existing repositories?" If that is it, then I  
apologize for the bandwidth.

Essentially, when I came on a project, a git repository was made  
available to me (lets call that 'public_repo'). That repository was  
put up on an unfuddle account, as an initial check-in; it was not  
cloned from the repository they were working on (lets call that  
'private_repo'). I wrote some code, and pushed it to the repository.  
Now that I guess they feel comfortable with me, they reveal to me the  
private_repo.

How do I get my code from public_repo to private_repo?

Thanks for helping a novice out.
Ryan
