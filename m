From: Jagan Teki <jagannadh.teki@gmail.com>
Subject: Re: Apply commits from one branch to another branch (tree structure
 is different)
Date: Fri, 14 Mar 2014 23:41:49 +0530
Message-ID: <CAD6G_RSPNob11jzqyXiBR4zRuu3T00+qQ7rhNx_E4q+2-3h6iw@mail.gmail.com>
References: <CAD6G_RTZaaYBP0MrmRYhce2v+A+WwvY=97Do3LoWW-SYzkHM2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Brandon McCaig <bamccaig@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 19:12:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOWaJ-00021h-Fc
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 19:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685AbaCNSLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 14:11:50 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:64170 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512AbaCNSLu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 14:11:50 -0400
Received: by mail-yk0-f170.google.com with SMTP id 9so7613804ykp.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=kJz8BOnUiEuReP2tiuD2+d2b+tZMUcObrbhGG+PSk9U=;
        b=y3CkGRoTtmrCFI0XeaeABdiolI2MGZgIuotwPvzfbJ6FNZgvOVU2nekQ0zqg9/53tA
         AeSoHFgWcsHxBnXedLdf9e8nnX00Y6tH3wPdDJ5jf1a4LcorPajaKABWs7BrRk02nKb3
         Cjk0yQKwYaSjYffMlmHIla3cF+UYQB982kmxfbr+LW4B25W2d8Jn6jQ4xaJiYfuqmNQh
         G9ocNkIyDpR3M1L1Kz9PiHG7io67bbbMnSEbgN4JalYkfI22Bg8IFKZceYn/i/uyJA5i
         nkfemqCwUjQ7PVZ0ayui7mmC3+j5YY/8f+xnn8Np/gbJRbwJwol65+vUfYXAnpCETj4a
         MueQ==
X-Received: by 10.236.66.143 with SMTP id h15mr12617871yhd.36.1394820709732;
 Fri, 14 Mar 2014 11:11:49 -0700 (PDT)
Received: by 10.170.34.215 with HTTP; Fri, 14 Mar 2014 11:11:49 -0700 (PDT)
In-Reply-To: <CAD6G_RTZaaYBP0MrmRYhce2v+A+WwvY=97Do3LoWW-SYzkHM2g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244100>

Don't know what happen, I'm unable to join #git channel
[23:40] <Jagan> hi
[23:40] == Cannot send to channel: #git

Can any one help!

On Fri, Mar 14, 2014 at 11:09 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> Hi,
>
> I have two branch in one repo that I need to maintain for 2 different
> deliveries.
> Say branch1 and branch2 in test.git repo.
>
> test.git
> - branch1
>      foo_v1/text.txt
>      foo_v2/text.txt
> - branch2
>      foo/text.txt
>
> branch1 is developers branch all source looks version'ed manner and
> branch2 is superset for branch1, example foo_v1 and foo_v2 are the directories
> in branch1 where developer will update the latest one here foo_v2 and branch2
> foo is same as the latest one of branch1 for an instance.
>
> Suppose developer send 10 patches on branch1 where are changes in terms
> of <dir>_<version>/ then I need to apply on my local repo branch1, till now
> is fine then I need to apply same 10 patches on to my branch2 where source
> tree <dir> which is quite question here how can I do.
>
> Request for any help! let me know for any questions.
>
>
> thanks!
> --
> Jagan.



-- 
Jagan.
