From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Re: [PATCH] teach the user to be nice to git and let him say
 please sometimes
Date: Mon, 13 May 2013 20:58:47 +0700
Message-ID: <CACsJy8Cj1pf1YqWLq1Hbgx9cDL96Kst9JkrcwwF8ELXU5BASLg@mail.gmail.com>
References: <20130511201928.GA22938@book.hvoigt.net> <CACsJy8A+vjtwnB0LStVS3Q9v2JaKcMDa0sATr9H==X3EhQt6Jg@mail.gmail.com>
 <20130513133035.GA3561@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 13 15:59:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbtHf-0000se-Tc
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 15:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab3EMN7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 09:59:19 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40313 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab3EMN7S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 09:59:18 -0400
Received: by mail-ob0-f174.google.com with SMTP id un3so1529012obb.5
        for <git@vger.kernel.org>; Mon, 13 May 2013 06:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=cxnI4SpxKHKpee6e3nBvHEqTObIqVMjgDRLvENy4D0U=;
        b=A3ywLcIXq+syoNgziBBv8keKEA5EDA/bWa+mBXFYlJ2c6K97oGG3fAkJvGXGeOeoeH
         jV4zmKhC0iHfc3BWZzMl6mL75j6KLQ2rEOHOQR+ybHmfT5AW4mChvcvAL0xMpNmIcxed
         1dqFHVkhIhaqxuB0iSLT2iJFmL+gFvIAIruZCYIhT817VrNSbCc7xijBbcQif8m6Twpe
         50CqKF6ZQoYJD+a3ZSWtKeaE1MdndHrOMklSajegSxCOTPQ8O2kflk7vkU2NfElfWwWG
         cKdXNX52S5+pbBCloikG4zjx9ahFpfl/FtNbzJH4nFZ4XX2bWjGkOXxCYP7sBOJCuDte
         cASA==
X-Received: by 10.182.45.231 with SMTP id q7mr13217199obm.58.1368453558159;
 Mon, 13 May 2013 06:59:18 -0700 (PDT)
Received: by 10.76.180.138 with HTTP; Mon, 13 May 2013 06:58:47 -0700 (PDT)
In-Reply-To: <20130513133035.GA3561@book-mint>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224145>

On Mon, May 13, 2013 at 8:30 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>> > +       if (impolite_counter > 10)
>> > +               die("Error: Learn some manners, say please some time!");
>> > +       if (polite_counter > 10)
>> > +               die("Error: Too many please! I don't believe you.");
>>
>> NAK. If we truly care, we need better AI here!
>
> I agree but this patches goal was to implement the basic politeness
> infrastructure. We planned to add more features, like inter-repository
> jealousy, later. For inter-repository jealousy git would complain if you
> worked more with one repository than others you cloned and you'd for
> example sometimes need a double please to satisfy it.

I'm still not happy with this direction. I propose we rewrite C Git in
Lisp first as a preparation step for git-please improvements. We could
drop support for all platforms but Lisp Machine along the way. That
would make all other Git implementations jealous.
--
Duy
