From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: git-web and .git and working directories
Date: Mon, 30 Mar 2009 00:58:15 +0100
Message-ID: <5275A78FCB394B609E270F3E4E69B549@HPLAPTOP>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Mar 30 01:59:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lo4uw-0007yj-BL
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 01:59:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbZC2X6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Mar 2009 19:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753631AbZC2X6Y
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Mar 2009 19:58:24 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:58741 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbZC2X6X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Mar 2009 19:58:23 -0400
Received: by ewy9 with SMTP id 9so1846910ewy.37
        for <git@vger.kernel.org>; Sun, 29 Mar 2009 16:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=fD4Qrl5NA+L5RjUoILXGGMlBc4SNhDc4hwrT/oMLhJc=;
        b=CLN/hpQDsWuuQlA8PTnfvZvoC+jxzkXeC75Y8SwIx/tXmj/Cxen9K37hkCC9B2rHHn
         kUdGFqAlPHwO4LY8FH7M9xFji/PASfXEVnZxLy147b0Xi52PjJTjdzlfmwgu1+2MbBqJ
         UTPFQzJ8odB/sx0YlO2GjMlBlwDhC5oh8KO6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=NGWSK1vp8P/F8l9cprfhFiSj2umO1/OZGZQkJbzPWMfv9tG+m36lAxNRiBWDLDPvfJ
         DWQJv6PMmBFWq6aFqaEOtOmAQ1aaGLasP+OeZoQkrS6xV6i8Yy8BOrbCjccPL4vkh4zd
         qHzqFmNgbB84EY8kB8oNdWSVZi6AzkHp9U3NE=
Received: by 10.210.78.16 with SMTP id a16mr792652ebb.38.1238371100679;
        Sun, 29 Mar 2009 16:58:20 -0700 (PDT)
Received: from HPLAPTOP (aarongray.demon.co.uk [80.177.163.94])
        by mx.google.com with ESMTPS id 10sm800586eyz.49.2009.03.29.16.58.20
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Mar 2009 16:58:20 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115049>

Hi,

Is there a proper way to configure GIT so the '.git' suffix does not appear 
in git-web and also is it possible to disable the working directory so 
things are more self contained.

Anyway I have git-daemon, git-svn with a SELinux policy all running on F10.

Thanks for bearing with me,

Aaron
