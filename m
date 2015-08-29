From: Namhyung Kim <namhyung@gmail.com>
Subject: Re: [PATCH] stash: Add stash.showFlag config variable
Date: Sun, 30 Aug 2015 00:19:43 +0900
Message-ID: <CAM9d7cg4k=H9GY=CihuHdyH1yj-z4EUkKsWrDO0DXKx3QwDejw@mail.gmail.com>
References: <1440683528-11725-1-git-send-email-namhyung@gmail.com>
 <xmqq614043u0.fsf@gitster.mtv.corp.google.com> <20150828015433.GB17656@sejong>
 <xmqqy4gv1dyr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 29 17:20:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVhvR-0002mn-Jd
	for gcvg-git-2@plane.gmane.org; Sat, 29 Aug 2015 17:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbbH2PUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Aug 2015 11:20:05 -0400
Received: from mail-io0-f170.google.com ([209.85.223.170]:34100 "EHLO
	mail-io0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbbH2PUE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Aug 2015 11:20:04 -0400
Received: by iofe124 with SMTP id e124so55222034iof.1
        for <git@vger.kernel.org>; Sat, 29 Aug 2015 08:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9chvCZ7KpSf1TFQRipAThyedu+ePqD63thla+yIkmSk=;
        b=KrpFxoEktuLvAtgqwYgfhCNuNQ6ijP9YLnOJUmeaOhsN8cL5Mba8Wrb/MyNAr3hMIe
         UuQoEefYKXF5/0YeQHwIN0wHyP+yn/JJx7LRGus4+s9yDmORycVHEn9Mlkwv5ElP/PSW
         PHhD2cj5/IqjvuMf3NAP3B0mHlQuNX33+I8NqrUStPCJ/3QW2LBNZsn0wjxAoxfOXQIb
         MtE1nfatv5xC9lz5eTkLgZZ7vdY7g255K/5FJ8zm4xHcArLGveRLTw9E85DuvYILPZ+h
         3bQW7ccSwUtyOLaQ9CrNjI8oIqeNUGdjGRR9qJmiekcIPQOZ8nYyfX2QejH9uspZqD8Q
         zYng==
X-Received: by 10.107.15.209 with SMTP id 78mr18409959iop.51.1440861603406;
 Sat, 29 Aug 2015 08:20:03 -0700 (PDT)
Received: by 10.107.20.5 with HTTP; Sat, 29 Aug 2015 08:19:43 -0700 (PDT)
In-Reply-To: <xmqqy4gv1dyr.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276790>

Hi,

On Sat, Aug 29, 2015 at 3:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Namhyung Kim <namhyung@gmail.com> writes:
>
>>> Perhaps a pair of new booleans
>>>
>>>  - stash.showStat (defaults to true but you can turn it off)
>>>  - stash.showPatch (defaults to false but you can turn it on)
>>>
>>> or something along that line might be sufficient and more palatable.
>>
>> Hmm.. I agree with you, but I don't know what we should do if both of
>> the options were off.  Just run 'git diff' with no option is ok to you?
>
> If the user does not want stat or patch, then not running anything
> would be more appropriate, don't you think?

Ah, ok. :)  I'll change that way and send v3 soon!

Thanks,
Namhyung
