From: Guilherme <guibufolo@gmail.com>
Subject: Doing a git add '' will add more files then expected
Date: Mon, 17 Nov 2014 17:25:10 +0100
Message-ID: <CAMDzUtyhNKdzHQK2zLEutJRcRUibhO-U6Zh0yJhrx-YxBqP5cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 17 17:25:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqP7l-0002eN-HT
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 17:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbaKQQZy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 11:25:54 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:53211 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbaKQQZx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 11:25:53 -0500
Received: by mail-wi0-f171.google.com with SMTP id bs8so3825800wib.10
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 08:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=8lNleiVgLv5a/Qw3yeNEwXNVgZutoR2B4x2RvjPessE=;
        b=mWJ7u6/SVG1P0RqfqTqnFteuTM9OooS5oIWBqySphtU2e3FaE41KHvUFqsG5nq1Vgv
         PE/89yNXazqJ8AQhENWIH6Zyp3JDKHKrF/p+XNQk/v2VM5gT8PvAlD7bTO3gxfKrei2o
         3BZo1AMndhIk5AfOkcjXLrI4kRn908YhQCQIRoPVSNhIuXL3vaiJeK+G5paKc/UrlrGp
         TPSpKmYELuV2H2VGEiP74MGGoAku8cz+AxkSgpWJqNJpSgqvEszTnh6l4C2CbqhL5lVz
         N9DoCs2ioVY4O3W7rQ9r1X+kRrAaqFiFSCk4ilWIrDbl0WE6+itKG2M4mTH8a8q+aTNL
         a+0Q==
X-Received: by 10.194.95.100 with SMTP id dj4mr39106667wjb.48.1416241552081;
 Mon, 17 Nov 2014 08:25:52 -0800 (PST)
Received: by 10.27.54.80 with HTTP; Mon, 17 Nov 2014 08:25:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

I first asked on stackoverflow
(http://stackoverflow.com/questions/26933761/python-sh-module-and-git-try-to-add-more-files-then-in-command/26934517#26934517)
about this behaviour.

Then on the conversation that happened on the git-users mailing list
other agreed that this behaviour is probably not as intended.

Steps to reproduce:
In bash (not sure this is bash specific) do:
git add ''
(that's to apostrophes, an empty argument)

Results
same as doing git add .

Expected
no files added or error about not finding file ''

Hope this helps.
Guilherme
