From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Git completion not using ls-remote to auto-complete during push
Date: Wed, 17 Jun 2015 11:10:35 -0500
Message-ID: <CAHd499Dk44Fq5c_wadxT_kuCs5BdkRwKZWOHyAgE4oi7pezxPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 17 18:10:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5FvF-0008Kj-0J
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 18:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754990AbbFQQKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 12:10:37 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34181 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997AbbFQQKf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 12:10:35 -0400
Received: by igboe5 with SMTP id oe5so83589590igb.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 09:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type;
        bh=3xJKRJB9BqUcvqyHKaWP/h5olWssthXQgnoKg/g1wag=;
        b=O5vEo5H+KDQ8szEZleKlNf36i2/Cc9vHlUDhykqNbHY6ebD6bcUuIMJ7sROueYUhJl
         BeD/6aflJbMy06QhF4N2llDnfE2THRAMK/rAr88d9DEX+2qHYLlZttv/WtztqGACMUWG
         bkorW3RIHX18RhuOjvHT7bIUnNpvs8cIwYAfpBJLids6JPyLIlKFIWB8pu1adHz9Uq/J
         g3wPMaJVhmq4Nyw7rUrEhZUrUAB3KwuqH8zMfJ5AUW4uuRkglGjDxEyZ5xBZj166yi58
         aa/vJE2ZlP/g61vGdv4LxYbw79sdJHR3fQmZsc/enPX041suk/IdZiCfyUYy/1oYSYhI
         BzWg==
X-Received: by 10.42.83.212 with SMTP id i20mr982618icl.91.1434557435149; Wed,
 17 Jun 2015 09:10:35 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.86.148 with HTTP; Wed, 17 Jun 2015 09:10:35 -0700 (PDT)
X-Google-Sender-Auth: zqm57vl4FfGBKclyqDfqUsvLHaM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271861>

I do the following:

$ git push origin :topic

If I stop halfway through typing 'topic' and hit TAB, auto-completion
does not work if I do not have a local branch by that name (sometimes
I delete my local branch first, then I push to delete it remotely). I
thought that git completion code was supposed to use ls-remote to auto
complete refs used in push operations. Is this supposed to work?

I'm using Git 2.4.3. Tested on both MSYS2 in Windows and Linux Mint.
Same behavior in both. I am using the latest git completion code from
the master branch in the git repo.
