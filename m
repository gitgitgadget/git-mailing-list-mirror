From: mofaph <mofaph@gmail.com>
Subject: info: display '--' as '-'
Date: Mon, 6 Aug 2012 11:08:39 +0800
Message-ID: <CANes+HZ3EH70x6KiaPsV=SQpbjr5o+pEzj2+4Xx613GPZv0SLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 06 05:08:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyDgT-0006EH-LD
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 05:08:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755548Ab2HFDIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 23:08:40 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:32791 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755513Ab2HFDIj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 23:08:39 -0400
Received: by obbuo13 with SMTP id uo13so5181456obb.19
        for <git@vger.kernel.org>; Sun, 05 Aug 2012 20:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=DdbIz5GMtkMDZwO/d/w0ZfjfJ53fSEMEiA4OYnWILqs=;
        b=n2aZuCJmOx59O5nqTDm+nObXWWn/TEq4bKY+V8rDHLk9Y3ait6buClM9t47loIvHRk
         RLwFOdxhjCtFqn4lOjX0WcaEtl5N/xOSrgHopqnhEq2ijBYgQBuVE1bGYhJHj9ICUC+X
         DwR5lH2p181amNeDfqx+Ivb3FMhq0eehA0KTTcxjpUYPdabWCLLBUjb4X71hYUQ/7jD2
         Y8vkL7bHN1QGemYdt0vvh8k0202mYhnTVlflfH943MfPGQBG1/tJCDHj6+Qo04fxCRdv
         RZK7QXbWAaOBEOJ+7QtWIXnJs6tItkiETEOkH3w0G0jGZ/nVhLW2+bMkVjZACAxkTJbB
         Ctrw==
Received: by 10.182.51.65 with SMTP id i1mr17161475obo.45.1344222519308; Sun,
 05 Aug 2012 20:08:39 -0700 (PDT)
Received: by 10.76.96.240 with HTTP; Sun, 5 Aug 2012 20:08:39 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202955>

Hi, all.

I am using Git 1.7.11.4 now. I compile and then install it from the repo.

$ git checkout v1.7.11.4
$ make prefix=$HOME/opt/git/1.7.11.4 all doc info
$ make prefix=$HOME/opt/git/1.7.11.4 install{,-doc,-html,-info}

Recently, I found some problem when I read the git.info.

For example, you can see it in "3.7.1 Getting conflict-resolution help during a
merge":

$ git log -merge
$ gitk -merge

See, it should be type like this:

$ git log --merge
$ gitk --merge

You will see this typo almost in the whole info file.

mofaph
2012/8/6
