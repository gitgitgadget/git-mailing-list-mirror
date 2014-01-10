From: Dan Kaplan <dank@mirthcorp.com>
Subject: A question about the error: svn_fspath__is_canonical
Date: Fri, 10 Jan 2014 11:06:18 -0800
Message-ID: <CABRpx=1CvB55zeL1L8QOvyfbJCaG9FK+HEz-iK9cFGrnxmOJtg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 10 20:06:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1hPV-0008Q6-P4
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 20:06:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbaAJTGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 14:06:20 -0500
Received: from mail-qe0-f44.google.com ([209.85.128.44]:44914 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751209AbaAJTGT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 14:06:19 -0500
Received: by mail-qe0-f44.google.com with SMTP id nd7so4976040qeb.31
        for <git@vger.kernel.org>; Fri, 10 Jan 2014 11:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirthcorp.com; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=YawItD6s+ZwcQrN30r4DVflJoyIH68artMKA0axAPW4=;
        b=ROty5nFdnNtHr/zKc+Zido7EL+swGZuSkWN3Z+d/91ZPkdl48150rD5ZYJ3RNJ/yO0
         d8Ui56vGLC5bD8sxZozk0CIbgeqnN9edNkW9FfAB7naE2cK73lX99znmBs0/8hRdqXHo
         2r+N1Ue9RhVIQw+JkYs01BIRgSmC3DyV6gNGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=YawItD6s+ZwcQrN30r4DVflJoyIH68artMKA0axAPW4=;
        b=hlpeVqkc1/SyAR3sTpukKPGygeG+oKxRUur/RVjCvpPn61KOB4vJDBRfaBnDx5Hxwo
         q33qHa2mWng2JW9okBwHMyC6OT9foqWJJthjUt5wRmtvGM7VTIkP/lulcvS+5ionisDn
         oE6208Zac6+SAFYqE8ZbC40DgWlqUtgVU/8ztr0m8+nrej/hPDlrgXRGAwd1+nmzs/Hs
         tch/LVKbB0gxejP74/mU2LyFxiuZDwYxp3fZ3V3+6+v73i2h9OPd1vInpUBbYsEF5hVE
         zqW5e5n6pm4fREs9aoYDuyeNaLoXMXq7rQvMPBoo28b0btFsk03Lusyg3KCwep6S06Ca
         2U9A==
X-Gm-Message-State: ALoCoQma1D9nDOMjs3zgNjTBb8Lvi+iHU8suL9T6e6oVEMzNcezKly+k95XqFDSxNGUMbnRJ6UpfhbHLhCPXQRj2emUC5Tl8xVr6F8jMvWkLnoTXtYpl+eg=
X-Received: by 10.49.48.106 with SMTP id k10mr10565167qen.57.1389380778586;
 Fri, 10 Jan 2014 11:06:18 -0800 (PST)
Received: by 10.96.76.5 with HTTP; Fri, 10 Jan 2014 11:06:18 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240308>

I found this mailing list thread discussing the problem I'm currently
experiencing: http://git.661346.n2.nabble.com/Fwd-Error-with-git-svn-pushing-a-rename-td7599382.html

Apparently a patch was submitted to fix this bug and I'm trying to
figure out what version of what I need to fix this bug.  The inability
to rename a class is a pretty limiting.

My environment is probably different from most.  I'm using cygwin.
This makes it very difficult to use different versions of
git/svn/git-svn, but I'm interested in learning git more so I'm
willing to try whatever it takes.

$ git version
git version 1.8.3.4

$ svn --version
svn, version 1.8.5 (r1542147)
   compiled Nov 25 2013, 10:45:07 on x86_64-unknown-cygwin

Copyright (C) 2013 The Apache Software Foundation.
This software consists of contributions made by many people;
see the NOTICE file for more information.
Subversion is open source software, see http://subversion.apache.org/

The following repository access (RA) modules are available:

* ra_svn : Module for accessing a repository using the svn network protocol.
  - with Cyrus SASL authentication
  - handles 'svn' scheme
* ra_local : Module for accessing a repository on local disk.
  - handles 'file' scheme
* ra_serf : Module for accessing a repository via WebDAV protocol using serf.
  - using serf 1.3.3
  - handles 'http' scheme
  - handles 'https' scheme

Thanks for the help

--
Thanks,
Dan

-- 
CONFIDENTIALITY NOTICE: The information contained in this electronic 
transmission may be confidential. If you are not an intended recipient, be 
aware that any disclosure, copying, distribution or use of the information 
contained in this transmission is prohibited and may be unlawful. If you 
have received this transmission in error, please notify us by email reply 
and then erase it from your computer system.
