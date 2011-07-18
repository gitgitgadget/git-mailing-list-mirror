From: Patrick Doyle <wpdster@gmail.com>
Subject: What changed in merge commit?
Date: Mon, 18 Jul 2011 12:44:36 -0400
Message-ID: <CAF_dkJC-ee2Bqyi2_Fx_j8mu3tCFsV8o=xMRLjx+s2di4=HfkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 18 18:45:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiqwI-0004wi-Ry
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 18:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab1GRQo5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jul 2011 12:44:57 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:53181 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab1GRQo5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2011 12:44:57 -0400
Received: by fxd18 with SMTP id 18so6927825fxd.11
        for <git@vger.kernel.org>; Mon, 18 Jul 2011 09:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=ydG3UrZIY0EeZOFa1MYVKrurBUTTsE82SoEilb23v40=;
        b=oHVxviSMGaR/cq3gFvvQxU/YLyWIyK6IQL8zsNTfkiS231McLcpypiMR/Wzd2DkhVC
         ke94iigs4g8ITLBb4tmuqPv9FMVE/MAEhSIoIZciXOf8+MZR5+jymCZA+8mpZjG1WWUg
         FRKqGHtYdej8WCbWPjy4L/IP8WJUJYzWg8t0E=
Received: by 10.223.7.10 with SMTP id b10mr10373049fab.76.1311007496087; Mon,
 18 Jul 2011 09:44:56 -0700 (PDT)
Received: by 10.223.144.203 with HTTP; Mon, 18 Jul 2011 09:44:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177383>

Since today seems to be my day to hang out on this list, I thought I'd
ask another burning question...

How can I see what changed in a merge commit?

$ git log

just says "merge remote branch 'origin/master' into wpd" and

$ git log --name-status

says the same thing -- it doesn't list any files as having changed.

Perhaps nothing changed between the last time I merged with
origin/master and the current time.  I know that at least one change
was committed.  I suppose it's possible that two (or more) changes
were committed, undoing that one change.  (But I don't think that's
likely).

I could go back and look at the log for origin/master... and I'm sure
there's some way to say "just give me the log of changes since the
last time I merged", or more to the point now, "just give me the log
of changes since the time before the last time I merged".  It probably
has something to do with a couple of ref names, a caret, and some
dots, but I get lost in all of that syntax.

Thanks for the tips.

--wpd
