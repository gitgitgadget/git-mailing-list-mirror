From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: git index containing tree extension for unknown path
Date: Wed, 21 Jan 2015 17:14:19 +0100
Message-ID: <CAENte7gqKpqr=ENOEN_3s3Fz6gc-Kt70OJyZojbgwhR7YVX6Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 17:14:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YDxvY-0005Ha-U0
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 17:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbbAUQOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 11:14:41 -0500
Received: from mail-we0-f180.google.com ([74.125.82.180]:44767 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbbAUQOk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 11:14:40 -0500
Received: by mail-we0-f180.google.com with SMTP id m14so18817204wev.11
        for <git@vger.kernel.org>; Wed, 21 Jan 2015 08:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=425CZFhM7EhWsYi/zk57JvLWYc8V4fUL8XaZfZxlD78=;
        b=PxK6lQEC0pjOoaG8xDuVuceiWk0Xwe+D4oPahu69Aw7P7Wfg9m3mZidthD0Y9ID+nH
         0J++8euwjopaEG6WqJTuydrkUDd6WjbJFgi9BVzTI78b1U9wYIURT3HkjkwtfDd8pZ6q
         0I32JYaMnYpqh9ukVhjcuc/9hyWc5SQf04p9BetKJz6FER0nKzmdPaSYn8INJrfNz7Ou
         a7QkxNA7BgbTCrS+hXAjPo2FjhkeH8uq7ywKod5UkOpmh/zCRZy/JsNCABt8N0zm1Fgk
         valCFsTjfgaLhCplXflUokECrqm0pIfvKSP2c1iVbz3XotKwG5uK8yDrAkBNhwIFbpnt
         aLPQ==
X-Received: by 10.194.202.129 with SMTP id ki1mr5675760wjc.76.1421856879215;
 Wed, 21 Jan 2015 08:14:39 -0800 (PST)
Received: by 10.27.148.3 with HTTP; Wed, 21 Jan 2015 08:14:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262730>

Is it allowed that the git index contains a tree extension mentioning
patch 'x/y/z' while the only entry in the index is a '.gitattributes'
files in the root?

I have such a repo in a bug report against JGit [1]. Native git has no
problems with this repo but JGit can't read such an index. I am
wondering whether such a index is valid.

[1] https://bugs.eclipse.org/bugs/show_bug.cgi?id=457152
