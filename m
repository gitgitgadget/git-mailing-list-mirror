From: Dun Peal <dunpealer@gmail.com>
Subject: Can `add --patch` display the diff in my difftool instead of just
 printing it on the command line?
Date: Tue, 14 Dec 2010 15:17:09 -0600
Message-ID: <AANLkTi=_VyUAL+qjWLEcThX-zC5n0v0WB-W7hTSZn0ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 14 22:17:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PScFK-0001F4-O2
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 22:17:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760122Ab0LNVRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Dec 2010 16:17:11 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52690 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756097Ab0LNVRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Dec 2010 16:17:09 -0500
Received: by qwa26 with SMTP id 26so1220554qwa.19
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 13:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=vmNQ6ZL+38clDU9SgOM3+GylVEkw4+H39syjC9i4hFY=;
        b=YnK5RvGoufTXV0fJZ7YNrR+hrgddvWw4+azbtxqK5gn0ThtdRmQrhpODU9PU2JYoLr
         qh0QBdRowyY2wx2jgDPPH+lVu+YlKmbIH3x3WjZLs4VJY44C54Dpk1Own7nmD/VGY9Tj
         jXZ/QUlBfOUrB/Yefy6veWbbnAQ2UX22+KfP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=g6h4Qoor+SCQaKselm0og2GH5n7NOA9hswESN8vRsefkxUaZlzyemFS2CyhND92k5K
         ZJjbQHvqxcK+Vaxcv+n3+8P3BhvvBjdij7dfK78vLLYW6mCLyjVUtysPLKIXQr/m0f9X
         pThkIg2VkVWUrS3N5ryLaS5THoGfZI1NbNvwE=
Received: by 10.224.11.144 with SMTP id t16mr5727170qat.99.1292361429133; Tue,
 14 Dec 2010 13:17:09 -0800 (PST)
Received: by 10.220.191.66 with HTTP; Tue, 14 Dec 2010 13:17:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163690>

Hi.

I'd like to display the diff of each modified working copy file, and
have the option of staging (or reversing) each patch after it is
displayed. This is exactly the same thing `add --patch` does, except I
want the diff to be displayed in my difftool (happens to be vimdiff)
rather than just being printed.

Thanks, D.
