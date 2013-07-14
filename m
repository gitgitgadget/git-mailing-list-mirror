From: Richard Hartmann <richih.mailinglist@gmail.com>
Subject: Re: [PATCH 1/6] templates: Use heredoc in pre-commit hook
Date: Sun, 14 Jul 2013 22:12:09 +0200
Message-ID: <CAD77+gSE5GnTcrpoWO0bb2UysDE9t51EWJo3shdeffnaLxASfw@mail.gmail.com>
References: <CAD77+gSX1ggBWHhGwxRUBPGQ6ONJd76SO-3tU05QT47iKCv9hg@mail.gmail.com>
 <1373818879-1698-1-git-send-email-richih.mailinglist@gmail.com>
 <1373818879-1698-2-git-send-email-richih.mailinglist@gmail.com> <7v1u71gd7r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 14 22:12:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UySf4-0001Vd-Vm
	for gcvg-git-2@plane.gmane.org; Sun, 14 Jul 2013 22:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753177Ab3GNUMc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Jul 2013 16:12:32 -0400
Received: from mail-we0-f178.google.com ([74.125.82.178]:47457 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155Ab3GNUMb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jul 2013 16:12:31 -0400
Received: by mail-we0-f178.google.com with SMTP id u53so9626220wes.9
        for <git@vger.kernel.org>; Sun, 14 Jul 2013 13:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GkGG07L1EQ6gsW7q7zL9gwVHi9wGDbI9AEkNAfYQfFo=;
        b=MCU3d0+h+9t4XhNJCkSr8DVRT3p+d5/VqYch72YCH25/1Y2cnu5xC8k4HkXI7FAGrZ
         Z3jdPfPjVj+pquwpvkDGpLcE9qxpz+yAhIcwJOPtBgGLq84MeDF5L3tTG1JAB4zxNU+H
         8owCbsP/lsiBkjVQT20PQu5hpEa26s7V6l/7ag6+T6t1xb5ySnDRetbQESu/0LxpnLQj
         BbvL9nSfVii8Eno4Cj0uXQHhk40vizz2zq27C4E3qRQ2Yad8jU3acU/LBHRTmf9ZKW9U
         nfGAyj7BnLQSrsUGmM4/ZxEA0L4ezZAKmFz2AFP+CuaXd3NWCRJgmS65o6pfenbKFX4d
         P3Hw==
X-Received: by 10.194.110.39 with SMTP id hx7mr29400498wjb.4.1373832749915;
 Sun, 14 Jul 2013 13:12:29 -0700 (PDT)
Received: by 10.194.17.9 with HTTP; Sun, 14 Jul 2013 13:12:09 -0700 (PDT)
In-Reply-To: <7v1u71gd7r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230386>

On Sun, Jul 14, 2013 at 9:20 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Shells on modern distros and platforms have "echo" built-in, so this
> patch replaces series of writes internal to the shell with a fork to
> cat with heredoc (which often is implemented with a temporary file).

True; fwiw, I replaced my one single echo with heredoc as you
suggested I do that. I don't mind undoing that, or I can drop it from
this series altogether.

Guidance would be appreciated. :)


Richard
