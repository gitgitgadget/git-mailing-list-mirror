From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: #178 parsing of pretty=format:"%an %ad" causes fatal: bad
 revision '%ad'
Date: Fri, 2 May 2014 14:12:59 +0200
Message-ID: <CABPQNSa6PaTZ3coX2eU-r7BFH3JR2V6XHv4HbXxsYyxv0qA71Q@mail.gmail.com>
References: <BLU0-SMTP1116609FAC7E0C76123F929F430@phx.gbl>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Dave Bradley <dbradley2@bell.net>
X-From: git-owner@vger.kernel.org Fri May 02 14:13:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgCLY-0000bA-0J
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 14:13:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbaEBMNk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 May 2014 08:13:40 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:51474 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751983AbaEBMNj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 08:13:39 -0400
Received: by mail-ig0-f174.google.com with SMTP id h18so1766968igc.7
        for <git@vger.kernel.org>; Fri, 02 May 2014 05:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=00NJuwEXMtc9krSVk3KFoF7YpWVq/2oenLcMi2P/Cuk=;
        b=cn5hP9WFkn4vBxXTomheMVYzV8BrmNvdGZxPwEHXLhI/rWR7CP+7qCX2LnmBk9UrPE
         7SPJI4mWrEvyuIN0yfplC7IIxm284W7LHDQlwup/XL2/w/Koao7xknNc7lFeh6vGTHer
         cYpW7QSupWKQvds0glkYQNkFN6nWmqurFS9dSr67DJ5izlXsRIMNyC650D2yar+ByOuI
         Y1rmR+qtcYIuV8KAoce42ts0jhbhGsTUGMBgXUA/bWEHMvGHyXo+BCqjreVf8296AKN7
         G1/uGBCknD2/vx6zEvvI8hdb3KZMH2c38QykL1kGeW67JTMOzFxLTg4xF1hh6yPh2Yvx
         JFiA==
X-Received: by 10.50.85.18 with SMTP id d18mr3444920igz.42.1399032819246; Fri,
 02 May 2014 05:13:39 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Fri, 2 May 2014 05:12:59 -0700 (PDT)
In-Reply-To: <BLU0-SMTP1116609FAC7E0C76123F929F430@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247933>

On Fri, May 2, 2014 at 1:50 PM, Dave Bradley <dbradley2@bell.net> wrote=
:
> Hi,
>
> I=E2=80=99m very new to =E2=80=98git=E2=80=99 github. I reported the =
#178 issue in github and the
> issue has been closed, I believe this means no further discussion.

When you say "the #178 issue in github", you really mean "issue #178
for Git for Windows on GitHub", available at
https://github.com/msysgit/git/issues/178 for those interested.

That issue tracker is for the Windows port of Git for Windows. It's
intended to track breakages in Git for Windows compared to Git on, say
Linux. It's not a general issue tracker for problems with Git. Still,
it seems a lot of people think "I downloaded Git for Windows, and
here's something that didn't work the way I expected it to, I'll file
a bug". Those kinds of bug-reports usually gets closed quickly, as
it's outside the scope of Git for Windows to decide how Git should
behave - we try to make it behave consistently between Windows and
Unixy-platforms.

This is indeed the right forum to address your issue. So thank you for
moving the discussion here.
