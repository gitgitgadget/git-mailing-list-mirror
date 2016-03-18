From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 18/19] index-helper: autorun
Date: Fri, 18 Mar 2016 07:50:27 +0700
Message-ID: <CACsJy8Dx4=igm3YVYkTDdRSxevDo2xRij9P5m7VPxkVrq3oq8Q@mail.gmail.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
 <1457548582-28302-19-git-send-email-dturner@twopensource.com>
 <CACsJy8CaWFhCzrH3imz+BRMTESSmyUB4jeAaYUDNk+Tmpj-VrQ@mail.gmail.com>
 <alpine.DEB.2.20.1603151517590.4690@virtualbox> <1458151880.9385.1.camel@twopensource.com>
 <alpine.DEB.2.20.1603161923380.4690@virtualbox> <CACsJy8AsJKmsPm8Y1LRZdmyH60n3OT5X=42RGK5GXNBDfn8j8g@mail.gmail.com>
 <alpine.DEB.2.20.1603171536420.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 18 01:51:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agid7-0002uh-Nc
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 01:51:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031082AbcCRAvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 20:51:00 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:35718 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030602AbcCRAu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 20:50:59 -0400
Received: by mail-lf0-f44.google.com with SMTP id v130so27242711lfd.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 17:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UP2VxroYOtv4Tf7fep8Co4tncwBOKmTaXRkUc/9EDUU=;
        b=x+Td1Bfb4cAbYVWOLIbpfVDwoPAv+BUwJ0lz72ZIEmEVzuHDA7biQiWL+8KIMFkYmF
         KG1Z3fS2tCIg7r28kzq1U5TFvuLZvFk698450cwKV94DHB1OMCLvsYTK7f5mwoUiu+vV
         r9zQU/YMoW0zas6RaTh31pcyvAN6/nWIOfEIX5e7Wt8m7WPCvPvco9s4kj8n8Z8diVrV
         pHgP0YQwGk0qTUp6mJ0k7QdmdbgWBedrHWP/G7MM3UIHuYqTStPYnzH+iVfwUTgtvKwV
         FrDO+eI5N5Ci4Hk7H6NF9UzTauECAaaJsXw7okZu0ODhDb1AzIL33Uxd5hHF/iOafNFv
         zONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UP2VxroYOtv4Tf7fep8Co4tncwBOKmTaXRkUc/9EDUU=;
        b=dFarNBQzMFZKanXomTgMqmha9L2p0v8hLqOV+6D8lqUwnwIC7t0bdQfh8dUuLdlz+D
         Jwgq9J2y7QgVX33Bo0h5oueAyXtx/h6FFw0HkppoqXB3TSAACahiMewY00yI1BDkC0tW
         dRcMflbiygvlI2mk3dGi19TQIIRR3PIDbVQPcj+/ZpaiHKL1bFkuXgoTGDECTSnLyG4Y
         nfqgf5/Tify+oK3wlLgvVrGqM46cR4g5BfutevMk0+PbqtR9By4g/Kg3H7M/F7aLrzlh
         c9KBcSHu/OCwueIG3kXq/3xw4hrV1Cj5A5o5CDjc/5M72jvY3obbH7h6oU7e1djex7Hr
         aNlQ==
X-Gm-Message-State: AD7BkJLUcGKLKJxCZtzPT3KwwtNm5N08p4VLR3wMgAJP2+tCU+m0JvvoQGUlbdALttIga5Fa2+faaOyJQ6Fl8Q==
X-Received: by 10.25.212.213 with SMTP id l204mr4915632lfg.118.1458262257637;
 Thu, 17 Mar 2016 17:50:57 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 17 Mar 2016 17:50:27 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603171536420.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289176>

On Thu, Mar 17, 2016 at 9:43 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Thu, 17 Mar 2016, Duy Nguyen wrote:
>
>> On Thu, Mar 17, 2016 at 1:27 AM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:
>> > I am much more concerned about concurrent accesses and the communication
>> > between the Git processes and the index-helper. Writing to the .pid file
>> > sounds very fragile to me, in particular when multiple processes can poke
>> > the index-helper in succession and some readers are unaware that the index
>> > is being refreshed.
>>
>> It's not that bad.
>
> Well, the way I read the code it is possible that:
>
> 1. Git process 1 starts, reading the index
> 2. Git process 2 starts, poking the index-helper
> 3. The index-helper updates the .pid file (why not set a bit in the shared
>    memory?) with a prefix "W"
> 4. Git process 2 reads the .pid file and waits for the "W" to go away
>    (what if index-helper is not fast enough to write the "W"?)
> 5. Git process 1 access the index, happily oblivious that it is being
>    updated and the data is in an inconsistent state

No, if process 1 reads the index file, then that file will remain
consistent/unchanged all the time. index-helper is not allowed to
touch that file at all.

The process 2 gets the index content from shm (cached by the index
helper), verifies that it's good (with the signature at the end of the
shm). If watchman is used, process 2 can also read the list of
modified files from another shm, combine it with the in-core index,
then write it down the normal way. Only then process 1 (or process 3)
can see the new index content from the file.

>> We should have protection in place to deal with this and fall back to
>> reading directly from file when things get suspicious.
>
> I really want to prevent that. I know of use cases where the index weighs
> 300MB, and falling back to reading it directly *really* hurts.

For crying out loud, what do you store in that repo? What I have in
mind for all these works are indexes in 10MB range, or maybe 50MB max.

Very unscientifically, git.git index is about 274kb and contains ~3000
entries, so 94 bytes per entry on average. With a 300MB index , the
extrapolated number of entries is about 3 millions! At around 1
million index entries, I think it's time to just use a database as
index.

>> But I agree that sending UNIX signals (or PostMessage) is not really
>> good communication.
>
> Yeah, I really would like two-way communication instead. Named pipes?
> They'd have the advantage that you could use the full path to the index as
> identifier.

Yep.

> The way I read the current code, we would actually create a different
> shared memory every time the index changes because its checksum is part of
> the shared memory's "path"...

Yep. shm objects are "immutable", pretty much like git objects. But
now that I think of it, I don't know how cheap/expensive shm creation
operation is on Windows.
-- 
Duy
