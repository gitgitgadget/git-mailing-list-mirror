From: fREW <frioux@gmail.com>
Subject: Deleted files can't be checked back out?
Date: Thu, 22 May 2008 23:28:57 -0500
Message-ID: <fb3648c60805222128v1a425c60kc8e44f3a2fb41d54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 23 06:30:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzOux-0004Ak-U7
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 06:30:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbYEWE27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2008 00:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbYEWE26
	(ORCPT <rfc822;git-outgoing>); Fri, 23 May 2008 00:28:58 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:22390 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbYEWE26 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2008 00:28:58 -0400
Received: by rv-out-0506.google.com with SMTP id l9so529035rvb.1
        for <git@vger.kernel.org>; Thu, 22 May 2008 21:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=/diKIlXDgAyElCC5hM6hTRN1qSeyg+KqWIJATCsWJGM=;
        b=OdFmuaTjBBm9cbpnC0qpY0B32f39jPdua6Y6Exr0ETW6C0mGsFaTcLcMOscSzT+M7BMZF2J1jtgz10JIG5465xHFzcZ42+7mWgtR+BJSX4MjvmiE0FahsMyqyaf1eTx1Km6TQSsAEiZJ4LDxRdce2GeBAxGGGS7i+A9KBjRzqBA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YVDqPb6vZKEypHywD34XWf86J6LZOokLH9ZHvvNn3fGnJfSVydxBnZMn3M1U4A20+t01VUyeActhlNS4jEYfgoyj2QQfXq0I+IMm6KozeXMsgk/ZrYQQMxts9Yn32XpluXiRvuxdMJaIA+yMM7mfP/l9veCiMLWS/7C3TO6xMts=
Received: by 10.140.171.18 with SMTP id t18mr450503rve.22.1211516937586;
        Thu, 22 May 2008 21:28:57 -0700 (PDT)
Received: by 10.141.48.1 with HTTP; Thu, 22 May 2008 21:28:57 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82678>

Hello all,

I recently deleted a bunch of files and checked the change into git,
and then changed my mind and wanted the files back.  I did a
git-checkout <file> and got each file back individually.  Then I did
some work and did a git-push to upload to github. Then I did more work
and tried to do a git push and it gave me an error that apparently
meant I had to pull before I pushed.  Anyway, I pulled, it redeleted
the files and now when I do git-checkout <file> to get them back it
says:

error: pathspec 'foo' did not match any file(s) known to git.

I'd really appreciate some help on this issue. I tried messing with
qgit to look at it, but I didn't have much luck...

-fREW
