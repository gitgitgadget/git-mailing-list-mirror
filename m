From: Duy Nguyen <pclouds@gmail.com>
Subject: Project idea: github-like diff view
Date: Sun, 20 Apr 2014 16:58:28 +0700
Message-ID: <CACsJy8CQxPrqs31nBvr_oPRD3EJ6Hu-Lq=++7nWpxx5BQZYi8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 11:59:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WboWe-0000A4-F2
	for gcvg-git-2@plane.gmane.org; Sun, 20 Apr 2014 11:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755196AbaDTJ7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Apr 2014 05:59:00 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:56105 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755172AbaDTJ67 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2014 05:58:59 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so3060135qcx.41
        for <git@vger.kernel.org>; Sun, 20 Apr 2014 02:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=g5HKTsaEsfYqXvWJjTEIBjf6wnmA/dEbbHLIVloaHJ8=;
        b=mnHuOl/Xdw9lHr1qEaoQrZN1K7+tAoB9bNOfXP0GIx/KWVwPVWephVpWiJF79QWWXo
         +Q1E1DyyBVuJtKoENbHWJrbhQejQBbmBMAxXMf8pS/YOrf392+wie6MbMYWPc6kbvYsV
         5Y2bLuCAaAgeid2spyy0oBC091k7IaO4PJMdTmGQdYfq7IkUp1S39viZw1R226xDuwhm
         kB3CM6Ru7XFyWvJsukyM1aVGr/t+UcqNgt/nZR4wCLg1MbLSmQYTBvgfE1VnlH+WKaqM
         vdjWdMvR+W5yL6nojOFJowXoL3vMYUQP/AhNNjxqI3fUE+D2pzQm4GOaC25cL4L5wFKq
         TFoQ==
X-Received: by 10.224.87.132 with SMTP id w4mr2630249qal.89.1397987938443;
 Sun, 20 Apr 2014 02:58:58 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Sun, 20 Apr 2014 02:58:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246548>

When you view a commit from github, it shows extra info besides
standard unified diff format:

- the column number of each line (useful for jumping directly to that
line without manual counting from @@ line)
- --color-words within unified diff format, using background color to
show what part of the line has changed. This is only enabled for
1-line changes.

These can be implemented and seem useful, especially the --color-words
item. Once you get familiar with diff.c I suppose you could implement
both in a week (the first probably takes just a day).
-- 
Duy
