From: Lynn Lin <lynn.xin.lin@gmail.com>
Subject: git push output goes into stderr
Date: Sun, 4 Sep 2011 17:26:59 +0800
Message-ID: <CAPgpnMQuck_aPU0ciaGgj-C8rno7jbzZ7wZ4unU8CqA0eaiYQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 04 11:27:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R08yt-0007PI-8Y
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 11:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753091Ab1IDJ1C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Sep 2011 05:27:02 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49678 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752974Ab1IDJ1A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2011 05:27:00 -0400
Received: by vws1 with SMTP id 1so3269569vws.19
        for <git@vger.kernel.org>; Sun, 04 Sep 2011 02:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=dwzUbQe5Wm0ZEZ55XQ5p/Haas+b8CJjGLARKIKtOO+I=;
        b=QZWEYp+PB7TB4fGLPqTyP/7xYf+55Il4v5jAyZ374Nl6VB/kdaNTlQ4dwq+0H0rE7Y
         KcWw/BFQUqE1GT14bCv6lXN+w0JUcyx/XbwlmFwi0QHjZATAZd+VVJiQ521KiVfxq8tx
         8/XnQh0E9Rn+g2uQ9lcubHOkhIH8IyC3mPlnk=
Received: by 10.52.177.135 with SMTP id cq7mr2864632vdc.14.1315128419619; Sun,
 04 Sep 2011 02:26:59 -0700 (PDT)
Received: by 10.52.163.232 with HTTP; Sun, 4 Sep 2011 02:26:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180673>

Hi all,
When I create a local branch and then push it to remote. I find that
the output without error goes into stderr, is this expected?

Lynn
