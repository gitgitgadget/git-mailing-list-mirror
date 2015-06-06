From: =?UTF-8?B?YsOkcg==?= <crashcookie@gmail.com>
Subject: Fwd: [PATCH 3/3] stash: require a clean index to apply
Date: Sat, 6 Jun 2015 00:19:11 -0300
Message-ID: <CADQvvWUzgeusLAFT7wa1raB9f0r2F3QpDBb8fuJrkrDhN8dHtQ@mail.gmail.com>
References: <CADQvvWXMGX1aBakx2hcd+G46HxoXKUCY31hyTbYLKOcoH_X4VA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 06 05:29:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z14nU-0005Sb-UI
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 05:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbbFFDTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 23:19:32 -0400
Received: from mail-ob0-f170.google.com ([209.85.214.170]:36659 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbFFDTc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 23:19:32 -0400
Received: by obbqz1 with SMTP id qz1so48976275obb.3
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 20:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=N4hXiAQ3SjrE4xx7bzuQ4ftOsdc4pN+90w4GFkUEgc0=;
        b=Zw8mdWHnDcB+zjUMFhONZeqTCjQnAvF+wVLZXiS6yY6x1cfZEzz3uggwKYktV5CIeM
         RT71NvH0bpls0j54BPCm/f+P1dQzl2Rws5Qj7Q+t75QuKcrUWBiy6BO3DHsdfUC4novq
         NZ0Q7p8aXPrREbRw4gc0v4bFfjRQ2AHLzVMmlyPGNHI6ZcIq6B5g5LUGmG+L+ombAmFr
         52fEcNpRZsmT/R2EIqj/PRJpBm0ayr1zjKTCmE8DgSoReZ0WN8tPLHKXr2goREwU+rgQ
         o1yGRVuw3eXvtsccE2MarDo9UHCtdaPkTfTDO2I56c0XG8cSUDEbxyzClA2ftuKiAryE
         L9dQ==
X-Received: by 10.202.89.131 with SMTP id n125mr5263258oib.91.1433560771552;
 Fri, 05 Jun 2015 20:19:31 -0700 (PDT)
Received: by 10.60.157.202 with HTTP; Fri, 5 Jun 2015 20:19:11 -0700 (PDT)
In-Reply-To: <CADQvvWXMGX1aBakx2hcd+G46HxoXKUCY31hyTbYLKOcoH_X4VA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270900>

Hi folks,

I'm not sure how to respond to a particular mail [1] while keeping
this new one in the same thread, being that I just subscribed to the
list and I can't find a Message-ID in [1][2] either, so please forgive
me.

I bumped to 2.4.2 and I'm experiencing the very same issue Jonathan
Kamens was having due to [3].

Despite the workflow used, It is somewhat strange (and weird at the
same time) that doing `git stash --keep-index && git stash pop` while
having something in the index, fails with a "Cannot apply stash: Your
index contains uncommitted changes." error.

Thank you.


[1] http://article.gmane.org/gmane.comp.version-control.git/270809
[2] https://www.mail-archive.com/git%40vger.kernel.org/msg70796.html
[3] https://github.com/git/git/commit/ed178ef13a26136d86ff4e33bb7b1afb5033f908

-- 
Ber Clausen



-- 
Ber Clausen
