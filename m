From: Igor <mrigor83@gmail.com>
Subject: git-svn won't remember pem password
Date: Fri, 17 Feb 2012 16:36:11 -0800
Message-ID: <E56535F6-2C9B-4D14-A88F-2471E34D2769@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 01:36:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RyYI2-0004DH-Nd
	for gcvg-git-2@plane.gmane.org; Sat, 18 Feb 2012 01:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab2BRAgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Feb 2012 19:36:15 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:33772 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab2BRAgO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Feb 2012 19:36:14 -0500
Received: by daed14 with SMTP id d14so3772396dae.19
        for <git@vger.kernel.org>; Fri, 17 Feb 2012 16:36:14 -0800 (PST)
Received-SPF: pass (google.com: domain of mrigor83@gmail.com designates 10.68.226.41 as permitted sender) client-ip=10.68.226.41;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of mrigor83@gmail.com designates 10.68.226.41 as permitted sender) smtp.mail=mrigor83@gmail.com; dkim=pass header.i=mrigor83@gmail.com
Received: from mr.google.com ([10.68.226.41])
        by 10.68.226.41 with SMTP id rp9mr27460274pbc.162.1329525374244 (num_hops = 1);
        Fri, 17 Feb 2012 16:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :cc:to:mime-version:x-mailer;
        bh=BNRv747k47LqfJ+OHLJQbkdUkJjc7CajhFvUq/Jmyog=;
        b=LgReEuDfTMAFLqcP7O2IIvNNVHXulgCOMXhbmB8Oog5HTAVe6UOPoGk3NfyODq9Vtp
         7N3fEXVIdvDZvFhRFPA2kPwluy9RDvy/6v/xDU8rswQ4v/P+GEjH1kXbMw8fKFXGm+af
         00CETDHLkPbQR4bdIDIWA7geiyZfUyWAzA2Bs=
Received: by 10.68.226.41 with SMTP id rp9mr22443869pbc.162.1329525374202;
        Fri, 17 Feb 2012 16:36:14 -0800 (PST)
Received: from [172.17.35.31] (50-0-2-21.static.sonic.net. [50.0.2.21])
        by mx.google.com with ESMTPS id y3sm6439127pbr.46.2012.02.17.16.36.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Feb 2012 16:36:13 -0800 (PST)
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190988>

I'm running into an issue where I have to enter my pem certificate password every time I git-svn fetch or git-svn dcommit. Vanilla svn uses OS X KeyChain and remembers my password just fine. Is there a known solution for this? Other users have ran into same issue as described here: http://stackoverflow.com/questions/605519/does-git-svn-store-svn-passwords. However, that solution of removing .subversion folder did not work for me.

Thanks,
Igor