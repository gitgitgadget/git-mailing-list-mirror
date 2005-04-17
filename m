From: jeff millar <wa1hco@adelphia.net>
Subject: Building git on Fedora
Date: Sun, 17 Apr 2005 19:25:49 -0400
Message-ID: <4262F07D.4050007@adelphia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Apr 18 01:22:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNJ5q-0005YZ-0t
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 01:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261548AbVDQX0F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 19:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVDQX0F
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 19:26:05 -0400
Received: from mta9.adelphia.net ([68.168.78.199]:16094 "EHLO
	mta9.adelphia.net") by vger.kernel.org with ESMTP id S261548AbVDQXZ5
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 19:25:57 -0400
Received: from [192.168.2.4] (really [24.52.167.181]) by mta9.adelphia.net
          (InterMail vM.6.01.04.01 201-2131-118-101-20041129) with ESMTP
          id <20050417232550.BSNQ2192.mta9.adelphia.net@[192.168.2.4]>
          for <git@vger.kernel.org>; Sun, 17 Apr 2005 19:25:50 -0400
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Here's a tidbit to enable git to compile on Fedora.  Add the following 
line to /etc/rc.d/rc.local...

    ln -sf /lib/modules/`uname -r`/build/include/linux 
/usr/local/include/linux

This fix creates a symlink, on each boot up, in the local include 
directory that points to the kernel header files. If there's a better 
way to do this, I'm all ears.

jeff
