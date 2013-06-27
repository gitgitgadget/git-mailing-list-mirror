From: Hyunho Cho <mug896@gmail.com>
Subject: =?windows-1252?Q?=93git_remote_status=94_incorrect_result?=
Date: Thu, 27 Jun 2013 14:25:55 +0900
Message-ID: <CAMMw471Duu075CoC=jw3ZKpcEq0Lonv1NkzyW41v8dR39ZN=Zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 27 07:26:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us4iW-0000CT-LO
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 07:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384Ab3F0FZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 01:25:57 -0400
Received: from mail-ie0-f195.google.com ([209.85.223.195]:64267 "EHLO
	mail-ie0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab3F0FZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 01:25:56 -0400
Received: by mail-ie0-f195.google.com with SMTP id c10so288893ieb.2
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 22:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=9sZv54SE6PcVnV5rgfmCjPTtN3EjrSbv5tOmQ78j1Kc=;
        b=TY/WDha6GM4WsbZrx5xbZw4t8syto2r6JXicvYcnbFZS6VpGz/n6i5UxfWt/hnkjI8
         RawB1B3Dt6fIvBSZzjthp1AObtvNknFhtS1fexIAF/jc08e6kdUhqzKfrUlXAA9fExA+
         D1SdS9pHFO5rqrZr+Q6qLYl2hCF6tqiHtjKOTA6Cm8VO1aydvKPiY06S42O9IzmQmqOi
         Ropj6kyXw8cs9ByMWEgOE8BnSSK6jdnn5XqgpqKiTWQRLd6W6kyGAEn7ciqftkcNp1Xe
         eUduIX3Yr9rfWXWLNQRvSvOOojrQNWoz5qwuocLu4dwEyIC6MeiFlTGWXNAWT0659uhU
         IuaQ==
X-Received: by 10.50.27.37 with SMTP id q5mr13853876igg.52.1372310756026; Wed,
 26 Jun 2013 22:25:56 -0700 (PDT)
Received: by 10.64.57.199 with HTTP; Wed, 26 Jun 2013 22:25:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229087>

i have configured like this

git remote add myremote1 .......
git config --global push.default upstream
git branch --set-upstream-to=myremote1/master remote1-master

and git pull, git push in remote1-master work i expected

but "git remote status myremote1" display..

Local ref configured for 'git push':
   master pushes to master (local out of date)

section always display master to master. and status incorrectly

it would be correct:

Local ref configured for 'git push':
   remote1-master pushes to master (up to date)

if i add another remote "myremote2" there is also exist "master" branch

"Local ref configured for 'git push':" section have to display

according to local branch and upstream setting

and remote status correctly i think
