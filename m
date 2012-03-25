From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [GIT GUI PATCH 0/2] teach git gui to open the configured editor
Date: Sun, 25 Mar 2012 21:33:02 +0200
Message-ID: <CAKPyHN3xtd2S4n3En18xAwgwDYGHOfNyFnXMkVc4V-kxq+myEA@mail.gmail.com>
References: <cover.1332523097.git.hvoigt@hvoigt.net>
	<CAKPyHN1SWLMKtWOPJ7NwcwuE2Kpwb84yz443P7R=vE4jSPFEOw@mail.gmail.com>
	<20120325170200.GC38866@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Mar 25 21:33:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SBtBf-0003U3-Mp
	for gcvg-git-2@plane.gmane.org; Sun, 25 Mar 2012 21:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756848Ab2CYTdF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Mar 2012 15:33:05 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:54329 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756844Ab2CYTdE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2012 15:33:04 -0400
Received: by vbbff1 with SMTP id ff1so2255003vbb.19
        for <git@vger.kernel.org>; Sun, 25 Mar 2012 12:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BiGIZz5JWBiDilkXrBPWpMCEkbGD2UYMHg4VhyOueQo=;
        b=CRAAW8wqDeTczxkTgp99fx4SGwXsINfKe85kp+JNLXDfkAo1cskMTg5RrTMp6JIbt2
         YLFTz9tbhKm3hJxU6uGLR0eghxKB+MzV6VM5HmqivwRPPAufWScOUZXccb9RKnho/kX3
         9RnvX+fPscLZ6vVu+koJABgvFi13DGqzZhxO9n7q16eNnEhw3VGYi0UvyWivTJBh2dWj
         g2XjgClTUZucN9cxWnleqpXAOc0ROCtouDEU+l04zmxGuzANn/8/I9yLfp+tGoUWSLMS
         ARQXoMvDLepoqvFUn7m+d3yT7JIYEbulMWZO7mV8EOFr0+tPZCV0H1y4QYw8leEhMwz/
         yBoA==
Received: by 10.52.37.228 with SMTP id b4mr3062096vdk.131.1332703982830; Sun,
 25 Mar 2012 12:33:02 -0700 (PDT)
Received: by 10.52.186.8 with HTTP; Sun, 25 Mar 2012 12:33:02 -0700 (PDT)
In-Reply-To: <20120325170200.GC38866@book.hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193881>

On Sun, Mar 25, 2012 at 19:02, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> Hi,
>
> On Fri, Mar 23, 2012 at 07:43:32PM +0100, Bert Wesarg wrote:
>> On Fri, Mar 23, 2012 at 18:30, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>> > This patch series adds a new right click menuitem which allows the user
>> > to open the configured editor with the currently viewed file. For some
>> > popular editors it is also able to move the cursor close to the watched
>> > line.
>>
>> I once mentioned this in a patch I send ages ago:
>>
>> <1289770869-11665-1-git-send-email-bert.wesarg@googlemail.com>
>>
>> Look for the '[1]' reference.
>>
>> I have done, what was discussed in this thread, but never send
>> something to the list (maybe a private mail to Pat?), but you can have
>> a look at my git-gui repo at [1]. The patch which implements this is
>> bw/master~5 (a648f3a06 'git-gui: open file with GIT_EDITOR').
>
> Interesting, I will give it a try once I find some time. So do you think
> it is now ready for inclusion? I saw that you actually did a lot more
> than me.

You're right, in this commit is more than it should, I split it up.
Thanks. I had the action also only on mouse button 2 (ie. middle one)
but I added it now to the menus too. You have missed yourself a menu,
that what is used for a merge conflict. And I added a menu to the file
lists too, so they have a 'Open in Editor' entry now too.

Bert

>
> Cheers Heiko
>
