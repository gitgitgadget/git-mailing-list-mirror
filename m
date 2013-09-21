From: Duy Nguyen <pclouds@gmail.com>
Subject: teach git-am about patch series manipulation?
Date: Sat, 21 Sep 2013 13:32:55 +0700
Message-ID: <CACsJy8A3E9vnR_L70KMuR8W2acOtX=2F6Vm60KF21VEX2mOPkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 21 08:33:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNGlD-0001S4-Og
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 08:33:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752072Ab3IUGd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 02:33:27 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:51655 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab3IUGd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 02:33:26 -0400
Received: by mail-ob0-f179.google.com with SMTP id wn1so1620900obc.38
        for <git@vger.kernel.org>; Fri, 20 Sep 2013 23:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=WAu3peHXHeiaNO4JGII+TD9aEqCS5KtF6TnY7l1Y6ac=;
        b=hPZgAobZA8J4306NnuLtWOuh1nVUmAZI6x8vZc3cLJJHc1HQyTw4za+dq8pKPLf77p
         FSi0OQlP9DWfiIVQWmefKblX8vRxzQ+EOJAuj1uUN3hX37bM3UrBv97LibIvRRTbpxjz
         /i+ndtMsepIraCENukDyzeO6rGZhRwX6cefRoqc6iLslnXD827QRaYhFMibAmRb4WegL
         3pTuYQlUGjvWgih6M9BZv15wRY16bK2ZlnMdmIHa0Ri3cCbXehXb/Hq5bJAzKHCn9HwO
         aEifRCKSmECk7RLQfnl4fxBApxL1TOZ5NY/rGcsgBvIb/Elk+fxMttRM6Y3ryRh0Opb4
         QgPw==
X-Received: by 10.182.242.11 with SMTP id wm11mr9490181obc.26.1379745205987;
 Fri, 20 Sep 2013 23:33:25 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Fri, 20 Sep 2013 23:32:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235092>

Hi,

The development of packv4 is fun. Like git, patches are exchanged over
email. But the series is long and sometimes I want to modify or even
drop an old patch without sending 90 mails to the list. I wonder if we
should teach git-am more about patch manipulation so that git am could
be told to:

 - fix an old patch (like rebase's "fixup!")
 - delete an old patch (I'm guessing an empty patch with "!drop"
prefix in subject)
 - reorder some patches (how??)

I could publish my branch somewhere and ask for pull. But I'd like to
see if it could be done via email only. And even if I ask to pull, I
need to describe my changes manually. If I can give instructions to
git-am in human-readable form, then the receiver gets my change
summary automatically.
-- 
Duy
