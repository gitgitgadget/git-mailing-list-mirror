From: Albert Netymk <albertnetymk@gmail.com>
Subject: zsh completion for `git push origin --delete`
Date: Sat, 17 Jan 2015 12:18:51 +0100
Message-ID: <CAKEGsXTpzZQSHk-8x2kYEcaayLOpsLpU0J5pPne7CBGvTtXGkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 17 12:19:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YCRPR-000506-7F
	for gcvg-git-2@plane.gmane.org; Sat, 17 Jan 2015 12:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752367AbbAQLTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2015 06:19:12 -0500
Received: from mail-ob0-f173.google.com ([209.85.214.173]:52980 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340AbbAQLTM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2015 06:19:12 -0500
Received: by mail-ob0-f173.google.com with SMTP id nt9so22910139obb.4
        for <git@vger.kernel.org>; Sat, 17 Jan 2015 03:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=klYw9DWvTlDup0mx13W1QvrkWdbsiniE+Cdg7AimAS8=;
        b=zJCXCfDisuaTWMe8DvrZNEqG4k25ZtMz0iJyA8+qtBWJpyNFvevaUasitYZQgaqHLP
         NMZ1gS9kVgjw/8kFA/mNHhIJUr0ODjfcNWvjDSUGwupy5x5roramQPkABrU88P0LqGVF
         1YU7IidTihu4PXJcLA6qAlIQFoSnabW4yh73KWWh92QfCsvwkYKDyTN3lvly2d0qwNCj
         AFR1c9o7keImlZMsBE5hRhTS2JlJpF91QngE1B7+HnKZhEajAE6aop9Z/iqZv0H8ravb
         bU3UBq5ZnkwAVedqz/jxteu3+rvxttKSHSTAhkIFbR+IbTaGBmdeeLQkxcrMFh6T1IKg
         Az0g==
X-Received: by 10.202.75.202 with SMTP id y193mr11730309oia.12.1421493551567;
 Sat, 17 Jan 2015 03:19:11 -0800 (PST)
Received: by 10.202.73.75 with HTTP; Sat, 17 Jan 2015 03:18:51 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262584>

The man for `--delete` says only refs on the remote repo are affected.
Then, the auto-completion in zsh shall not return local refs.

```
$ git branch -a
  master
* tmp
  remotes/origin/master
  remotes/origin/tmp

$ git push origin --delete <tab>
FETCH_HEAD     HEAD           master         ORIG_HEAD
origin/master  origin/tmp     tmp
```
I feel hitting <tab> shall only return `master` and `tmp`, which are
the valid input `--delete` option.

git version 2.2.2

-- 
Best Regards

Yours faithfully
Albert Netymk
