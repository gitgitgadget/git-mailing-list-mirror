From: Adam Lee <adam.lee@canonical.com>
Subject: [Bug] git-email: sendemail.bcc in config file overrides command line
 option "--bcc"
Date: Fri, 9 May 2014 16:13:31 +0800
Message-ID: <20140509081331.GC3145@adam-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 09 10:13:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wifw8-0000Xs-1s
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 10:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbaEIINj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 04:13:39 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:52741 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752624AbaEIINg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 04:13:36 -0400
Received: by mail-pd0-f176.google.com with SMTP id y13so3392245pdi.21
        for <git@vger.kernel.org>; Fri, 09 May 2014 01:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=78PUaryLFgwzvMrWPyyF47oZFRy+xuPLSyzffurhy2w=;
        b=MeQe9XWj0cXNmu80V84BhrUA0s4cboRYAmi3l74e4dgO6nHZyoCjz4oGnPxYgKk8/o
         UUPVN2DBnpxm2rfNNMCHV48xlawJL4sGVdjgJY5gqYqrJhJfuuAZWOrh9lgxS7WWC5Lx
         LNP9tG+J4S+qHrPn4l0h16lPjOcnnwmOQPnXQIbqM1bECtqLIMU7AJ5LyIPJtA7IbSSJ
         M1B39ZhUV6IwGImYsVmCpnU61zNwEs2DG6b2CmkAvNOons1F5McZ2RaS9J9qxEcDb1GH
         1edv9Au06JPW9xZTjKcT7Ow9v0O2rPgR53cDz9KqoORa4ZODpyWnshEvhBK5rKtOl8TW
         a7ag==
X-Gm-Message-State: ALoCoQkIj9SzWM0peq4/RycwVLMC3f47Y9Srke4DoDUxxJDiFHi3vgDBMcm2jbMqVZGhaQ3+AtHx
X-Received: by 10.67.14.231 with SMTP id fj7mr17347591pad.115.1399623215454;
        Fri, 09 May 2014 01:13:35 -0700 (PDT)
Received: from localhost ([116.213.97.190])
        by mx.google.com with ESMTPSA id yn4sm6062271pbb.95.2014.05.09.01.13.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 May 2014 01:13:34 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248529>

BugLink: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=747068

"--bcc" should have higher priority than sendemail.bcc.

> --bcc=<address>
>     Specify a "Bcc:" value for each email. Default is the value of sendemail.bcc.
>
>     The --bcc option must be repeated for each user you want on the bcc list.

Reproducing steps:
1, set sendemail.bcc in .gitconfig.
2, git send-email --bcc with another address.

-- 
Adam Lee
