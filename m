From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Cygwin + git log = no pager!
Date: Fri, 21 Feb 2014 23:18:44 -0600
Message-ID: <CAHd499BT1Q308+q0NB9Dpx=ncQZwRn0tg=q_PE8RutaVqH+xQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 22 06:19:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH4ze-0000VH-Ka
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 06:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbaBVFSr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 00:18:47 -0500
Received: from mail-vc0-f181.google.com ([209.85.220.181]:56366 "EHLO
	mail-vc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbaBVFSr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 00:18:47 -0500
Received: by mail-vc0-f181.google.com with SMTP id lg15so462614vcb.12
        for <git@vger.kernel.org>; Fri, 21 Feb 2014 21:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=ud4wthPpPO7ZOKiL5qr3e58RBpDixhXAO7266qEbSW0=;
        b=DNEGNq+uwvdM61qOY3HhW4Rbw37nEhv7uRa7eIJgdrsyCC/0JuHl19z2g1MPGojttJ
         gQvXvWwntb3j3FqMXxHze5d640yqyPn1VJvtVosEpNTNOJhxCcoOjE113XNX2g0a/VEI
         xfGDnZvYnKIZrs59TZq2NFMVmx9FYcvVd0ATHUeSnYz03NHrqFR770FZL9q26QdnDagz
         KvUP611Z2jV2huaUVubZqDs4Xa7t6bkCYwF2G348wN24o0o6hXhGOHhRS4DP57Z3AcJj
         H7fsa01ACuFijK3J7GnkjiddZOcr/ouYQzmsCiGSVxpJQvzN4Fdj3xae9E6YSl0nu6WR
         R9Vw==
X-Received: by 10.52.246.42 with SMTP id xt10mr5963352vdc.9.1393046324280;
 Fri, 21 Feb 2014 21:18:44 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.221.49.68 with HTTP; Fri, 21 Feb 2014 21:18:44 -0800 (PST)
X-Google-Sender-Auth: CHMzs_VMFrmGUq3yaMzK4bk0w9A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242500>

So it seems that the pager doesn't work by default when running `git
log` from Cygwin like it does in msysgit for Windows.

I know I can pipe to `less` but that requires the additional typing
obviously. Does anyone know how I can get the pager to work in Cygwin
for git log, reflog, and other commands like it does in msysgit?

Thanks in advance.
