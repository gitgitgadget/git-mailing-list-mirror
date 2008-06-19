From: "Alf Clement" <alf.clement@gmail.com>
Subject: git-diff question
Date: Thu, 19 Jun 2008 13:48:22 +0200
Message-ID: <556d90580806190448y2bfeebardb05c5b0b91e53a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 13:49:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Idn-0005kX-V2
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 13:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbYFSLs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 07:48:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754030AbYFSLs0
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 07:48:26 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:50130 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754012AbYFSLsZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 07:48:25 -0400
Received: by fg-out-1718.google.com with SMTP id 19so366127fgg.17
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 04:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Qg/pUoHUlt0OQmBfY5vUTVOTV9PMbq+ADA5J88/8BU4=;
        b=GZ8cKHJwWQSK1IDnbPZ5U38oONCnB5Hwg4PVIuZcmQDJPgnd/PO7dgYaaXA7XWKtEv
         +nHs707ZU1DSGTuYAzK66p7wZKQoLRyfI+H1zvYB+drGAR2L2xJqWjt3ijOzQPYxe3ev
         xzJOFGRHrNoO/ZUoGxuUBzIblyUmubejWf6n0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=mSZCjjP4pIucizcR/aHVo9UZxCo9hAJYDvz0smLOaNOvH0tNEEZ8B0JjKRWPOn3tWm
         utI2bcaqM/PqKFWpyyGLv0VM6doBLOK8tZkoaYHdJEyqJnvbG0mfvBd225erWxmrlhOt
         xYH0/b6NMjTaM8z8QKryKIiGZ1vDBwfb1F8Lk=
Received: by 10.78.182.9 with SMTP id e9mr959347huf.91.1213876102144;
        Thu, 19 Jun 2008 04:48:22 -0700 (PDT)
Received: by 10.78.144.6 with HTTP; Thu, 19 Jun 2008 04:48:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85471>

Hi all,

$ git diff
diff --git a/Firmware/Firmware.ccscc b/Firmware/Firmware.ccscc
old mode 100755
new mode 100644
....
returns a list of files where the mode was changed, which seems to be
correct. Also
modified files are flaged.
I wonder why
$ git diff --diff-filter=T
outputs nothing.
I am running this under cygwin.

Thanks,
Alf
