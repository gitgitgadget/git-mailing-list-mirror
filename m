From: James Gregory <j.gregory@epigenesys.co.uk>
Subject: git-fast-export is returning streams with source code inside
Date: Mon, 1 Aug 2011 12:57:58 +0100
Message-ID: <CAFC9htxwRg=+RD68hnnRy0hfptq23x3bL+xxHieK1evfFCTPjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 01 13:58:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qnr8H-0006M2-T2
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 13:58:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686Ab1HAL6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 07:58:01 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51308 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab1HAL57 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 07:57:59 -0400
Received: by gyh3 with SMTP id 3so3371531gyh.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 04:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=epigenesys.co.uk; s=google;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=cnFj0fob001/1rxOWcS34OlT8Z15ZnLvfMFML2J8E30=;
        b=ZN8yKK8Ohrwep6bFYNSfMCX3cv8eW5B7D20LgjMrpLGZdmSW0Di1neUCsplW+1aXmi
         +il29cAkHnp4dOYpugfCnGubuSnYmYB/Sz91/TzwgUvgrPb0UnFcHbGPyPs/tb+QNzSk
         OpCM3MdRf86VQVSuBrYXhbVP25O+3CSw8hCNM=
Received: by 10.142.141.13 with SMTP id o13mr3030856wfd.155.1312199878306;
 Mon, 01 Aug 2011 04:57:58 -0700 (PDT)
Received: by 10.142.71.15 with HTTP; Mon, 1 Aug 2011 04:57:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178342>

Hello,

I'm not sure if this is the right place to post bug reports - if not,
please can you let me know.

I've found (what appears to be) a problem in git-fast-export. I've
filed a bug in Launchpad, but I'm not sure if anyone from the Git
community actively monitors it so I'm reporting it here to see if it
can be fixed.

The bug can be viewed online at:
https://bugs.launchpad.net/ubuntu/+source/git/+bug/815828
and I've done my best to describe the bug in some detail. If you need
me to elaborate on the problem further, don't hesitate to let me know.

Thanks,
James

-- 

James Gregory
Senior Developer
epiGenesys - a University of Sheffield company
Enterprise Zone, Portobello, Sheffield, S1 4DP, UK
T: +44 (0)114 22 21 884 ~ F: +44 (0)114 22 24 042
www.epigenesys.co.uk ~ @epigenesys
--
This email and its attachments should be considered confidential and
are intended solely for the individual to whom the email is addressed.
If you are not the intended recipient you should take no action based
upon them, nor should you copy or show them to anyone. Any views or
opinions expressed are solely those of the author and might not
represent those of Epi Genesys Limited.
Epi Genesys Limited is registered in England and Wales with company
number 06388971 and has its registered office at 40 Leavygreave Road,
Sheffield, S3 7RD.
