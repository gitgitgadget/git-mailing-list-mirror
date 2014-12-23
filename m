From: Nathan Mascitelli <nathanmascitelli@geotab.com>
Subject: Gitk Branch Ordering
Date: Tue, 23 Dec 2014 17:58:51 -0500
Message-ID: <CAJddYyi5v6uXCSjmVhi5dDpdtpeFtV7cc4R5veLi1UhOXJ2bsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 23 23:59:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3YPo-0003rn-WE
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 23:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755104AbaLWW6w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 17:58:52 -0500
Received: from mail-qa0-f52.google.com ([209.85.216.52]:60423 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbaLWW6w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 17:58:52 -0500
Received: by mail-qa0-f52.google.com with SMTP id v10so1761395qac.25
        for <git@vger.kernel.org>; Tue, 23 Dec 2014 14:58:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=jhxqwAj0izwDrnKobS+GWSkrD2jsUDg1+CptWXUCDrU=;
        b=FNi+2zDWCsIoQ6H7tfGZ2QiA0kneBgC65KDKRi9YMsT/tnxzk5/jcSFp+OJA32wQAV
         8A63rrOY+/NGiIjNOJbh7lIY8WhfaHanf2S+DfPvz0bv3Bfz8iXeq/hmNSJcjL+6yFke
         H9BCknn31h1MO+gqGKtD8iq0GiOfeOjl9nY7qbNGDu0UgYkriuHzWKWqtMgJEvCEg2LM
         +J61pQqIUOlYFqtkOWvju9ZeSMqA9/jCuAdgEaDQR1aBPTls+EN5qxyf7Z22SAYXt0H2
         Jvca6ROsgf5iTvckTFjlHKnI9UkEulGhkMrE1KfCcuwiSOOZnwNDehj/IXIUQIWGqwkm
         b7Xg==
X-Gm-Message-State: ALoCoQkBsnuGySar/CafX1MQ7VZrV/bL3K9V3uSpfd/BOaERE5QeGeWPWd6NKkrTj1rkCYS7wBEa
X-Received: by 10.224.11.5 with SMTP id r5mr49962587qar.50.1419375531452; Tue,
 23 Dec 2014 14:58:51 -0800 (PST)
Received: by 10.140.94.149 with HTTP; Tue, 23 Dec 2014 14:58:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261779>

Hi,

I have noticed that gitk does not order the branches it draws the same
way as 'git log --graph'

'git log' seems to keep your current branch as the leftmost line. In
the below screenshot here
(https://drive.google.com/open?id=0B9b8DuGRceMSTHgzV3dBZkxiTVU&authuser=0)
master is the current branch. It is the leftmost branch and we can see
that at faf2797 someone made a branch and later merged it back into
master. This is shown as a bump out to the right.

However in gitk this is not the case. In the shot here
(https://drive.google.com/open?id=0B9b8DuGRceMSNUJjbEhGaDZXeTg&authuser=0)
the same commits are shown but the bump is out to the left. Master is
in the middle of a number of branches.

This is counter intuitive (to me at least). I can't seem to find any
setting or argument that will have gitk behave the same as 'git log'
with regards to branch ordering.

Is this possible?

Thanks,

Nathan Mascitelli
