From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [ITCH] push the HEAD I mean
Date: Sat, 11 May 2013 01:28:13 +0530
Message-ID: <CALkWK0k5t9D2F_6d3A5pyUirDp=U=U6HwwfStiS7HPJVUvE0_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 10 21:59:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UatT4-0004eo-GV
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 21:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753588Ab3EJT6z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 15:58:55 -0400
Received: from mail-ia0-f173.google.com ([209.85.210.173]:57133 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753123Ab3EJT6y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 15:58:54 -0400
Received: by mail-ia0-f173.google.com with SMTP id l25so5149376iad.18
        for <git@vger.kernel.org>; Fri, 10 May 2013 12:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=gK2z0n8glM7FgavjTHR6VZmkCPuhiuJbZB8katzwLxk=;
        b=WkSKQ2dcQ0R/942pSnWfJ/5YFo8Rb+4M3mbbm7HwUKiQkYEnoxGIIyxoDVREqqQule
         49DNon4+E7AMRSKFmzdO+6hU9jo+rl9poFObY4PkyDvbVUfLGIp9D7XYY3dcUwnQkhPO
         w3oB1D6q4gXaQoDEjvz8NlDndXXda+ccwys2BQZ7xYcckRw6i0un+3RBhISs54BGgsFA
         4qrweOLhrUJ8sI5qeZsRZUUeYgFXc//fdl2Q+hsc/WzJkVCW0mcEf0dCABY/CYw2N3OP
         FfmMCrPb+mIQAtXdmb8UlvqTxgbx7WZgWt2T4hbcOnhNoo7JS82dDQ7ww4Ugovjch8WL
         m5Qw==
X-Received: by 10.50.147.71 with SMTP id ti7mr3238991igb.49.1368215933992;
 Fri, 10 May 2013 12:58:53 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Fri, 10 May 2013 12:58:13 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223900>

Hi,

My push.default is current.  I often end up doing:

    # on master
    $ git push
    ....
    # switch to another terminal
    $ git checkout rebase.autostash
    $ git rebase master
    # go back to previous terminal
    # push has failed

This happens because push tries to push rebase.autostash instead.

Should push make a copy of the HEAD ref when invoked, and use that?

Ram
