From: Luke Diamand <luke@diamand.org>
Subject: Is there a way to find out which commit "git rebase --skip" skipped?
Date: Thu, 16 Aug 2012 07:59:39 +0100
Message-ID: <CAE5ih78tYrX0F3AZ3vrE2p=_h24njhU_rTGEqbBHfJGkGuHmpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pete Wyckoff <pw@padd.com>
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 09:00:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1u4A-0000pf-Ei
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 09:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755139Ab2HPHAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 03:00:05 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:45852 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378Ab2HPG7l (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 02:59:41 -0400
Received: by wgbdr13 with SMTP id dr13so2117322wgb.1
        for <git@vger.kernel.org>; Wed, 15 Aug 2012 23:59:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :x-gm-message-state;
        bh=9rrlaRbkYnOBZrZA3whiNq6nXCmEcF9dGoY1h5CR7Is=;
        b=QR4rK9HGI94oRw2dz88EW5dw2K3fzlKqzkuV0ERwE7wzoPy/XtGMGjVNNIRyCTm7xM
         ym6IVqUyrnzhCFGejEH7oqmLF3Z3NsftNu0kQywiN4DRQuuLtUiOnOB3ZUd7Mgo6rFDa
         UAudKpR0kdB48UgblK2KACqrO3HSZ3ZltQPiig4x+u8ydw/7Zq9FCs4IonTvzabSUFew
         gxvZlunxfvxqqBz9MJF6hw4VzGSzAXu0NjKM7FponFcvxeE5RVZ5pk7PqEeu36oVqq7B
         huGmGKC+vLlDWKgS2yFKxkSnlqrFsIbwlUP3q3BCQvOc7ivuw2wc0ugGDguYNC8sLrbx
         i3YQ==
Received: by 10.180.84.169 with SMTP id a9mr571677wiz.8.1345100379555; Wed, 15
 Aug 2012 23:59:39 -0700 (PDT)
Received: by 10.216.63.135 with HTTP; Wed, 15 Aug 2012 23:59:39 -0700 (PDT)
X-Gm-Message-State: ALoCoQlf6D2fqEXYmkTJ7InPErAVwOpyt061z3T1TFcv/NsOg4khjfZUS5t2WvnUKhfEDzSJPlDM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I do "git rebase --skip", is there a way to find out the commit SHA
that was skipped (other than just parsing the output of the command) ?

I'd like to modify git-p4 so that it can automatically skip past
conflicting changes, but I'd like it to keep a log of which commits
were skipped.

Thanks,
Luke
