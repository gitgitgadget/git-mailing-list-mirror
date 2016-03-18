From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 18/19] index-helper: autorun
Date: Fri, 18 Mar 2016 14:34:49 +0700
Message-ID: <CACsJy8Bu6QyYmJpPHpEgDx5djt=9XjXzckzJKL_mx8yHeyHdCA@mail.gmail.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
 <1457548582-28302-19-git-send-email-dturner@twopensource.com>
 <CACsJy8CaWFhCzrH3imz+BRMTESSmyUB4jeAaYUDNk+Tmpj-VrQ@mail.gmail.com>
 <alpine.DEB.2.20.1603151517590.4690@virtualbox> <1458151880.9385.1.camel@twopensource.com>
 <alpine.DEB.2.20.1603161923380.4690@virtualbox> <CACsJy8AsJKmsPm8Y1LRZdmyH60n3OT5X=42RGK5GXNBDfn8j8g@mail.gmail.com>
 <alpine.DEB.2.20.1603171536420.4690@virtualbox> <CACsJy8Dx4=igm3YVYkTDdRSxevDo2xRij9P5m7VPxkVrq3oq8Q@mail.gmail.com>
 <alpine.DEB.2.20.1603180815160.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 18 08:35:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agowQ-00055d-Hd
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 08:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbcCRHfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 03:35:23 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34868 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbcCRHfV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 03:35:21 -0400
Received: by mail-lb0-f182.google.com with SMTP id bc4so83101700lbc.2
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 00:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d+LL1WlbK90HdmT7/2yMP8VdEix6ApOKLa9bawkyE9U=;
        b=p3qBDdJWCG/x8M7NefcvpIpX4CW4QFMaawg6tTS32ldwWXD9bg1jcehLScHRCwl/j2
         S+irHlw+SojCU4xXdvzMt0WY5L51SLrUXDDuHfmCtyJFpLEImLjS+0Blo8pLDsQV0mI0
         weWMRWdZ7wsWVGN++q6v34QNlHxAtjdERtMFxb8GRD1MqjNscfSIIA6perbbyVkevvXW
         CuqDxMcM//lQTndgREDtk6k32Ab+K5LzG84UBPBKhgi4rh7qGpUyuBfmvKg7a7Luq+SG
         CG3NThEv2gws86x/wSta6HeKKOGouqyJeRAc1Yk0C3XSdJEwqSrZ9PNXhGFcDKS5liiZ
         amMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d+LL1WlbK90HdmT7/2yMP8VdEix6ApOKLa9bawkyE9U=;
        b=L6r65VkcN8L7f6mzouZc1X6t0KOwXhGVqitxpjVk9DmDn81x9cjIGWuPEZY7uXT03M
         XmODNI7cRfhIZYoCcwf9fOrIM85IU+bYKqmcXofvXiTgBCes7fmiWMdLx6yi4sMYOu2h
         lreH/dT3UEkGlrnS9duxod5CKztu5hKX4DEnkdKN9EOm/VCPb82eXgUC8bHb5BIC2Eh/
         kUvnwL8tgAy1TW9WtBojtg7mnefQLqSYEt/X1iKN02VDogBHMoJpSH7s87h+qS5BtACb
         C6Kk61Q2UV6cj4MBNEf0cn7X3VsAUgpj+kcQeeJKW0PeyTOTbsug1eq+xKzUt3tGSpi2
         TiHQ==
X-Gm-Message-State: AD7BkJJLI1k2zkRwnEdkX1vVG3/E47yUFR1n9j3sPo7QlqAnVRFM+5Amjn/ZMxgRetFcGUbTkkTB88IrRl9uDA==
X-Received: by 10.112.140.129 with SMTP id rg1mr5475895lbb.80.1458286519500;
 Fri, 18 Mar 2016 00:35:19 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Fri, 18 Mar 2016 00:34:49 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603180815160.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289209>

On Fri, Mar 18, 2016 at 2:17 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Fri, 18 Mar 2016, Duy Nguyen wrote:
>
>> > Well, the way I read the code it is possible that:
>> >
>> > 1. Git process 1 starts, reading the index
>> > 2. Git process 2 starts, poking the index-helper
>> > 3. The index-helper updates the .pid file (why not set a bit in the shared
>> >    memory?) with a prefix "W"
>> > 4. Git process 2 reads the .pid file and waits for the "W" to go away
>> >    (what if index-helper is not fast enough to write the "W"?)
>> > 5. Git process 1 access the index, happily oblivious that it is being
>> >    updated and the data is in an inconsistent state
>>
>> No, if process 1 reads the index file, then that file will remain
>> consistent/unchanged all the time. index-helper is not allowed to
>> touch that file at all.
>>
>> The process 2 gets the index content from shm (cached by the index
>> helper), verifies that it's good (with the signature at the end of the
>> shm). If watchman is used, process 2 can also read the list of
>> modified files from another shm, combine it with the in-core index,
>> then write it down the normal way. Only then process 1 (or process 3)
>> can see the new index content from the file.
>
> So how do you deal with releasing the shared memory instances that are
> essentially created for every index update?

When index-helper reads the index file and realizes the file has been
updated (based on trailing SHA-1), it unlink()s the old shm and
prepares new shm. If no process is accessing old shm, it's gone. If
not, it stays until nobody elses uses it. shm on Windows behaves the
same way, I believe.
-- 
Duy
