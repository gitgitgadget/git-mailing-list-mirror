From: Henning Sprang <henning.sprang@gmail.com>
Subject: git push rejected due being behind after git svn dcommit without any
 changes local/remote
Date: Wed, 21 May 2014 17:13:18 +0100
Message-ID: <CAB10+LtnAiCCiMdrULvioxc-UBQufKD4AzOphvE8bAdq7en04g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 21 18:13:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wn99D-0002Np-HT
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 18:13:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751980AbaEUQNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 12:13:40 -0400
Received: from mail-qg0-f42.google.com ([209.85.192.42]:41059 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724AbaEUQNj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 12:13:39 -0400
Received: by mail-qg0-f42.google.com with SMTP id q107so3656769qgd.1
        for <git@vger.kernel.org>; Wed, 21 May 2014 09:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=JwzNmYanZ5XZX9fazAccwW5ICc5w8xiYUFsUpdYXPLE=;
        b=c0+jkPJzbyj7DI/TM4ruOMf4xJtHPKg3ZBjIFc8LypBccd4Xa6nXYCZuPtkx2x33wC
         7WlCzZx8+jDXohWlKknFLfWS56ymdZfY35d2PqDRwPab998ppaYAZEhOXqwGkRB1fFJ8
         RZ/ZkwjYW5p44kUD6VicivLiY6e3NgtaxqXfnCviG7IviyU0ERHpP3/aChX8w1ga5ufB
         HOh8IwBDsgD5Qk8zPk8oVuWE+DDYukoLNschtDaBN5b18nSCRxQHGFXZwlBbuK1CP2uv
         uuzbdomIexIqU8GQlxNqtAtAcu2RTF0NEwwacJkNz4sAwKPgnOjwp0YPkzDA027bjfGM
         YaDQ==
X-Received: by 10.140.107.137 with SMTP id h9mr18955526qgf.30.1400688818767;
 Wed, 21 May 2014 09:13:38 -0700 (PDT)
Received: by 10.140.103.161 with HTTP; Wed, 21 May 2014 09:13:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249803>

Hi,

I have a client that still uses svn, but I decided to version my work
on the project with git locally - using git svn to sync the svn and my
local git repo.

To have a backup , I additionally push my changes to a remote git repository.

Now, many(maybe every) times when doing the git push to the remote git
repository, after having done an svn dcommit to sync to the remote
svn, the push gets rejected:

"... Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart...."

You'd say, can happen, when some developers work against the remote
git repo, others with svn. But I'm the only developer on the project,
and no one ever commits to the remote svn nor the remote git repo. So,
I'm clueless.

How can I find out what happens and how to prevent that?

Thanks in advance,
Henning

-- 
Henning Sprang
http://www.sprang.de
