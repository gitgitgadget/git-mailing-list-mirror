From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Weird documentation for git commit-tree
Date: Thu, 10 May 2012 18:34:08 +0200
Message-ID: <CAGK7Mr4LJxEfG6D3eWMrN9GXywMjSDJ1Ric=4w7SQY=6ZWu3wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 10 18:34:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSWKE-0002RV-5K
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 18:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754516Ab2EJQel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 12:34:41 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:37641 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab2EJQek (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 12:34:40 -0400
Received: by wibhm4 with SMTP id hm4so705107wib.1
        for <git@vger.kernel.org>; Thu, 10 May 2012 09:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=eW91ZauBGwNPtUQdG9/CiGHjrVB0OZTw/6Q45YJjchI=;
        b=YUoZC6aAEVOF0TL567EcpJK2+rLQm17zZz822Dmc+1TP7JFZUvz/FOB3+4zMeSAcJR
         E+/ZzL5GYSGqNT6qXf7K4qI4Eql1WEWGzRq5focDLsVBsva+JY+agMVJ+CqA3xMK8kN0
         yRT7Oiu/OsN346Fxq8B94sgeXAtOIdZfxQyEupGWvnzMWFkXzku4FcIS2hrZ1gtX62P0
         jcetwrpzpUE6Xxy3wRycWB1rYhVnOvlbw2ZQw2b5OvwyrMLovA4rss9FYH56C9CGMpR5
         e8Pr9/kBfpdOua5aA9WZavMTuQHUAinHeghODvcMsZiKRKltT9K5Z6BeRp1rms1IWKSi
         N/HQ==
Received: by 10.50.191.200 with SMTP id ha8mr4560664igc.45.1336667678949; Thu,
 10 May 2012 09:34:38 -0700 (PDT)
Received: by 10.50.65.101 with HTTP; Thu, 10 May 2012 09:34:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197593>

Hello,

The man page for git commit-tree shows weird text under the DIAGNOSTICS section:

    You don't exist. Go away!

    The passwd(5) gecos field couldn't be read
    Your parents must have hated you!
    The passwd(5) gecos field is longer than a giant static buffer.
    Your sysadmin must hate you!
    The passwd(5) name field is longer than a giant static buffer.


I noticed that the same happens for Documentation/git-var.txt

Is this normal or?

Philippe
