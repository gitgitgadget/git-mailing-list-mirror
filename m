From: Jay Soffian <jaysoffian@gmail.com>
Subject: combined diff does not detect binary files and ignores -diff attribute
Date: Sun, 22 May 2011 16:12:53 -0400
Message-ID: <BANLkTi=FtkiUjwAa7e3KAC5FF3GNxWzd3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 22 22:13:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOF1I-0006Xx-B8
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 22:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800Ab1EVUMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2011 16:12:55 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44794 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752791Ab1EVUMy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2011 16:12:54 -0400
Received: by pwi15 with SMTP id 15so2372913pwi.19
        for <git@vger.kernel.org>; Sun, 22 May 2011 13:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=0zr/+VyUjV7U79+orCI09JrQBCkoQwRyn7XxVTeh9GQ=;
        b=F/1A7k/zE3LUkLsIwKs0oWeVxSI2x2KT2LYV1v1SOFxapoOA9ViMZyzv5MNiPlPCvd
         69DlQfY+b3uE7BSvkTLCmUIo+bxP9YAz9BIiD4ycUtWgfFANh/pNuKqIvZxLsoJPmbCy
         a5rh9gOgdtbudyGjN9iBeCB/4rg1VEQpLFK2c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=JZZKLT9mP/JaKzrEd3vvkEE7OJ3R0YnCjylIwPdSvApS8/HfZo+XjlXgnvjm74o1so
         EeEFZc8IGGi172qjoP6bjO3BW1c5UPUG5yitr6P7zJPLD1dQl4by56rjCYbsUXkOsURl
         dMnftG8ga8e3poE6JRclovgxYHZrHYc/37qYg=
Received: by 10.142.225.6 with SMTP id x6mr721035wfg.55.1306095173835; Sun, 22
 May 2011 13:12:53 -0700 (PDT)
Received: by 10.142.13.8 with HTTP; Sun, 22 May 2011 13:12:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174200>

In a merge commit, I added some PNGs (so they were new to both
parents). I was surprised when I did a "git show" on the commit and
had the binary bits spewed to the terminal.

I thought it was just git not detecting the PNG as a binary file, but
adding "*.png -diff" to .git/info/attributes made no difference.

Just reporting this for now, as I don't have time to investigate.

j.
