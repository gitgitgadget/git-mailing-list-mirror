From: Mark Parker <godefroi@gmail.com>
Subject: git-svn clone error
Date: Wed, 10 Feb 2016 15:22:11 -0700
Message-ID: <CAN4RHdFEyWL57NkTi4-HGs4NhYBzujgLrbNWzFmTH47b8NF1pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 10 23:22:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTd9N-0000CI-L2
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 23:22:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbcBJWWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2016 17:22:13 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33572 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750943AbcBJWWM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2016 17:22:12 -0500
Received: by mail-wm0-f41.google.com with SMTP id g62so46190521wme.0
        for <git@vger.kernel.org>; Wed, 10 Feb 2016 14:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ZzMrUvfNJWpAFNg5YdXkBeSY6fX5tPpBg31in8O6R6M=;
        b=OuhoMzDKdMyD3pMlB32fHM4Xm829ifD/5ae1YZY8cYcgKd5VggdUd4EA4eWnVGeAJ6
         4EJtArVwro9e7Jpc+oTHhfjHD4cwtqg9XGNXTPLqTxnK3KMUhBJOEGlVHz+T8RXGZtLx
         eFcbUE4ThIfa5fr/Mo9Fy3rfu8bRJVcTj+9PiRwht/SpwhQy6a8neBH3T6HubjDmnLYm
         lT6sr3ugtIs2h4GMPwmBAPF18WMELm8MZuwviWgn8FCrqFT7/kntUIIDS+lHTvW05R4i
         ISSeEfyJFFy5VHaoDf8zqYCZn0Q5qeK9XeKcn0YZA2w9VN1GTF8a7RR2ojKCHApLH/mZ
         PyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=ZzMrUvfNJWpAFNg5YdXkBeSY6fX5tPpBg31in8O6R6M=;
        b=lXo+GRE8vP39VwswyrufxiLit+r/GJ9S4W8TzcLbrzFvbpjzsLj6pihBieCFbnOHoq
         Q3TyNiXYLA7uftP2W/mlId8PZnxxG0vHLEi0QLYJsA4i4znRIOBs/XI7RuTUVT1ZSoE7
         vDZE7RXnOFn6zJ/6slOsdJqTQPph59L1SFei7KKETu8HM7IPfOw1Zc7IBoQ8boVzIIkV
         L6G6wUc0Q6s2S9bKHaap7l06sxaUbNZb5LSAGKWKEUVQl9YY/CIUymFcdAs6VR94aJOL
         DyVFAZRku3zaaBlE59q0dVIsiDc4ZlPRw5WkPRtvFYrYp3woXb2iUMUVM5dpeZP+DUsb
         sz0w==
X-Gm-Message-State: AG10YOR8Qora0daaq/iLqCEsb7oyLio6CJaWgWyYwiZoeak8/q9Qx9GeLsFq5Q2r6aWnj0GGoZEtSzHpvrA0xw==
X-Received: by 10.194.23.232 with SMTP id p8mr49175015wjf.80.1455142931376;
 Wed, 10 Feb 2016 14:22:11 -0800 (PST)
Received: by 10.194.9.163 with HTTP; Wed, 10 Feb 2016 14:22:11 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285938>

I'm attempting to git-svn clone a subversion repository that contains
a space in the name of a branch. This is the result (after many many
revisions):

r148627 = fafd5730f356dcb80f72c9b93f976d9707755a03
(refs/remotes/origsvn/2.0_PriorToStuff)
Found possible branch point:
http://svn/repos/Products/my.product/branches/2.0 =>
http://svn/repos/Products/my.product/branches/2.0%20my_branch_name,
145211
W: Refspec glob conflict (ref: refs/remotes/origsvn/trunk):
expected path: Products/my.product/branches/trunk
    real path: Products/my.product/trunk
Continuing ahead with Products/my.product/trunk
Found branch parent: (refs/remotes/origsvn/2.0 my_branch_name)
5117c44d2cb5ee97d53f93f9c324d6f95ee5fdb5
Following parent with do_switch
Successfully followed parent
r148644 = da01bf418f28e2383a0fbbd7a73a6df0b0b800f6
(refs/remotes/origsvn/2.0 my_branch_name)
Found possible branch point:
http://svn/repos/Products/my.product/branches/2.0%20my_branch_name =>
http://svn/repos/Products/my.product/branches/2.0_branchname, 148650
fatal: Not a valid object name refs/remotes/origsvn/2.0 my_branch_name
cat-file commit refs/remotes/origsvn/2.0 my_branch_name: command
returned error: 128

Indeed, if I do "git cat-file commit refs/remotes/origsvn/2.0
my_branch_name" I get the help for git cat-file. If I escape the name,
i.e. "git cat-file commit refs/remotes/origsvn/2.0%20my_branch_name" I
get what I assume is the correct information.

I'm using Git for Windows, version 2.7.0. If this is a
Windows-specific issue, I'm happy to report it over there.

Thanks,
Mark
