From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [RFC] status: show tracking branch even no difference
Date: Thu, 8 Aug 2013 00:03:42 +0800
Message-ID: <CANYiYbFaKmMpX=8FTB3LGMVvF4JUpqXo=T1zZ7+tog5aUJhzLQ@mail.gmail.com>
References: <46fb1948a57990b0ea737401f2d60f654da4bb4f.1375890091.git.worldhello.net@gmail.com>
	<vpqr4e5h55b.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 07 18:03:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V76DK-0005kW-PR
	for gcvg-git-2@plane.gmane.org; Wed, 07 Aug 2013 18:03:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932128Ab3HGQDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Aug 2013 12:03:45 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:65120 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932109Ab3HGQDo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Aug 2013 12:03:44 -0400
Received: by mail-wi0-f179.google.com with SMTP id hr7so1870828wib.6
        for <git@vger.kernel.org>; Wed, 07 Aug 2013 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EyJB9Pmsc+jiweQI+TDL+hjJ+I3S8M1Vh3mN1MCr354=;
        b=SPH7KGegITFMBEWO7r/ZyoaofoBnv+Pzo2OBDeE99EBA1tRG7UfXeeYZ4tlxFDU4qQ
         +Nuer4GfQB6FdOwE9usbqoSA56VjhupZ0XkEQ7nXUUHd6G2uhD3jqMA0cdlMHASi+crH
         68QZkAovJVuIdlQ56AN9ulls1LZH7uzwnLvn8M2iBGnRCYIExPpqBilcGZAYlHiVdaut
         GilCthJZ8PBnsuQ2mKMaVgUbMEsC9k/Ys7VbEquXsv7ez0Lama6EHgRqDjlTj3Z9NISW
         6dNOaqx8m7R+h33Lfam1hGJDY6GjlT8k0l44nBrA8sEWidDtVHqZrdHBw9CMLQrrKL0b
         +IyA==
X-Received: by 10.180.11.200 with SMTP id s8mr2672919wib.10.1375891422733;
 Wed, 07 Aug 2013 09:03:42 -0700 (PDT)
Received: by 10.194.104.201 with HTTP; Wed, 7 Aug 2013 09:03:42 -0700 (PDT)
In-Reply-To: <vpqr4e5h55b.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231835>

2013/8/7 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
> Jiang Xin <worldhello.net@gmail.com> writes:
>
>> With this patch, "git status" will report relationship between current
>> branch and its upstream counterpart even if there is no difference.
>>
>>     $ git status
>>     # On branch master
>>     # Your branch is identical to its tracking branch: 'origin/master'.
>
> Why not, but we try to say "remote-tracking branch" instead of just
> "tracking". Adding "remote-" in your wording may make the line a bit
> long, but it may be sufficient to say
>
> # Your branch is identical to 'origin/master'

That's better. Thanks.

>
> That's consistant with other messages like
>
> # Your branch is ahead of '%s' by %d commits
>
> (And this would deserve a test)

Will add some test cases in t6040 if this patch has value.

-- 
Jiang Xin
