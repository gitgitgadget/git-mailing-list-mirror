From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 2/5] command-list.txt: add a [common] block
Date: Fri, 15 May 2015 17:31:45 -0400
Message-ID: <CAPig+cSJJroxRF2He4ZvmgijZVw9ULOnUCEWyxGry=--L851YA@mail.gmail.com>
References: <1431714904-16599-1-git-send-email-sebastien.guimmara@gmail.com>
	<1431714904-16599-3-git-send-email-sebastien.guimmara@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 23:31:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtNCw-0000vN-VQ
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 23:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946186AbbEOVbq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2015 17:31:46 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36685 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946138AbbEOVbp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2015 17:31:45 -0400
Received: by igbpi8 with SMTP id pi8so7107014igb.1
        for <git@vger.kernel.org>; Fri, 15 May 2015 14:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=nw5O8X3Geu9LXY/RaYgzz/AJpho3itk8+5n4040gKP0=;
        b=Kkpy1HqiFFgvXq0791mSp2ZHcUeuLW3RSkPlt1o0gNy45ynVZ4Q0QBc1Ze+j85uPRh
         PfZ28Kys1BoqR9+E0AefpcmCTrVpYxh4BaebV//YD4/mqA1W15+ZgRCIeXQ5TYwnyksz
         7nBnF9jR9SB+wAbyvzHLuvUahEx8X6HvJR6gptTLiHNsTPNcVH8bXDsWgVq3gbKtr248
         YVaTwk4cboBoJ/1r70LZ/620W/hwq+45RS9iRPq8mUkLCOHCp/Yn/8Aw3uJPk6wf1sdF
         wL+p0Jc33F38oE/Bm7AQGK3wvZBOocDha6zu9T2eRQjgBJi1GYonce0hvvQ+Ml0KG9Tn
         bUkA==
X-Received: by 10.50.61.200 with SMTP id s8mr857751igr.7.1431725505145; Fri,
 15 May 2015 14:31:45 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 15 May 2015 14:31:45 -0700 (PDT)
In-Reply-To: <1431714904-16599-3-git-send-email-sebastien.guimmara@gmail.com>
X-Google-Sender-Auth: iC-o4JuYw7PcyEIn1NbyT5wLYmY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269186>

On Fri, May 15, 2015 at 2:35 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> Add a [common] block at the beginning of command-list.txt:

Without benefit of the explanation in the cover letter, the reason for
this change is a bit mysterious. Even a single sentence preceding this
one could help clarify. Perhaps the above could be rewritten something
like this:

    The ultimate goal is for "git help" to display common commands in
    groups rather than alphabetically. As a first step, define the
    groups in a new [common] block, and then assign a group to each
    common command.

>     [common]
>     init         start a working area (see also: git help tutorial)
>     worktree     work on the current change (see also:[...]
>     info         examine the history and state (see also: git [...]
>     history      grow, mark and tweak your history
>     remote       collaborate (see also: git help workflows)
>
> storing information about common commands group, then map each common
> command to a group:
>
>     git-add          mainporcelain        common worktree

With the above rewritten explanation, the rest of the commit message
(the above examples) becomes pretty much unnecessary and merely
repeats what the patch itself already says.

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by:  Emma Jane Hogbin Westby <emma.westby@gmail.com>
> Signed-off-by: S=C3=A9bastien Guimmara <sebastien.guimmara@gmail.com>
