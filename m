From: Reece Dunn <msclrhd@googlemail.com>
Subject: Fwd: Native Windows implementation of GIT ?
Date: Sat, 13 Jun 2009 17:12:07 +0100
Message-ID: <3f4fd2640906130912l6cf050bct7d4313bd3d546908@mail.gmail.com>
References: <2A554044B82841D594338E2E096804BC@HPLAPTOP>
	 <3f4fd2640906121512rdede623k7d08ef9785b8bc5a@mail.gmail.com>
	 <9719867c0906130832y491daa8eq1a684051f2268d1e@mail.gmail.com>
	 <3f4fd2640906130909x6184f06bl5b6369e6e280426c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Aaron Gray <aaronngray.lists@googlemail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 13 18:20:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFVxr-0001b6-AI
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 18:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757593AbZFMQUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 12:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755055AbZFMQUA
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 12:20:00 -0400
Received: from qw-out-2122.google.com ([74.125.92.24]:60247 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbZFMQT7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 12:19:59 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1823849qwd.37
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 09:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KuTWU1ue4Qnzb7HApu0NXlHXgqrSpxwgbhzArqyfuaw=;
        b=WJXOHItbleLggOexRNwaAyBShka5w1yeiur2Zl51rEPyENtye+Buk0k50stBL8wRs2
         smDWxCNIbCJ1tkEXL8NOVc56nM63eFBbg7OCOjUeIQQ4SuWdGrkLQQiDyM3OpOOP+sd1
         9xGUpbZLNybETIjOZrCpApYkh2NODP+K1hsMg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h8+LO6qvMEwQ+kcD+gj+So9o3u+eqXbSjyCZ8t330Co6UK+yKrVLAzHl/JwI++cWIR
         /jKXY2JA6wQcSdgLG5HgEBs697Fcy/sqzpaWaRWwmntJoy+hnf9cCNlsKZ/AuJ5oSXTg
         Dd83pt5qXFvV3Q8iZFA/NVvubz1W1XgR3tiec=
Received: by 10.220.91.203 with SMTP id o11mr4043407vcm.95.1244909527615; Sat, 
	13 Jun 2009 09:12:07 -0700 (PDT)
In-Reply-To: <3f4fd2640906130909x6184f06bl5b6369e6e280426c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121506>

Forwarding to the git mailing list (Aaron: could you keep the mailing
list in the CC, thanks).

- Reece

---------- Forwarded message ----------
From: Reece Dunn <msclrhd@googlemail.com>
Date: 2009/6/13
Subject: Re: Native Windows implementation of GIT ?
To: Aaron Gray <aaronngray.lists@googlemail.com>


2009/6/13 Aaron Gray <aaronngray.lists@googlemail.com>:
>>Unless by native you mean using Visual Studio?
>
> Yes built on Visual Studio or other native Windows compiler.

mingw (using gcc) is a native Windows compiler (it goes directly
through the Win32 API, except for the portability wrappers in git
itself).

> A GIT that runs natively on Windows, using Windows paths, etc

The MSYS/mingw port of git does run natively on Windows. I haven't
used it recently (I have switched to using Linux), so I don't know
about how well it copes with Windows paths.

If you have any issues with msysgit (or git on Windows in general) in
regard to functionality (e.g. ".gitignore does not work with Windows
paths"), I would suggest raising these issues. Problems that are not
reported cannot be fixed.

- Reece

> Aaron
>
> 2009/6/12 Reece Dunn <msclrhd@googlemail.com>
>>
>> 2009/6/12 Aaron Gray <aaronngray.lists@googlemail.com>:
>> > Is there going to be a native Windows implementation of GIT ?
>> >
>> > i.e. not MSYS or Cygwin based.
>> >
>> > Many thanks in advance,
>>
>> Cygwin is an adapter layer that maps posix calls to the Windows Win32
>> API, so is not a native implementation.
>>
>> MSYS uses the MinGW (gcc) compiler uses the native Windows Win32 API,
>> so the MSYS version *is* native.
>>
>> Unless by native you mean using Visual Studio?
>>
>> - Reece
