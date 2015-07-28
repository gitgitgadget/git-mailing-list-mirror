From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] git-add-interactive: edit current file in editor
Date: Mon, 27 Jul 2015 22:12:58 -0700
Message-ID: <CA+P7+xptro_1nePQbQtGtRc-a9=swXvZiERDCiQc=NReUsV53Q@mail.gmail.com>
References: <1438040482-4599-1-git-send-email-siadat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Sina Siadat <siadat@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 07:13:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJxCc-00036i-SO
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 07:13:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752299AbbG1FNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 01:13:18 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38059 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbbG1FNS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 01:13:18 -0400
Received: by iggf3 with SMTP id f3so106327199igg.1
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 22:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RM3vHkyvkZFYTf9iv+WUicSen1rOxH6wOXmtbLHHK8M=;
        b=se3y1kpS5n/rpwwatoQoK0rUfC8tNQV/rgBRAxKFD3i3jDdrY8gWoAXEN5xYU2hGU6
         yOBzIE+nH4U9D9f3u2v2BkVuLUC0rxO/l6tccB8s7axreLfAaKTg+E8WuCCCYKrCR+FW
         0UXKpQ/LC/kWQcREnToDDmT5i3Fl32A4iaghC+f1ERZBDHxDgLkZLn3Ry01IXNWTcJKq
         se1QCJl1oIGf3EDfx5yxpSg7sh5DUITAnk+pqKOpevsqdkk1/MbrtNcTOv7ujppEMIDl
         yjmsciqxFYTyE+F+bfP3cDZxV/Rei7Dt24b6ABs1NB1toHbfOXcn0m3tcyGeDnCzOhV6
         MrVQ==
X-Received: by 10.107.136.15 with SMTP id k15mr34163860iod.67.1438060397461;
 Mon, 27 Jul 2015 22:13:17 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Mon, 27 Jul 2015 22:12:58 -0700 (PDT)
In-Reply-To: <1438040482-4599-1-git-send-email-siadat@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274725>

On Mon, Jul 27, 2015 at 4:41 PM, Sina Siadat <siadat@gmail.com> wrote:
> Adds a new option 'o' to the 'add -p' command that lets you open and edit the
> current file.
>
> The existing 'e' mode is used to manually edit the hunk.  The new 'o' option
> allows you to open and edit the file without having to quit the loop. The hunks
> are updated when the editing is done, and the user will be able to review the
> updated hunks.  Without this option you would have to quit the loop, edit the
> file, and execute 'add -p filename' again.
>
> I would appreciate it if you could let me know what you think about this
> option. I will write more tests if there is any interest at all.
>
> Thank you. :)
>

Absolutely want and would use this change every day. My standard model
of commit flow is:

hack commit hack commit hack commit

rest head

add -i ; commit

add -i ; commit

and sometimes I end up with code that I need to actually change, not
just edit diff hunks for, but change in the final file. This would
make my flow way easier, especially as I could manage hunks while
editing files.


Regards,
Jake
