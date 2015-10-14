From: Xue Fuqiao <xfq.free@gmail.com>
Subject: [BUG] Broken links in Git Documentation/user-manual.txt
Date: Wed, 14 Oct 2015 08:52:36 +0800
Message-ID: <CAAF+z6F3Yej0ByAL1bGnG7qGRLz_HnpwVRqFVVHiMOebNRmSmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 14 02:52:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmAJ8-0005Dd-5m
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 02:52:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbbJNAwi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 20:52:38 -0400
Received: from mail-io0-f178.google.com ([209.85.223.178]:34760 "EHLO
	mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbbJNAwh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 20:52:37 -0400
Received: by iow1 with SMTP id 1so40012231iow.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 17:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ARIJ9ra/STpDRPYOX0+XVdY6kxJuXXhGCQ6nONBDzo0=;
        b=MP3mI0UoaAWC6SaDmqWZ+iZMW0wRBPRTUN8yDszYvvHozkmQyq/vET51oLz8hr4tj/
         hpSuNgTwGkfQSuqTEzDJ0JFxgUn6ABYsXrfJSeb8CrEqJrMvzmT9sMhYUeiDHuj0YKFo
         DHtwStvk3kTkSP29whDur0yofLKkqzSnq8+HjZvpyF9yee6LnhSuOz3QjgsWt1uoPx32
         kEh5Ei/2AbCTcj1aOBIyejHViaolJvo/z6hdoDKUp6vDT8NxVsPnVgUFnlBJmut/APVA
         Lie9VG4566UFqEiv8HiMS5Mp/Pt2uEbX3aw1Grr8fUFS9eKLsEda0zzYIXKU3TWHzLec
         pP6A==
X-Received: by 10.107.16.80 with SMTP id y77mr757970ioi.183.1444783956771;
 Tue, 13 Oct 2015 17:52:36 -0700 (PDT)
Received: by 10.79.94.2 with HTTP; Tue, 13 Oct 2015 17:52:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279557>

Hi list,

In https://git-scm.com/docs/user-manual.html , all links to the
glossary[1] are broken.

I'm aware of a recent bug report about broken links ($gmane/279048/),
but that one seems unrelated to what I'm reporting.

[1] For example: https://git-scm.com/docs/user-manual.html#def_head
