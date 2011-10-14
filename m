From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: defined behaviour for multiple urls for a remote
Date: Fri, 14 Oct 2011 12:37:51 +0530
Message-ID: <CAMK1S_jZJuqC6_-eVT7LJFh+DEphbsypS6f4nRb6Qc4-xBa_wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 14 09:07:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REbs3-0007QX-LK
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 09:07:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858Ab1JNHHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 03:07:53 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:52104 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754196Ab1JNHHw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Oct 2011 03:07:52 -0400
Received: by qadb15 with SMTP id b15so635598qad.19
        for <git@vger.kernel.org>; Fri, 14 Oct 2011 00:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=99aeG6WqGiHuSfdgVn0LUAB894TuQwVfef9kysdXhkg=;
        b=sYQ3bLp8gfbQ9Z1Su4FpjnylKKxSPuKtPQJL+srHFiV4LVfImcv1FkOkUJ46t1Jh6/
         2HI32nVelTs19rQeT012SmPNIdgTi3p28PvbTWsybwlYRCjzNdOiWaMSoyqLMdUJxzJC
         Eop/O5XCmvY+9h9OhH27vRMsN7YtCOQvpD3/0=
Received: by 10.224.31.8 with SMTP id w8mr856175qac.43.1318576071839; Fri, 14
 Oct 2011 00:07:51 -0700 (PDT)
Received: by 10.224.20.67 with HTTP; Fri, 14 Oct 2011 00:07:51 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183544>

Hi,

What's the defined behaviour if I do this:

[remote "both"]
	url = https://code.google.com/p/gitolite/
        url = git@github.com:sitaramc/gitolite.git

I know what I'm seeing (a fetch only goes to the first URL, and does a
HEAD->FETCH_HEAD because I didn't provide a refspec line, while a push
seems to push all to both), but I was curious what the official
position is, because I couldn't find it in the docs.

-- 
Sitaram
