From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 5/8] branch: drop non-commit error reporting
Date: Mon, 21 Sep 2015 15:50:31 +0530
Message-ID: <CAOLa=ZTYfNN6ATae6pYy1QHPo-u70itz9euHvaWjiayUgKD9GA@mail.gmail.com>
References: <1442772627-25421-1-git-send-email-Karthik.188@gmail.com>
 <1442772627-25421-6-git-send-email-Karthik.188@gmail.com> <vpq6134gauz.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 21 12:21:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdyDd-00038a-2i
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 12:21:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756478AbbIUKVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 06:21:03 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36171 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756257AbbIUKVB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 06:21:01 -0400
Received: by vkfp126 with SMTP id p126so61593346vkf.3
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 03:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=vephVZ3zXH6v5O7ufqTl+BmuGbI2oviGAX1fl8FWvYo=;
        b=rObgR5Or8aQb84fts5jVs6GVYm3q6PEDqgR6vYJQVAqKZcNz4fS2DrdAgd9URRl6u4
         dqNrwsUSStQbDfsPyvZARyI/oLyz6d/zN5qHPuw585x3jbrpmksnpS5C/0B1kyrv3uKM
         7jOlIdcYAlacuvuJvtlmXin9TUdh1aRc5AFBFnnGkGxjVTHR3sV87fN7IkmIRJY5rRJA
         uiZAneLZgWWD9oK6d+u7C5bhw8NoLzMAnN0CZVzRH3qPTTOcQQ5sbkRAd77eaXn84LiB
         Ei8Faar3FClqprYv9M3OeKWIaLYnD0mmWvRK8+OYzjfqeQWwsraf2JU6XLE3O/pIxGX7
         UqHg==
X-Received: by 10.31.161.142 with SMTP id k136mr8279345vke.17.1442830860602;
 Mon, 21 Sep 2015 03:21:00 -0700 (PDT)
Received: by 10.103.23.193 with HTTP; Mon, 21 Sep 2015 03:20:31 -0700 (PDT)
In-Reply-To: <vpq6134gauz.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278299>

On Mon, Sep 21, 2015 at 12:46 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> Remove the error reporting variable to make the code easier to port
>> over to using ref-filter APIs. This variable
>
> (it's not just a variable, it's also a message on the output)
>
>> is not required as in ref-filter we already check for possible errors
>> and report them.
>
> You should explain more why the check is redundant with the ones in
> ref-filter. You discussed this with Junio on the last round. The
> arguments you gave would deserve to appear in the commit message IMHO.
> Pointing to the exact checks in ref-filter would help.
>
> It may make sense to split the commit into several smaller ones, so that
> you can give a precise commit message for each error reporting you
> remove (error(_("branch '%s' does not point at a commit") and
> error(_("some refs could not be read"))).
>

I could do that, but it would be small changes. But I think it's worth it,
will wait for other changes if needed and send.

-- 
Regards,
Karthik Nayak
