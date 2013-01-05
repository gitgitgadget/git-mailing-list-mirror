From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: [Feature request] make git buildable from a separate directory
Date: Sat, 05 Jan 2013 21:52:05 +0100
Message-ID: <50E89275.6080408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 21:53:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trak5-0003Gj-He
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 21:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864Ab3AEUxB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 15:53:01 -0500
Received: from mail-ee0-f54.google.com ([74.125.83.54]:33959 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755839Ab3AEUxA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 15:53:00 -0500
Received: by mail-ee0-f54.google.com with SMTP id c13so8869901eek.13
        for <git@vger.kernel.org>; Sat, 05 Jan 2013 12:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=Ww612JEhvRvsPnJXFBfKyQDuBSq67Lqx8uBA4yfN5Y0=;
        b=M+xJTJbFS22dPpwQhwpfboO7UggsPPt90qlFl7zKbSd+t+8+t5rkR5F2qlywmKVF14
         1L2ktiXR4gwhEU7LuywStcihxbdYwUc8/wU2UVfl1kJZr8uGiKkflzcygaQg8zHYD9Yd
         /4QNfmBnTVY7dqMT7dbsohKnqQ/bl33F8a0YaslUEosGXz1skJ9WlMle/KFFP8JfKeuw
         hWfTbGbNbVbXd1RX8vcW2GGRhIwKMvZLqw10s7zBXiTGIOcXjGiTlHhuu+t+IqytKBnp
         QzcuMIH+Pi9h+LnwrWnkEVKdUDnwHQora8EW2kF5y06C0ajOtLL9f+3Oa2xLf/FD1+E9
         fxCQ==
X-Received: by 10.14.223.200 with SMTP id v48mr154434837eep.24.1357419178773;
        Sat, 05 Jan 2013 12:52:58 -0800 (PST)
Received: from [192.168.0.3] ([151.70.204.244])
        by mx.google.com with ESMTPS id e2sm119751757eeo.8.2013.01.05.12.52.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 05 Jan 2013 12:52:57 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212714>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

Many C projects I have seen (based on autoconf, but not always - like
Nginx) allow the project to be build in a separate directory, in order
to avoid to pollute the working directory with compiled files.

Unfortunately this seems to not be possible with Git.
The Makefile seems quite complex to me, so I'm not sure to be able to
change it to do what I want, without breaking it.


Thanks  Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDoknUACgkQscQJ24LbaUTw/QCdHbphkU3Mepo98D07yLaj3YyF
5I4Anii94QDHsC1zm2Jp1hy2X/JFa/NE
=vV1z
-----END PGP SIGNATURE-----
