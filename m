From: seanh <snhmnd@gmail.com>
Subject: Files that cannot be added to the index
Date: Fri, 26 Aug 2011 14:26:57 +0200
Message-ID: <CAMvu5bLuRWinMYNc4NoRKQKiLCWLcwkpowEFT4GQ0mcJYj6eOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 14:27:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwvVM-0006ui-0f
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 14:27:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752796Ab1HZM1T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 08:27:19 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:47635 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223Ab1HZM1S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 08:27:18 -0400
Received: by ywf7 with SMTP id 7so2755290ywf.19
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 05:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=6MibRWH7tRG56WiQF8+wYPeiU5EW+2NEg6VH5o7az28=;
        b=cpQkBADJthhcBCtJsABgqd1kTJ0im208imreXTumNhIwSEWZGjn7auHABAIJmuuJeg
         gvZHgNLGOi6u1n3kdEEy0gPK0WVaz/0oBM5xmBgDiXhpAb6YoO7EJ95vWg9DZ2nuMKLM
         stpgidcKo6Z9+YlQxUBoCeq/fL8ysgkNav8I8=
Received: by 10.42.158.197 with SMTP id i5mr1101785icx.156.1314361637719; Fri,
 26 Aug 2011 05:27:17 -0700 (PDT)
Received: by 10.231.13.204 with HTTP; Fri, 26 Aug 2011 05:26:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180163>

Can anyone guess what's going on when I have a modified file that
shows up in `git status`, but the file cannot be added to the index
(or committed)? `git add FILE` does nothing, the file still shows as
modified but not added in `git status`.

I have two different repos that have each developed this problem with
two different files. I don't know how it happened. The problem occurs
wherever the repos are cloned. Even if I delete the local copy (where
I'm seeing the problem) and clone the repo again from elsewhere,
problem persists.
