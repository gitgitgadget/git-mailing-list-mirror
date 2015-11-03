From: Stefan Beller <sbeller@google.com>
Subject: Re: git.git as of tonight
Date: Tue, 3 Nov 2015 15:00:24 -0800
Message-ID: <CAGZ79kZM-Q2oxVkMO9=v=tAdJkpWWOTVkaSMRDKZSZia2MY5Ng@mail.gmail.com>
References: <xmqqpoztf6ok.fsf@gitster.mtv.corp.google.com>
	<5637D266.4060904@kdbg.org>
	<CAGZ79kbx7UJOOkhiXiUJfUS25gMGx5BUq=Qxa9205H0Z78ijbQ@mail.gmail.com>
	<56385587.1010601@kdbg.org>
	<xmqq37wndndp.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbAj-tZS3X1EwFw_gGh1=YU8M0OmEX91W8f++fqs6TiBA@mail.gmail.com>
	<56392106.1010401@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 00:00:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtkZ5-00076i-63
	for gcvg-git-2@plane.gmane.org; Wed, 04 Nov 2015 00:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965059AbbKCXA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 18:00:26 -0500
Received: from mail-yk0-f175.google.com ([209.85.160.175]:33063 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965038AbbKCXAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 18:00:25 -0500
Received: by ykft191 with SMTP id t191so42940788ykf.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 15:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=VFHyMniw0DnrbJExXfk8U2lURzuFZUrrUCXzjG2HRHA=;
        b=eX1Z3twpPitmBmhcjXecAqLH8BlJTfc/brhZ/4nrBGyIPa91iSgkwqXo7oYX/Cg0Jp
         zZ7piniTk1m6A+N6rrtHM4V5Ny1+u4S9SLfi0EdsKRzpWHNt9J1ZJJiP+pfhwMNQfBgA
         kJwmheUrJu3tbdbXLzXgIXgxE6miZpUgNOqH2lZmGDsh02ycFiP8dJUrs3/NBp7CoV7F
         SmGpZtTdDDDPHBoXHqzILxOj8vttYoydbstWBkWEbYYjF8GvyMOlywD9G1zobvad6Uys
         60ZyrBHpN9tKhr2XYftLeSB6Tdc6xGGTVb9SPhHCJ3SIM0R1mfkZRztYmq7fswcxWdHD
         cDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=VFHyMniw0DnrbJExXfk8U2lURzuFZUrrUCXzjG2HRHA=;
        b=F/Rcc7MssIccYQRNkzqxD35vmp348TyqYPU/EhWzUbB1MTFNAQvPSZWUC2oOSmfNoo
         mzcMeSC75A82ywQCABPq9le6gJNj/bcCEFmVAEjOfYPlnbjoKD6UFv+De34GexUx9IiR
         dN34WadngA91JDdrQT4f4TwexH9yNxpi+muCwfX5bX/ekVWeQ/xbYzbnHMtz1vssu3lq
         F7KIvjzdPZP5gIeY+vlYm+YxJxax0lL7fIhCBeI49LqfFDwpYN1vehN1sKXTU7d50j1G
         FVQSjvDpyiC73voGUZme0lr8O4IXUJgiaLykVZXt2Dt6xYaZMMYEdBsE+vjAn8TVlFEw
         OUJQ==
X-Gm-Message-State: ALoCoQmLgiH5mzJaau5HxevZ3ycLKbWUTLeUEPn7B2G19RgApKq3a58EsBzuuugwwZ8BWs0UyVwA
X-Received: by 10.129.40.147 with SMTP id o141mr12959008ywo.199.1446591624872;
 Tue, 03 Nov 2015 15:00:24 -0800 (PST)
Received: by 10.37.29.213 with HTTP; Tue, 3 Nov 2015 15:00:24 -0800 (PST)
In-Reply-To: <56392106.1010401@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280830>

On Tue, Nov 3, 2015 at 1:03 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 03.11.2015 um 19:18 schrieb Stefan Beller:
>>
>> ... ReadFileEx ... "overlapped" operation.
>
>
> Let's not go there just yet.
>
>>>   1. Make this an optional feature so that platforms can compile it
>>>      out, if it is not already done.  My preference, even if we go
>>>      that route, would be to see if we can find a way to preserve the
>>>      overall code structure (e.g. instead of spawning multiple
>>>      workers, which is why the code needs NONBLOCK to avoid getting
>>>      stuck on reading from one while others are working, perhaps we
>>>      can spawn only one and not do a nonblock read?).
>>
>>
>> Yeah that would be my understanding as well. If we don't come up with
>> a good solution for parallelism in Windows now, we'd need to make it at
>> least working in the jobs=1 case as well as it worked before.
>
>
> That should be possible. I discovered today that we have this function:
>
> static void set_nonblocking(int fd)
> {
>         int flags = fcntl(fd, F_GETFL);
>         if (flags < 0)
>                 warning("Could not get file status flags, "
>                         "output will be degraded");
>         else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
>                 warning("Could not set file status flags, "
>                         "output will be degraded");
> }
>
> Notice that it is not a fatal condition if O_NONBLOCK cannot be established.
> (BTW, did you ever test this condition?)

No, as I viewed it more like a severe problem, not to be happen in the
near future.
But if it were to happen we would still need to finish the command
instead of giving
up because of degraded output. (I would not know how to test this
system call to fail,
so maybe I am just making up excuses)

I added an #ifdef just as you proposed below and the output itself
doesn't look too bad
except for the warning message themselves. If we'd just remove them it
would look
better to me.

So maybe we could just go with

    static void set_nonblocking(int fd)
    {
    #ifndef GIT_WINDOWS_NATIVE
        int flags = fcntl(fd, F_GETFL);
        if (!(flags < 0))
            fcntl(fd, F_SETFL, flags | O_NONBLOCK)
    #endif
    }

and see how people react to the output then?


> If we add two lines (which remove
> the stuff that does not work on Windows) like this:
>
> static void set_nonblocking(int fd)
> {
> #ifndef GIT_WINDOWS_NATIVE
>         int flags = fcntl(fd, F_GETFL);
>         if (flags < 0)
>                 warning("Could not get file status flags, "
>                         "output will be degraded");
>         else if (fcntl(fd, F_SETFL, flags | O_NONBLOCK))
> #endif
>                 warning("Could not set file status flags, "
>                         "output will be degraded");
> }
>
> we should get something that works, theoretically. We still need a more
> complete waitpid emulation, but that does not look like rocket science. I'll
> investigate further in this direction.
>
> -- Hannes
>
