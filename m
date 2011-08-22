From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: (very minor) should git-gui 'unset TERM' before spawning 'git push'
Date: Mon, 22 Aug 2011 08:00:12 +0530
Message-ID: <CAMK1S_irGNUVKda4bNHVJi_5ye-51Vkj4CqrNF44sW4sV6xYyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 22 04:30:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvKHO-0004L5-FV
	for gcvg-git-2@lo.gmane.org; Mon, 22 Aug 2011 04:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963Ab1HVCaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Aug 2011 22:30:14 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:60323 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab1HVCaN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Aug 2011 22:30:13 -0400
Received: by vxi9 with SMTP id 9so3828387vxi.19
        for <git@vger.kernel.org>; Sun, 21 Aug 2011 19:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=2Trv7afiMDtP6Ttoz7QuYd4JOLwKM4YsvZXYE8c356s=;
        b=hUjCfWBUrxk9zRKJwBh8ujjYctRzs89jZXoQg8YZIELtjDItYh+4CvZIVqb5PfxJTy
         L3q6wxrlNjufsyfwndXKJ98gM9GpYphcQNrWzeG7oFlSh13oAiHexIdOY0LgaZGzOndD
         BT1ymyIZlWYl8r5YkPIX1/3pW29jIHzb+eCFg=
Received: by 10.52.27.43 with SMTP id q11mr1830823vdg.204.1313980212871; Sun,
 21 Aug 2011 19:30:12 -0700 (PDT)
Received: by 10.52.6.131 with HTTP; Sun, 21 Aug 2011 19:30:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179836>

I'm seeing ugly ^[[K (Escape - left bracket - K; ANSI codes for erase
to end of line?) in the graphical output box on a push.

I tried to trace the code and could only find it under mingw.  My C-fu
must be much worse than I thought...

Anyway it happens on a purely Fedora 15 setup with the simplest
possible file:// URL for the remote.  And it goes away if I 'unset
TERM' first, too.

-- 
Sitaram
