From: Roberto <mrgreiner@gmail.com>
Subject: link user-name with ssh-login
Date: Mon, 19 Mar 2012 13:58:56 -0300
Message-ID: <4F6765D0.5060706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 19 17:59:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S9fvG-0001OB-LR
	for gcvg-git-2@plane.gmane.org; Mon, 19 Mar 2012 17:59:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162248Ab2CSQ7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Mar 2012 12:59:00 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51385 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756641Ab2CSQ67 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2012 12:58:59 -0400
Received: by vcqp1 with SMTP id p1so6458505vcq.19
        for <git@vger.kernel.org>; Mon, 19 Mar 2012 09:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=7wN6hW5YiF71vJg8IW+Ug+pbqFyYZDRvB/sqCohKZAk=;
        b=pCFODlBOSghrUdJwUmgSIY6F8ASJX6YPRi9UzRUG16JiZ7rezx7PJFgR4p8lCfVggF
         vCxBqW3abhR8Rr+9zZPbYpbFs3VWM9L/m+MrYAyOhGk2M+QzfDIkRED53svxnQftb4WD
         BYe+ZOd+rmX20MbMy6mt5+ytMtKiyH8ymT0L5AMuo+fp4mPcMUxoh7lkUTNYqMX0z6a+
         YRDw8v8u22b29D7jjdqmFo6ms+dtuYQam6UvQIos7IeIcrAaFnyZ5+AphHramWqWbcxZ
         LXsQdsuMds6UZjJSdXlItmZvKu/2N040HPY2wMe0xRDZr+d3F/QDyUh4Oap+YH62o9XK
         9Hlg==
Received: by 10.52.30.65 with SMTP id q1mr4159184vdh.77.1332176339009;
        Mon, 19 Mar 2012 09:58:59 -0700 (PDT)
Received: from ?IPv6:2801:88:ead:0:5d0f:2926:26b1:5b9f? ([2801:88:ead:0:5d0f:2926:26b1:5b9f])
        by mx.google.com with ESMTPS id ig6sm10038036vdb.0.2012.03.19.09.58.57
        (version=SSLv3 cipher=OTHER);
        Mon, 19 Mar 2012 09:58:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:11.0) Gecko/20120312 Thunderbird/11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193442>

Hi,

I have small ssh-based git server used for insite code development. But 
there is one thing I can't find how to set.

In the server, each developer has a valid ssh account (I switched the 
shell to git-shell). The problem is that when a developer commit's some 
code, he can freely set in his local .git/config file the user name he 
want's to appear in the commit logs. Is there any way to link/force a 
certain ssh login to a name?

Thanks,

Roberto

-- 
   -----------------------------------------------------
                 Marcos Roberto Greiner

    Os otimistas acham que estamos no melhor dos mundos
     Os pessimistas tem medo de que isto seja verdade
                                   James Branch Cabell
   -----------------------------------------------------
