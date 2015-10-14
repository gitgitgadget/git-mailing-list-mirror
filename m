From: =?UTF-8?Q?Rados=C5=82aw_Warzocha?= <radoslaw.warzocha@gmail.com>
Subject: [Bug?] .git visible in git-status
Date: Wed, 14 Oct 2015 15:21:40 +0200
Message-ID: <CAA4qsDT66o3ZTCsEoNQ_yP6O0fNgdMA=RZ8OWUMB-gp-A4pj0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 15:21:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmM03-0001zR-26
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 15:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753984AbbJNNVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 09:21:42 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:34085 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbbJNNVk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 09:21:40 -0400
Received: by igbni9 with SMTP id ni9so78829993igb.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=o5KbjKK3xZVSC61FfOSlcpPshRiD3zoRS5KwZ36ijfI=;
        b=TFjrmnaxJW9UKMwM+82tnROwLUdlfcmWokOg8FW7dtDHbx3jd8rzrezpmweweBp4wM
         M5gALzbiiqLH3y3qdUsjlzt45qZXR+sxKb2Q9pkzGliSEo/U1J/y91j1BAfySc3XIM6f
         WpbCQgn6VhQkf2MxQeMn3wgGXuaFZMQ5ltwczsFpSFlj7i47mHuBI4+njd+8PvSzwNK5
         pqnLxoULo+Zne2cIuoQLoaTuZRkFJmllJOBftQA4b9bcP4CMd6PpLPpBt87fs/AmY7jw
         T47IsNTFzclCSpSPYKj9pVm7edJJseku2vUh+aqgXX3moNzZUCZw2LdLK8OL4ckznMuv
         6Hjw==
X-Received: by 10.50.29.101 with SMTP id j5mr24507139igh.70.1444828900081;
 Wed, 14 Oct 2015 06:21:40 -0700 (PDT)
Received: by 10.79.69.65 with HTTP; Wed, 14 Oct 2015 06:21:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279572>

I've recently stumbled upon interesting issue - .git/* files occurring
in the git-status output.
Let me elaborate:
1. When running
> git status -s
no .git/* files are displayed
2. When running:
> git status -s .git
only an empty line is printed out
3. But when I run (for example):
> git status -s .git/HEAD
I get
?? .git/HEAD
Files are listed also when -s option is not present. When providing
.git/* all of the files under .git directory are printed.

I don't know if this is desired behavior, but i guess it's not.

Best regards
Radek
