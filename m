From: Gabriel <gabriel.so@gmail.com>
Subject: git-completion.bash error
Date: Sun, 27 Oct 2013 18:59:32 -0200
Message-ID: <CAGvuA0iGrF5jrUSCjT7-SR85i2OhBwQHfjj4+krAFfz5wnxx8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 22:00:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaXRU-0007D7-1E
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 22:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab3J0VAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 17:00:04 -0400
Received: from mail-ve0-f169.google.com ([209.85.128.169]:52227 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab3J0VAD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 17:00:03 -0400
Received: by mail-ve0-f169.google.com with SMTP id c14so2964582vea.14
        for <git@vger.kernel.org>; Sun, 27 Oct 2013 14:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=YkhgzJjCwAzmE6olmDvrvFPRW+3EKSb5fVBTlxZAoxU=;
        b=Ovs0pbRJFXA7WIErc17qT2gCba9zMlOc3gnXmX+GTXVwNYxV7lES4m0VTV/bZGoguY
         xfcoKeyVJUl/gIc5DA/mssZ82TQQ72AYJv28mPPH1Y6lJE5oDC/0j9XZ7MloZ/EP0JBu
         Y71xTzL2eA2r6bP5ckmMrmzEoGCbsoe66n+4OIR/edzVqZmUMLQYMHuXxhytQW8syIY5
         YQ66ojZUfebQim2V9XSRdSjU57rg64gSv0IGPua67gBH6a8Dsvt6218jqZNRNMMZQCK/
         DT8OCrv+oli4RVtLA96o+rTZCb2GTPiOgrb8vwI639AYeyPCaCAUy/24a8znJILqb2jE
         LCaw==
X-Received: by 10.221.54.129 with SMTP id vu1mr332081vcb.20.1382907602455;
 Sun, 27 Oct 2013 14:00:02 -0700 (PDT)
Received: by 10.58.118.11 with HTTP; Sun, 27 Oct 2013 13:59:32 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236809>

Hi.

First of all, thank you and congratulations for the awesome work :)

I've just made a clean install of OS X Mavericks and installed Git via
Homebrew, which obviously includes the contrib files.

I sourced the git-completion.bash into my profile and I get stuck on a
error every time I try to use the autocomplete. The error outputted
is:

egrep: ^ [a-zA-Z0-9]: No such file or directory

I believe this is related to this line (this commands outputs the same
error when entered directly):
https://github.com/git/git/blob/master/contrib/completion/git-completion.bash#L614

I don't know if this issue is directly related to OS X Mavericks or
anything else.

Thanks.
