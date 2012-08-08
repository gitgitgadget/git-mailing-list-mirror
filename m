From: Andrey Pavlenko <andrey.a.pavlenko@gmail.com>
Subject: fast-import error: fatal: 'refs/heads/master' - not a valid ref
Date: Wed, 8 Aug 2012 11:25:02 +0400
Message-ID: <CAHSUVA5y1nZG69JbvC-wbmHhjyBGLx8Z2TM3htEyuCsWj=A+aw@mail.gmail.com>
Reply-To: andrey.a.pavlenko@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 09:25:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sz0dk-000146-BV
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 09:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757849Ab2HHHZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 03:25:04 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:45161 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756916Ab2HHHZD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 03:25:03 -0400
Received: by obbuo13 with SMTP id uo13so745768obb.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 00:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=bWHjUeRbabVTqQhOA0dKE7OBinuv7tyCHNwiEmoVZto=;
        b=qMKbVXXjbZ0WtUr8x1Gx8Vyc2p5pkyQJVO7uPLo7yqbY6d3m179zCFmxSqqvVzwuL9
         3+aDl7TUSf9EZi7kSfbzTfcnxudk2PNwfoLT8NK0+RlAcGcOrvXvF0dYVaPZiDoeffEw
         qVgCQ1QvldGox/82GnYC/xF54RE8hKfCOWoDBT7sMWHfGsG8aXzQPrpemO9QJSTlQMoY
         7+uqsSGvKe1K9W8SMi9i1vrmTefBXJgh62QiALNEDXzhcvKIjQX6li0U75Cs1Bg2XUlY
         iFBmd74H3h/FtX2vI+1odqb8I2hAguL1nUGo1CyGnG7J0Sa2f/FsUbyJjB4Y3B2VI/pQ
         1h6Q==
Received: by 10.60.29.230 with SMTP id n6mr28472503oeh.22.1344410702616; Wed,
 08 Aug 2012 00:25:02 -0700 (PDT)
Received: by 10.76.124.202 with HTTP; Wed, 8 Aug 2012 00:25:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203065>

Hi all,

I'm developing a remote helper which uses the fast-import stream for
fetching. When I perform cloning git prints error message - "fatal:
'refs/heads/master' - not a valid ref", however the clonning completes
normally. Each my fast-import commit command starts with "commit
refs/heads/master" header.

What does this error message mean and how can I fix it?
