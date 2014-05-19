From: Alexandre Badez <alexandre.badez@gmail.com>
Subject: Misspelled directory
Date: Mon, 19 May 2014 15:05:42 +0200
Message-ID: <CALQBTK_JchndNSd6ey746vY=N2TiHUc0Z1PJvp-vXYUZCkgc3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 19 15:06:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmNGY-0001Lo-Jd
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 15:06:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbaESNGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 09:06:00 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:52576 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbaESNGA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 09:06:00 -0400
Received: by mail-la0-f50.google.com with SMTP id b8so3988981lan.23
        for <git@vger.kernel.org>; Mon, 19 May 2014 06:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=gtU9PScjsLeehWwPZEvJ3Cz96kRwDguWSVlXroUuOuk=;
        b=j0iUi8xZUHBTH+IFR4/5uWrlgdrp0c69M+7G69YwS4nSg/L4GsUUsbOj1DhbMiVbFo
         x92FMSGXZAmgtpJhWOUASsINT4l195f2WXhGkMQR0FyDo54wNqaWJ1yOBQOisggPGSxe
         hqi8M4oRQm9+paFkuH2EUER0eRzmCUok7+qGNfYXqsYh7wmNFFYfGYTw0EsM6qWnErU+
         d1QUO7uxEmWlnSHHpje7ijfpyRuwQ8kvSjEDPeShXpY3bFAbfbYk8CX13N+/DtGBCrl2
         koGtde4LYLfzEunQxI/V5gOYRm3HU5kti9tY5avvag0jPkjIDO5K13up1LTIUOGKd+fo
         ZaaQ==
X-Received: by 10.152.4.1 with SMTP id g1mr26684768lag.20.1400504757976; Mon,
 19 May 2014 06:05:57 -0700 (PDT)
Received: by 10.114.95.99 with HTTP; Mon, 19 May 2014 06:05:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249577>

Hi,

Today I've issue a problem with git.

I've start a little project on github ( https://github.com/Djabx/mgd ).
And I used https://stackedit.io/ for editing my README.md file.

When I publish it on my repo (stackedit), I've set the destination
file path to "./README.md".

The problem is, that Git commit and create a '.' directory.
Visible here: https://github.com/Djabx/mgd/tree/15a0ec6aee0ae08764623a304e3fc5ce96cef821

The '.' directory is not the same as the root directory; you can see
that the /README.md and /./README.md are different.

I've reported the bug to stackedit (
https://github.com/benweet/stackedit/issues/405
) who ignore it (not their fault).
Asked about it on stackoverflow:
https://stackoverflow.com/questions/23734960/how-to-delete-a-misspelled-directory
And finally found a work around.

My question is, is it really "normal" that a '.' directory is accepted by git ?
Shouldn't it be a "special" case ?

Thanks for your time.

--
Alex
