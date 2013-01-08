From: gw1500 <wtriker.ffe@gmail.com>
Subject: Understanding When to Use Branches
Date: Tue, 08 Jan 2013 08:46:21 -0500
Message-ID: <50EC232D.90009@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 14:52:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsZb6-0004dL-CQ
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 14:52:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756266Ab3AHNvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 08:51:48 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:64850 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794Ab3AHNvr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 08:51:47 -0500
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jan 2013 08:51:47 EST
Received: by mail-yh0-f43.google.com with SMTP id 27so69545yhr.30
        for <git@vger.kernel.org>; Tue, 08 Jan 2013 05:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=RHBFreLAWJC34ajuRlpbVkfWQomVBgrxXuH80brj3vw=;
        b=kFirgAZ8TZ14s/kwHmUV2b4D7jfTtq5l3+yTOU0yO79oMQKuZm75BNqLikGbIVeRC/
         s4ZqL8t9aY3hDyZDdGfYUOJRqd1Nzw52ORgIyhY30sQJV3b1LqQYDVAH25OFhOvPoCZv
         B+WNBdTcB2ElToONvVBET//yDK11xWhCbwfvykUFqNKJJkOkcGWqxFhGdoOCeoXHol6j
         ODM2vvQP7dCwDsXjF7ZnOE5azlP+CqWW+jEhhpQ65c4fcOwZhri9OB31Ra6KQ0MJfewd
         wh2uqJtonXMFsAwv4J2JhXE52SB5qz5mttQJYOXJpAUlPOP7AJ7ZAmabEbYRcea0cGHd
         diKg==
X-Received: by 10.101.152.11 with SMTP id e11mr20572923ano.44.1357652780237;
        Tue, 08 Jan 2013 05:46:20 -0800 (PST)
Received: from [192.168.0.100] (adsl-74-176-50-42.asm.bellsouth.net. [74.176.50.42])
        by mx.google.com with ESMTPS id y17sm1794140ang.12.2013.01.08.05.46.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 Jan 2013 05:46:19 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212963>

As a git noobie I am beginning get get my head around git's version
control philosophy. I am now trying to understand the purposes of
branches or rather when to use them. In my case I have a Java
application under version control with git. I am planning to port it
into a mobile app. Is that an appropriate use of branches or should it
be created as a new repository? What is the relationship between the
same source code in different branches? Do changes to code in one branch
get ported to another branch somehow or do all changes then have to be
made twice? The documentation tells how to branch but not the general
philosophy behind it from a best practices standpoint. Thanks in advance
for any insight.
