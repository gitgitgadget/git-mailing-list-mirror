From: Francis Moreau <francis.moro@gmail.com>
Subject: git-describe fails with "--dirty is incompatible with committishes"
 if passing HEAD as argument
Date: Mon, 19 Nov 2012 16:47:56 +0100
Message-ID: <CAC9WiBjw0W4kLCKMj6HhdjAXOJYpDW2Rgncb+06ahjiYOWtZ8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 19 16:48:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TaTa0-0006e5-Kp
	for gcvg-git-2@plane.gmane.org; Mon, 19 Nov 2012 16:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416Ab2KSPr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2012 10:47:58 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:63740 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab2KSPr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2012 10:47:57 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so4929973oag.19
        for <git@vger.kernel.org>; Mon, 19 Nov 2012 07:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=7mewfMfHTfCpoguLv7MEHicu/8OEmYEFLT7QZbwKx4g=;
        b=a+8BTltiJCef9TR1iXyf1s9ty/b8zoyf3YaQA/NF5z0eoLIJnYtZ86G/4ug16JiNcU
         PKaPvnjHaVb6KS375ANZszs49Rr4z98hiWdnd++LR0tXHTcZp7ALJxnUQ4Rx8XxNZIzL
         pNlCS7fTnETHSuK9hsu0xnnaSK1IY7X5fpAK0UkaYKHB8JLxQ21vgvwcoEC8ErnJBKDq
         tzvu03HJg/VLCcoyUMrCigYe9kfo8QbAcRztboY8A4Q+tjWqpUbCeW7N+3EdiqH+MjyJ
         9oHYqGOEz7R+vVANQPWuqvrajHpJ1n3CSoLwieztBurmB9EIEew/uOODgnH8qrsa45Ip
         rCgQ==
Received: by 10.60.169.38 with SMTP id ab6mr10940793oec.139.1353340076996;
 Mon, 19 Nov 2012 07:47:56 -0800 (PST)
Received: by 10.60.93.163 with HTTP; Mon, 19 Nov 2012 07:47:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210046>

Hello,

Inside the kernel repository, I tried this:

$ git describe --dirty --match 'v[0-9]*' --abbrev=4 HEAD
fatal: --dirty is incompatible with committishes

If 'HEAD' is removed then git-describe works as expected.

Is that expected ?

Thanks
--
Francis
