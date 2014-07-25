From: JiaQiang Xu <xjqkilling@gmail.com>
Subject: Git and Openssl license
Date: Fri, 25 Jul 2014 10:46:55 +0800
Message-ID: <CAJoV8tWFKwHikeaK+Aypz+XHkoHa2BUFrvOokWJb=ZUi=zySjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 25 04:47:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAVXk-0001NC-SL
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jul 2014 04:47:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758948AbaGYCrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 22:47:25 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:55381 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757022AbaGYCrQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 22:47:16 -0400
Received: by mail-oa0-f53.google.com with SMTP id j17so4868960oag.40
        for <git@vger.kernel.org>; Thu, 24 Jul 2014 19:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=rAuIn6HdnLGnIqOGytuclfUwNpgk6YtUPmzK0WUgCLQ=;
        b=boztObvIW0q3vmLjDFotiPzwP5qacAWzJL6T/OuKTKeCGHHOBKn8ZX6CyJXf17F1OR
         UlViMPdk8FraxZgJ3pKbaBNyh8HPsARflCJ4y1PtMcw3URAEDSPsHN4xkFE0PXgC95R/
         Bzf1EIkSo+XUZOKqUH6ENY0tIEb4TjLre7iMmBZ1PZ3Gadl1hLnW56t00PIST+aSedq8
         ftWiZQsl4ixAT0hbF97HFJbu4GvcE8URq4FNO6g9VwzskX9k5YXS6aWz83e7c1aJM5tC
         24sNIp0tasM+ycYGOBlVBrnalE8omQ6o0ao2yjB6WQX00ydhCBRcGFS61xbf3iocNArw
         7dsA==
X-Received: by 10.182.112.199 with SMTP id is7mr18769835obb.78.1406256435439;
 Thu, 24 Jul 2014 19:47:15 -0700 (PDT)
Received: by 10.182.153.103 with HTTP; Thu, 24 Jul 2014 19:46:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254193>

Hi all,

I'm a developer of Seafile (https://github.com/haiwen/seafile) project.
We borrowed some source code from the Git project and are going to
license our code in GPLv2. But one concern is that GPLv2 is not compatible
with the Openssl license. It requires an exception.
As far as I can see, Git also links with Openssl library. But I can't find an
exception in the license of Git.
So what I want to ask is that, is it safe for us to use Git's code and link with
Openssl library?

Thanks,
- Johnathan
