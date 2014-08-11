From: Jagan Teki <jagannadh.teki@gmail.com>
Subject: How to give permission to another user on my git remote
Date: Mon, 11 Aug 2014 17:11:58 +0530
Message-ID: <CAD6G_RTP5AQC8wjz17ghGBGbJ95t=kn5rRAgSaGaM-QCxi2mtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 11 13:42:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGnzL-0000nT-Qy
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 13:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbaHKLmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2014 07:42:00 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:41793 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbaHKLl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2014 07:41:59 -0400
Received: by mail-yk0-f173.google.com with SMTP id 131so5881714ykp.32
        for <git@vger.kernel.org>; Mon, 11 Aug 2014 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=JFVnIJMXUqYEdUFKQLne+N9WY3A7pmRtrtUWLcvg01Q=;
        b=DFfCfB3kMsogES7NLaEOk4mKD+CpvAYzhwqUL/Rq009qH8UpqSkLjYEFCduqyd1bq9
         wfPCBNFBdUPjUbS1eL/T544p8J56YOMHvVbwFy5rJyrVigZ1Tfs4UiZIyznGHTCXURM7
         fAq0AdGzzqVTBu56ruv1kPolJ6ozRK1icYWiuQPZJgn9C00/anC11SLMCMfRU6+cACUM
         Jf4hbWIjrl4mSIbNXO0A0yxvc2XWIpXOlZqwE9zsj5NTksQpWn0FPuJGhHHId9a45mXU
         ifOSxzh3DLmeK4FAP569lWfwOwf4GIndK6zBiriYDKmTX6JLJE5r/GDHdMFD8VRX8MnS
         6c6Q==
X-Received: by 10.236.35.198 with SMTP id u46mr42959908yha.54.1407757318359;
 Mon, 11 Aug 2014 04:41:58 -0700 (PDT)
Received: by 10.170.45.199 with HTTP; Mon, 11 Aug 2014 04:41:58 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255122>

Hi,

I have created one repository (but I'm not a root user on the server) like
$ git init --bare

And I do push my changes locally to remote repo where I created.
My friend also working the same repo, and he needs to push the changes
on the same.

I tried by adding below line on the remote config file
[config]
        sharedRepository = true

Any help, how to do that.

-- 
Jagan.
