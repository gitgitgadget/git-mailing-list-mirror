From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH] config: add show_err flag to git_config_parse_key()
Date: Thu, 30 Oct 2014 23:55:42 +0530
Message-ID: <CAEc54XBWbBNzkh6OqBoMpMkO07qyDEOJ8vd8AN-tRWa9wKDJZg@mail.gmail.com>
References: <CAEc54XBOvqT234s0UX-osYbOJfyuPquWLtmzDNDhAQoJ8b9eXg@mail.gmail.com>
	<xmqqd299wh9m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 19:25:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjuPr-0008AT-Hr
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 19:25:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760769AbaJ3SZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 14:25:43 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:47967 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759471AbaJ3SZn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 14:25:43 -0400
Received: by mail-ie0-f179.google.com with SMTP id ar1so5919620iec.10
        for <git@vger.kernel.org>; Thu, 30 Oct 2014 11:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2IsqPgUvC3ff+91C6jPlaf7mO/QgnLTv48mbYlKMxEI=;
        b=BWV4h9PTgjodbH6eNw89uI3kI0jUbJFPHkNgMMoPCalvwD6C20qyQHXo7j0BWLmWg/
         6kfNTVQMiJc+0BJbufnJKMzjI/HCw6A8U9plpLa5bs8XJqIiLtbp15DwhissqjxOrYA/
         UMLfoDNLZZ1c22xhuVVOx+EZZqGyVjuDpjmrZaHAEtTxwYZVulE9avw2/FgVx395jFxS
         N3nyH7K7NDLZth02xTEqp9Iu3+96tI6Oxsg0exLSNhIIfY7sI9KiaXRKmLwtZsWkQTJ6
         VHTwAR0Vr6tFk+mxoAHxZeNfTr5FB9kdq5WOixVEguNw0E/cZ4gPd0d603Bv4dM/7IZI
         zeag==
X-Received: by 10.50.43.231 with SMTP id z7mr21849428igl.36.1414693542401;
 Thu, 30 Oct 2014 11:25:42 -0700 (PDT)
Received: by 10.107.28.75 with HTTP; Thu, 30 Oct 2014 11:25:42 -0700 (PDT)
In-Reply-To: <xmqqd299wh9m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> ---
>>
>> Hi,
>>
>> You were right, one of the functions was calling git_config_parse_key()
>> which was leaking errors to the console. git_config_parse_key() was
>> meant for sanitizing user provided keys only but it was being used
>> internally in a place where only a return value would be enough.
>>
>> Thanks for bringing this to our attention.
>>
>> Cheers,
>> Tanay Abhra.
>
> Who are *you* in the above, and what was the bug report about (if it
> was a bug report)?  Perhaps summarize it in a form of a few new tests
> in t/t13XX series is in order?
>
> Thanks.
>

Sorry about that, I am behind a firewall and had to use the gmail web interface.
The patches are butchered, I will send new ones with a proper connection
tomorrow.

The original bug report is at [1].

http://thread.gmane.org/gmane.comp.version-control.git/258886
