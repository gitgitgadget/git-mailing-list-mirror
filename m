From: Henry Qin <root@hq6.me>
Subject: Is it possible to build `git` such that the install directory and the
 deployment prefix is not the same?
Date: Fri, 27 Nov 2015 23:19:01 -0800
Message-ID: <CAO8bsPDQ2BX1U0D9=pa99_nkEeRWzuN6QzsMw+2u0GPqO6M9kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 28 08:26:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a2Ztz-0001Pv-ER
	for gcvg-git-2@plane.gmane.org; Sat, 28 Nov 2015 08:26:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbbK1H0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Nov 2015 02:26:35 -0500
Received: from hq6.me ([104.236.142.227]:42279 "EHLO mail.hq6.me"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbbK1H0d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Nov 2015 02:26:33 -0500
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Sat, 28 Nov 2015 02:26:33 EST
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.hq6.me (Postfix) with ESMTPSA id 034E51201E0
	for <git@vger.kernel.org>; Fri, 27 Nov 2015 23:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hq6.me; s=mail;
	t=1448695173; bh=yKN99Jw5qepqJ5OBVxyhjq7Yy8T4T8IZnAqwaYqJr64=;
	h=From:Date:Subject:To:From;
	b=e0BYsne3OQTV+IkhBwh9ZDS68jWaBgzHmXe+fSa/eyKeUJwbFiK+rTHPWw1wgAjse
	 jGx+PJKSFpXMzh2cg27jbbbJmfY086AmvkQrOtsVUKREVQxrUebJCqCE2g95e4Lq4F
	 sSy/AHue5V512fpW9F+I7Yjawx9DNzswpuIYBDc0=
Received: by obdgf3 with SMTP id gf3so96170233obd.3
        for <git@vger.kernel.org>; Fri, 27 Nov 2015 23:19:31 -0800 (PST)
X-Received: by 10.182.116.200 with SMTP id jy8mr37898014obb.35.1448695171240;
 Fri, 27 Nov 2015 23:19:31 -0800 (PST)
Received: by 10.60.80.169 with HTTP; Fri, 27 Nov 2015 23:19:01 -0800 (PST)
X-Gmail-Original-Message-ID: <CAO8bsPDQ2BX1U0D9=pa99_nkEeRWzuN6QzsMw+2u0GPqO6M9kw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281782>

Dear Git developers,

I've looked around the online forums and also asked this question on
Stackoverflow, but have not gotten an answer.

http://stackoverflow.com/questions/33901216/is-it-possible-to-build-git-such-that-the-install-directory-and-the-deployment

Here is the question, copied below for your convenience:

"""
I am attempting to build git from source, and I would like make
install to put the binaries into a directory called dist in my source
directory, so I use the following configure line.

./configure --prefix=`pwd`/dist

Unfortunately, this also causes the build output to assume that this
is the final install location for git, and therefore hardcode the path
into various scripts and binaries such as
libexec/git-core/git-difftool.

Is there a way to specify during either configure or make that I want
a different path for actual deployment, such as /usr/bin/local, but
still have make install go into the directory pwd/dist?
"""


Thanks,
~Henry
