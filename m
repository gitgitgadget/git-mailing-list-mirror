From: "Francis Moreau" <francis.moro@gmail.com>
Subject: emacs and git...
Date: Thu, 22 Mar 2007 15:53:26 +0100
Message-ID: <38b2ab8a0703220753s67809e87l76ffc57adb725898@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 22 15:53:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUOfU-0002lL-39
	for gcvg-git@gmane.org; Thu, 22 Mar 2007 15:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933058AbXCVOx3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Mar 2007 10:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933063AbXCVOx3
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Mar 2007 10:53:29 -0400
Received: from wr-out-0506.google.com ([64.233.184.224]:32528 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933058AbXCVOx1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Mar 2007 10:53:27 -0400
Received: by wr-out-0506.google.com with SMTP id 41so742594wry
        for <git@vger.kernel.org>; Thu, 22 Mar 2007 07:53:27 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ruDBIqHK4pJyH9VHorwzwmLsPLrgLvVJz3wGc7liVBXy46zn9jxGlqdGlHvWs/tnRQRH3EJLJhPWlQ+iygap5nhb8k9ri8olglQUuBoQImx4xn0K4EwrPCRGYskhNj/EJ9rhFK1ZKSgWXNYp8WVAc+OgPPpb9r92dR/AobVy0aM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=h92v3pS3lWFW/n4GeGu/kJLyT+11A8PmT6nv33jZdlEhqA8A6+rYKK7WoYJq6xdBiEFdGxajIzsgC3IIsE3CrDEArcuVE+K/1szdIktGxCv9SZXcxafb4QNc63iNaqDoY7JmzOwJzS2E1h35EJASQtNT2i6zcsbtCnXX/OJBUR0=
Received: by 10.115.93.16 with SMTP id v16mr631130wal.1174575206378;
        Thu, 22 Mar 2007 07:53:26 -0700 (PDT)
Received: by 10.114.38.12 with HTTP; Thu, 22 Mar 2007 07:53:26 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42858>

Hi,

I guess it's a dumb...

I know that some of you work within emacs. I tried to use git iniside
a emacs shell (M-x shell) and had a weid behaviour:

$ git diff
WARNING: terminal is not fully functional
-  (press RETURN)
diff --git a/.lde/bin/cmd-version b/.lde/bin/cmd-version[m
index a6ce3f8..687112d 100755[m
--- a/.lde/bin/cmd-version[m
+++ b/.lde/bin/cmd-version[m
@@ -54,7 +54,7 @@ gdb_version () {[m
[snip]

I'm not using diff color option.

Can anybody shed some light ?

thanks
-- 
Francis
