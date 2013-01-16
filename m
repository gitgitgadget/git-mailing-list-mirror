From: Jay Vee <jvsrvcs@gmail.com>
Subject: real git pull grief
Date: Tue, 15 Jan 2013 17:17:07 -0700
Message-ID: <CADq_mb8LwzbjvaXGCR-6TZbTShf2nzw5wtNZ66_XmOM00-=xzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 16 01:17:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvGhQ-00076a-Gh
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 01:17:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352Ab3APARK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 19:17:10 -0500
Received: from mail-qa0-f43.google.com ([209.85.216.43]:42361 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758542Ab3APARI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 19:17:08 -0500
Received: by mail-qa0-f43.google.com with SMTP id cr7so2915157qab.2
        for <git@vger.kernel.org>; Tue, 15 Jan 2013 16:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=kzex2BOcJsCB3SFVTk3xbRgZRHS3cj6SGph3/dNV95U=;
        b=rtICDS5YNOa6pdx7p5TKkG+lF4b+HqwHzkkrIysLRQsZTe+uXv8pMCQz4ULUN83IFJ
         9LDtyDrHVmsCOyPxKHHl5VgJa2tq1VmBAMWEFVtUQ4a5eNNhgtyFzVLdCUpILkdhgYaZ
         Ji+o8weTZ7LAZvnUUDhbNfMy91vqM1FbFdtzhY8fzprLbjCMDrXKeEKfg7gCCLeV1f+T
         aNVLCDbmqfoSqVWJDm6bcuGHdsGnQy2urFetRlStyxgB9WyfAM3rOx9+CGIK78RGkyQU
         +xVLT6yaw5JP8oL9MA0rsJaOSSC21OCfsTOiNY3l3oWQmbnxQhkHK1/bQCNpOOoiCXkt
         paAQ==
Received: by 10.229.174.92 with SMTP id s28mr14097262qcz.72.1358295427748;
 Tue, 15 Jan 2013 16:17:07 -0800 (PST)
Received: by 10.229.75.194 with HTTP; Tue, 15 Jan 2013 16:17:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213695>

I have not changed any code and just tried to do a git pull and get
the following message:

Updating 527f1ee..18cf73e
error: Your local changes to the following files would be overwritten by merge:
        java/..../Info.java
Please, commit your changes or stash them before you can merge.
Aborting
----------


I HAVE NOT CHANGED THIS FILE.  It is telling me that my local
changes.... huh? I have not changed or modified the file.

----
When I do a $git status I see a lot of other files that begin with:

#       modified: ....
<many of these>


How do I get out of this mess?  I do not want to reset head.  I want
to get back to the state where it does not think I have modified a
specific set of files... namely the files that I did not change.


How did I get into this state?  How do I prevent from getting into
this state in the future?  How do I get out of this state now?


thanks for all the help.


J.V.
