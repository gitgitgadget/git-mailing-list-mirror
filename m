From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: storing cover letter of a patch series?
Date: Thu, 10 Sep 2015 11:46:21 -0700
Message-ID: <CA+P7+xodgeu6Vo+Rt57_iFycxkEnNjxP-TTOfY8DdXwzeVKbZg@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <xmqqh9n241el.fsf@gitster.mtv.corp.google.com> <CA+P7+xq9P2NHqQe-y+2n38ZvbR74UxR0Rik=btgy=JtEoZbX2A@mail.gmail.com>
 <xmqqvbbi2jy5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:46:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za6rt-0001oH-IS
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 20:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbbIJSqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 14:46:42 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35637 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbbIJSql (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 14:46:41 -0400
Received: by ioiz6 with SMTP id z6so71672096ioi.2
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 11:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=L6cAb11NpueqI6BftohtVd4obgzr0Ukgh8qZzT0sxt8=;
        b=qe7bIDo6M9Ol1874/nmzsRcz+0IJriqVvJJLoP1xWrklWH1+qBw2FAzTmFV9KDzvDc
         x67qMWFF84Jb1HaGKUJ60mzRgbCJavQaPzl0L/mORWEVdSQNbGP13XoKgtkNnPDqJCQu
         W7eUYuIfVRBvjnJs1xCbxib4bL189PaBsQVHiB61QRP9KbyfMGZToiOqE076ahle+lfX
         8L3iluJJScMUM8UjD7+5a8pDtgoSc8TOXyxnXSCj1X1KiExA1VL5zvI0hYv15nUZj575
         a0ygw8lWfbh+/7HBn5tzEeZu+8a7V4N6s8ui/3pgQsACWsGzexGziKOvPYTFufiEvSEl
         R6Mg==
X-Received: by 10.107.133.151 with SMTP id p23mr73072031ioi.71.1441910800566;
 Thu, 10 Sep 2015 11:46:40 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Thu, 10 Sep 2015 11:46:21 -0700 (PDT)
In-Reply-To: <xmqqvbbi2jy5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277626>

On Thu, Sep 10, 2015 at 11:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> I hadn't thought of separating the cover letter from git-send-email.
>> That would be suitable for me.
>
> Yeah, I said this number of times over time, and I said it once
> recently in another thread, but I think it was a mistake to allow
> git-send-email to drive format-patch.  It may appear that it will
> make things convenient in the perfect world where no user makes
> mistakes, but people are not perfect in real life.  Expecting them
> to be is being naive.
>

Yep. I didn't even know cover-letter was an option of format-patch
only thought it was in send-email.

Regards,
Jake
