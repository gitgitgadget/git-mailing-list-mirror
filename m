From: Thibault Kruse <tibokruse@googlemail.com>
Subject: default remote branch
Date: Fri, 18 Sep 2015 11:50:25 +0200
Message-ID: <CAByu6UUxsWu5RVar=8uKJw3kZpxjawqbwABgNREjJ3g3mGDwVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 18 11:51:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcsJN-0002Mj-U1
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 11:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752859AbbIRJu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 05:50:27 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:36691 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbbIRJu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 05:50:26 -0400
Received: by obqa2 with SMTP id a2so33787497obq.3
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 02:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=4LNnCqhHSM4p1dg11f9fqPn1TprUrHgU3P39tEcJ/mo=;
        b=Eud+4xKeR4EujchOaDnnPWvKS6z+ECmS3RJQwnzdzBQAy1hs+aOQOoZ+8YxVlqpAc6
         o4IeQmHf3eoktERByrVjZc7U0wgrk4PWweWG5tz+YHi3TOJ6+Zyir3QRI51enZFWZkZm
         SJKBzYnrVmqRM9W7h37Hm03S4oNgtQhh1tJyyIi8X5kkLoBtQFfW6VKl16xq8q5acoLd
         TF8ZWiRnsH7hjZYW7nGmkS0kbRlPleRBEfUo2wsvlYY1WJdOsCdVIhQikWO5NnGUGCzA
         4mj/XoVZ/GUdwuuEl/F5ncQXF8tLT7MqIuEo8ON0NpImk7OKn4l+c1KvMRGp3ep8xpR2
         bzxw==
X-Received: by 10.60.69.39 with SMTP id b7mr2796268oeu.51.1442569825636; Fri,
 18 Sep 2015 02:50:25 -0700 (PDT)
Received: by 10.182.241.65 with HTTP; Fri, 18 Sep 2015 02:50:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278188>

Hi,

the 'git remote show <remote>' command shows the default branch among
other things.
The default branch being the branch that a clone will have immediately
after cloning.

Is it possible to run a command that only shows that default branch
for a given remote?

Also, I tried finding out whether I can use the
.git/refs/remotes/<remote>/HEAD to check the default branch without
accessing the remote. However, I find this file is not updated with a
git fetch, nor created when missing.

So is there a sane way to get the last know default branch without
accessing the remote?
If so, is there a way to update local information about the default
branch of a remote?

cheers,
  Thibault
