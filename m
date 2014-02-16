From: Cameron Taggart <cameron.taggart@gmail.com>
Subject: what the text=auto docs should be
Date: Sat, 15 Feb 2014 23:36:50 -0600
Message-ID: <CAABik=swf_FLpnKOxehbfxu+pEx2wN7Tnw+=VQRAp2_DMR0+nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 16 06:37:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEuQ1-0000Yv-6X
	for gcvg-git-2@plane.gmane.org; Sun, 16 Feb 2014 06:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbaBPFgw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Feb 2014 00:36:52 -0500
Received: from mail-oa0-f53.google.com ([209.85.219.53]:63679 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbaBPFgv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Feb 2014 00:36:51 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so15956235oag.26
        for <git@vger.kernel.org>; Sat, 15 Feb 2014 21:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=uU59b5auwWOWuHV1rvzVf+CBBJqvxJmJx7NLbCTwRW0=;
        b=RDdb91yvqFDu7TsRfvdnUQ0IMoA56jnFVwnQT+rvkxKWVx+3HGyUyZX15EhHWkjPKQ
         yZD6Cw9Y36h8R2Gy+FPfKswoWkiC6YrzROceCwWPNN0rLFsZUdTcHLTDlJP5kTbaobjf
         XKe7PwSEaP9iBlHKD9LMlEd3DDYGpdTLdbB5xturkpr7/1kyp18EszvrXfC2G1Yr4sem
         DOn9+A6xiBIefxDxklr1Yk0Lo4HBQkOr0CPOeNane2gASJZ/+EOdfM5rFAd6PYe2rUne
         LLliW70gJe32eTvqmJ4vR5dVCtplQkRkwXEl5dGEKaRZJLEePsH0V9Dtp7DcXKRijTeb
         7Esw==
X-Received: by 10.60.123.10 with SMTP id lw10mr14764006oeb.24.1392529010411;
 Sat, 15 Feb 2014 21:36:50 -0800 (PST)
Received: by 10.76.82.129 with HTTP; Sat, 15 Feb 2014 21:36:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242214>

It would be better if the text=auto section of the gitattributes
Manual Page had this:

This ensures that all files that git considers to be the text will
have normalized (LF) line endings in the repository. If
core.autocrlf=true, core.eol will be used to normalize the files in
your working directory. core.eol defaults to native line endings for
your platform.

I researched and put my thoughts down in a blog post:
http://blog.ctaggart.com/2014/02/time-to-kill-carriage-return.html

cheers,
Cameron
