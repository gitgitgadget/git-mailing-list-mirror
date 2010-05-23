From: Howard Miller <howard@e-learndesign.co.uk>
Subject: gitignore - how to ignore only in current directory
Date: Sun, 23 May 2010 21:28:39 +0100
Message-ID: <AANLkTilGH-Z4IpgosqYPFCl3G2XsKDfAT3pH6vi-wuN8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 23 22:28:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGHmw-0004BK-He
	for gcvg-git-2@lo.gmane.org; Sun, 23 May 2010 22:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753747Ab0EWU2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 May 2010 16:28:42 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:39855 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753353Ab0EWU2l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 May 2010 16:28:41 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1673005fga.1
        for <git@vger.kernel.org>; Sun, 23 May 2010 13:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type;
        bh=fGvvZxj0qxB/iIqEiba3eq8Yh79xPivsCMw9+L+WRbE=;
        b=fuK4HrzQAUds6JoHHDARpfpk2k7gWJ3mGvZ0o5u8l65B21lzpHKiCRtBq0mggZQiZE
         xF0nZ8WsFQD3xwwEJ5uNYOpDo1w9LvQ+J94glCO52Bh7cGiSExpSE+Y+z7ZZZdFUMclD
         mc99pPioJIw6WWhIQFfj9J//5mwKsgzYMoKOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        b=FhHmQhJ00SLMxHLP1mfuWKmNc32M0eIVHClIXwAfdaRSILAzYdM/ZTcovV0Ebu9WKa
         ycjwji6CN9X4cw58TXVVdGW3LuES/Hz6JcMRgdoJTMCy9bLcC09RkWoWN82RIq097eir
         s5Qynr/qITqOwcvukoIj4c38NScux5MxgxCnI=
Received: by 10.239.193.136 with SMTP id j8mr391118hbi.143.1274646519299; Sun, 
	23 May 2010 13:28:39 -0700 (PDT)
Received: by 10.239.133.69 with HTTP; Sun, 23 May 2010 13:28:39 -0700 (PDT)
X-Google-Sender-Auth: puVnWYtvgijnxLaa8iWD3XMY-Tg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147583>

I want to ignore a particular file name in a particular directory.
However, the same filename may appear in subdirectories and in those
cases I do *not* want it ignored. The documentation seems to imply
that git will read up the directories looking for .gitignore files and
will ignore files that I need included.

Have I misunderstood this and/or how can this be done. Any
enlightenment appreciated!
