From: Alexander Kostikov <alex.kostikov@gmail.com>
Subject: git gc exit with out of memory, malloc failed error
Date: Wed, 14 Sep 2011 18:33:42 -0700
Message-ID: <CAGAhT3mbGB-0q3EKh5MrGqB59wUea7NfaaY18DvnL3qimwh9QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 15 03:34:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R40qK-0000kU-Q0
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 03:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab1IOBdo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 21:33:44 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46908 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752560Ab1IOBdo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 21:33:44 -0400
Received: by wyh22 with SMTP id 22so2229511wyh.19
        for <git@vger.kernel.org>; Wed, 14 Sep 2011 18:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=2zVwOHBouhv7ggwhs37t3VFdPkipSly5TzdvXkMxkzE=;
        b=IbgS/8WZbe5VZuWTYD71oU8e2V+Bf3yMEQija0Pu/8o91FzWJ0t98qqzRJurddr8wP
         qM6+/DoEjRJ3l8gxunogU3uL7WKSRqfJnJ2Uy6UrxUsq+k+fbO0vLbJvLHib9eeCAb/Z
         FdWNpl2Iq8jvBJML8BXHeQx/NWJpo9CZQanSQ=
Received: by 10.216.179.130 with SMTP id h2mr523322wem.8.1316050422791; Wed,
 14 Sep 2011 18:33:42 -0700 (PDT)
Received: by 10.216.159.134 with HTTP; Wed, 14 Sep 2011 18:33:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181418>

I'm new to git and I'm getting the following out of memory error on git gc:

$ git gc
Counting objects: 80818, done.
Delta compression using up to 8 threads.
fatal: Out of memory, malloc failed (tried to allocate 24359675 bytes)
error: failed to run repack

The only advice I found in the internet suggested to run repack with
--window-memory parameter specified. But this call also fails:

$ git repack -adf --window-memory=0
Counting objects: 80818, done.
Delta compression using up to 8 threads.
warning: suboptimal pack - out of memory
fatal: Out of memory, malloc failed (tried to allocate 24356363 bytes)

How do I cleanup my repository?

$ git version
git version 1.7.6.msysgit.0

OS: Windows Server 2008 R2 SP1 (x64)
Physical memory: 24 GB
The commands listed were executed under x64 console process.

-- 
Thanks,
Alexander Kostikov
