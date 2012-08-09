From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 resend] gitk: Use an external icon file on Windows
Date: Thu, 9 Aug 2012 18:13:15 +0200
Message-ID: <CAHGBnuOwtkHMAUgY8r=9PiWT0MUH83FRQQ8eJuzRV43T5Oyduw@mail.gmail.com>
References: <500CEF06.2030501@gmail.com>
	<5022CDFC.4090900@gmail.com>
	<7v628trsry.fsf@alter.siamese.dyndns.org>
	<CAHGBnuOKsPJoRADfukCJ8abSVVKUy5vbuh18S7UD8rLScVq=GQ@mail.gmail.com>
	<7vmx24oybg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 18:13:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzVMP-0003HU-RZ
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 18:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753952Ab2HIQNR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 12:13:17 -0400
Received: from mail-vb0-f46.google.com ([209.85.212.46]:37029 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928Ab2HIQNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 12:13:16 -0400
Received: by vbbff1 with SMTP id ff1so114254vbb.19
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 09:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=bjwBEDjPgT8toDLrtTyhh60Sjt7PslvoNf4FRZIfc7w=;
        b=cw+EyAHr4xv5cqntvXVm7ufuIlvdnlK4MGMbZGSjigzSZMPjhRK9C+ys6YJIBOEdG2
         vAru2ST8p9p721/Qa08tnXcmubgFQWyGmqcsX5MgBu5qx/AFuzm7RY5oHaesb1A4V/FY
         lQjtBuDc0meo7zY/Ieu+rlWmFCUpQA1TfqdWVdmwR9Hi1ZxQBuvoKmYq0m5X6mdOvnwA
         b7qAA4PT+A91aDApIiiDBb0smFEPCcA1IbE4j47eyNDeEkhUL8kZ5Eg0r2YLqX/8qLxD
         y5qBKnA/TEI131ge61zuwRJ79FSp734U6w+aCAr8geUGNYy7umISCrrEkhzXMcUlD+p4
         GCsA==
Received: by 10.221.0.74 with SMTP id nl10mr17304251vcb.47.1344528795478; Thu,
 09 Aug 2012 09:13:15 -0700 (PDT)
Received: by 10.58.68.167 with HTTP; Thu, 9 Aug 2012 09:13:15 -0700 (PDT)
In-Reply-To: <7vmx24oybg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203163>

On Thu, Aug 9, 2012 at 5:54 PM, Junio C Hamano <gitster@pobox.com> wrote:

>>> Forwarding a misdirected patch to the maintainer who is free to pick
>>> or ignore.
>>
>> How am I supposed to know if a patch has been ignored as an oversight
>> (in which case I would resend), or because the maintainer decided not
>> to include it (in which case I would not resend in order to not annoy
>> the maintainer)?
>
> By hearing from Paul (or asking directly), perhaps?

I did that, in a private mail due to some temporary mailing list
problems, but did not get an answer. So my question was referring to
Paul. How I should know whether Paul ignores my patch due to an
oversight, or because he is not interested? And because of this
ambiguity in ignoring a patch I think an explicit NACK should be
mandatory if a maintainer is not interested in a patch.

> And that goes both ways.  If the logo of the "official" site is not
> something so important that git-scm.com can change without gaining
> community consensus first, then it equally is within the editorial
> discretion of individual git package's maintainer to keep using the
> original not the updated logo.

I admit that I was assuming community consensus on the new logo
exactly *because* I saw it on git-scm.com. On the other hand, from my
experience the Git community is not exactly one where is it
particularly easy to get consensus on something, so I completely
understand and support Scott's habit to sometimes go one way without
consulting the community first.

Anyway, I'll include the patch into Git for Windows, because that's
what our users ask for.

-- 
Sebastian Schuberth
