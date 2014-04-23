From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] mergetool: run prompt only if guessed tool
Date: Wed, 23 Apr 2014 00:58:51 -0700
Message-ID: <CAJDDKr5P7crudFiAa7Lu4CYmDWgZ-drdkiOfusFHioTF9co2Nw@mail.gmail.com>
References: <1398039454-31193-1-git-send-email-felipe.contreras@gmail.com>
	<1398039454-31193-3-git-send-email-felipe.contreras@gmail.com>
	<20140422045951.GA60610@gmail.com>
	<xmqqbnvt703s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Charles Bailey <charles@hashpling.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 09:59:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcs53-00054o-0g
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 09:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbaDWH6x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 03:58:53 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:39537 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbaDWH6w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 03:58:52 -0400
Received: by mail-qg0-f44.google.com with SMTP id q108so569935qgd.31
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 00:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=60XikvDSv5/f+1GnyV1jChjJuZdyHUbb01k60OfuPhc=;
        b=zM24j4w6Ypvt/mYQTf1kUi6kG97ffN5YxwZBLl/kT1GacUJtgYEFAdmYdrN/ZFM4nT
         v8+16gDLpGIvN3pKKJ/sS5wpmlJQcwDOH6JgU4UGMW0e0z5xPJ9J1zV8duOcydULOgAv
         mjXM1oUhKxFonyPML2MrIOQJe4Hd1EJsOEfEF3Qu8m+8ntA9EYNogE0SytxebBI17W/S
         9p/R1bH+v3LBy7fC+B5Pb0OpX9MGlyWwGKHmJUKGLznZI3HfG1PnL5OuVtYch74VukT9
         kFGUcT9EHXH+KhGHgSyEHEo3rTiqeP9lJkXLHnmKKPLzMNmeQwYmugW2IcoeDKdiQMXu
         DNXg==
X-Received: by 10.224.21.197 with SMTP id k5mr55602043qab.3.1398239931510;
 Wed, 23 Apr 2014 00:58:51 -0700 (PDT)
Received: by 10.229.250.133 with HTTP; Wed, 23 Apr 2014 00:58:51 -0700 (PDT)
In-Reply-To: <xmqqbnvt703s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246816>

On Tue, Apr 22, 2014 at 10:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> [Cc:ing Charles in case he has an opinion, this behavior dates back to the original MT]
>>
>> On Sun, Apr 20, 2014 at 07:17:34PM -0500, Felipe Contreras wrote:
>>> It's annoying to see the prompt:
>>>
>>>   Hit return to start merge resolution tool (foo):
>>>
>>> Every time the user does 'git mergetool' even if the user already
>>> configured 'foo' as the wanted tool.
>>>
>>> Display this prompt only when the user hasn't explicitly configured a
>>> tool.
>>
>> I agree this is probably helpful.
>> Most users I've met end up configuring mergetool.prompt=false.
>>
>> Thanks
>
> OK, is it an Ack?

Sure thing.

Acked-by: David Aguilar <davvid@gmail.com>

> Thanks for CC'ing Charles, by the way.  I think his point about
> mentioning the change of default somewhere in the documentation
> has some merits, and it can be done in a follow-up patch on top.

Another thing that crossed my mind is that we have -y for --no-prompt
because --prompt was the original default. Maybe a -i (?) shortcut for
the interactive --prompt can be added to make the "need to skip some
when resolving" use case easier to activate.
-- 
David
