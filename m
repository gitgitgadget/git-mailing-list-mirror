From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: git interactive rebase bug?
Date: Mon, 5 Oct 2015 15:40:56 -0700
Message-ID: <CA+P7+xomv59bevbAMV=NYwo+UtY29OqVog3nDFUG8Jp1YbLYpw@mail.gmail.com>
References: <CA+P7+xqMFFtVPnZ7Pw9B9oYXHe5N=Ectyd-M+_aGb2NKjRvLAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 06 00:41:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjERc-0008A3-NP
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 00:41:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbbJEWlQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 18:41:16 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33235 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbbJEWlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 18:41:16 -0400
Received: by igbkq10 with SMTP id kq10so74388502igb.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 15:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=ca2bNr5YM1tuUqBCCAEI3RbIXbwhdRdIkMDIhwLzX/A=;
        b=J5OqFBk+TlHydh650RcVegstZYk+gIVkiloHDoJcgn8Avv12dIlt04r/bLBr6kRZhy
         dTp2UP/vWdaBQSI6E96cikzdvvqUDzkbsd8pAVG8kdiWo9Ijdydv52oyukFvxCtdeR5s
         cTo0MUk1FXZIu2rn1E/O25oa5O/Hj2b1sOatI5aN6jURL0NQiDy3HpC1XvDPM9SMybku
         mNh5UCLqnGE8iOS/CgVh4c7PSyNu9exGS2xg5BUce7G8BpG/meDbNNv44gylZejEOXj7
         pVK1iasix3JxgQdvxKe3nslyyyQEo1HAQQucQXMttYtx5wLTn6ABJ6GGjBDCAhB6dk7y
         8Ymg==
X-Received: by 10.50.117.38 with SMTP id kb6mr8231324igb.92.1444084875558;
 Mon, 05 Oct 2015 15:41:15 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Mon, 5 Oct 2015 15:40:56 -0700 (PDT)
In-Reply-To: <CA+P7+xqMFFtVPnZ7Pw9B9oYXHe5N=Ectyd-M+_aGb2NKjRvLAg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279103>

On Mon, Oct 5, 2015 at 3:39 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> Hey,
>
> I've been experiencing a very annoying bug when performing interactive
> rebases. The rebase process will stall after I close the editor, and I
> have to kill the process and then restart the rebase using "git rebase
> --continue"
>
> I am not sure how to debug this further. Suggestions are welcome. It
> is an intermittent issue, so it doesn't always happen but it seems to
> happen fairly often (at least every other attempt).
>
> It appears to only occur after an interactive rebase, with an editor is closed.
>
> Regards,
> Jake

Note, I have this problem when using the latest of next branch,
haven't had it in the past when using the latest released version, so
I think it's a rather recent regression.

Regards,
Jake
