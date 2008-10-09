From: "Leonardo Sobral Cunha" <sobral@gmail.com>
Subject: Different behaviour of rebase -i
Date: Thu, 9 Oct 2008 16:04:32 -0300
Message-ID: <6beb92080810091204n6df4338fs3b182194a8d6454e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 09 21:06:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ko0pa-0005Wr-Hy
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 21:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760746AbYJITEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 15:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760737AbYJITEf
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 15:04:35 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:55825 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760722AbYJITEd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 15:04:33 -0400
Received: by gxk9 with SMTP id 9so483592gxk.13
        for <git@vger.kernel.org>; Thu, 09 Oct 2008 12:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=0X2JG/4XfUNF5q+odoykAux53FE7zJ/5yIXUpN4UW0w=;
        b=gEa5HWq1guAPCodHA3V21B9A7avb1XH/rNWNi5RMo8WPWI5PB8Qsezbvwe5CV7eetw
         SueRuJ2YnTq75eU82oEeMX/6x1Mh69xycRxRbY6c9j3stF8QXmzp/ieSCoKApYWXMPM8
         EX5YxuRMPlswWgoorKeOLeAYc3SZ1m9AxXfEY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Q1qwzh02/gdlwgakEMvStIrYhRdr20QZ++7sIvLYLQacdTJnF/BxtArHzOzS2AM3jP
         Gwzg5SJTb+bC7yn+q4vEAa8+LxZI9JXhPUgoQFGpMEwbeBZzRPSBQXlm6XDt3iCcZsgv
         AMqZDjvoWktk/DYT6xFyGUqsO9QlC+umrWU1E=
Received: by 10.90.101.7 with SMTP id y7mr350860agb.44.1223579072546;
        Thu, 09 Oct 2008 12:04:32 -0700 (PDT)
Received: by 10.90.25.7 with HTTP; Thu, 9 Oct 2008 12:04:32 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97874>

hi,

While doing a git rebase with my upstream branch ahead of my local
branch, first git rewinds my local branch to point to the upstream and
then prints "Nothing to do". As expected, my local branch ends
pointing to the upstream head.

But when I use the same command with the same branches using git
rebase -i, nothing happens  and my local branch does not point to
upstream (the behaviour is different).

Is this different behaviour of rebase -i expected or is this a bug?
This is still happening in git version 1.6.0.2.443.g52e83

br,
-- 
// leo
