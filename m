From: John Szakmeister <john@szakmeister.net>
Subject: Re: [PATCH 0/1] Make libintl in libc detection more robust
Date: Mon, 20 Feb 2012 08:40:55 -0500
Message-ID: <CAEBDL5WzYFWdnF=pqHq3wc3GRU-pxS6=1Xw8LP=cogck8wYAAg@mail.gmail.com>
References: <1329593884-9999-1-git-send-email-john@szakmeister.net>
	<7vd399nbt2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 14:41:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzTUE-00051X-0h
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 14:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731Ab2BTNk4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Feb 2012 08:40:56 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61085 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291Ab2BTNkz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Feb 2012 08:40:55 -0500
Received: by iacb35 with SMTP id b35so7513903iac.19
        for <git@vger.kernel.org>; Mon, 20 Feb 2012 05:40:55 -0800 (PST)
Received-SPF: pass (google.com: domain of jszakmeister@gmail.com designates 10.50.168.99 as permitted sender) client-ip=10.50.168.99;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jszakmeister@gmail.com designates 10.50.168.99 as permitted sender) smtp.mail=jszakmeister@gmail.com; dkim=pass header.i=jszakmeister@gmail.com
Received: from mr.google.com ([10.50.168.99])
        by 10.50.168.99 with SMTP id zv3mr9690003igb.21.1329745255585 (num_hops = 1);
        Mon, 20 Feb 2012 05:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JmTuQvABihiwT6JTXBZY8TtOU8ponVakp5fW2ySLitQ=;
        b=oLkYuvHNct/lVWUKFzMPs5jAYWWSrD/BlvK835bL5XbKu7Lz2o8QcXIr+JQPJWn05I
         /xRpaN1TX3r/WVHQljVmIYCWZuasXfIhjZVFbS7O0KuhSYoxx9BcGVAOjgxki1TrKQln
         8JvUDnAa9s9tUfYG4CP9gmK5Sizu7tR3KfG18=
Received: by 10.50.168.99 with SMTP id zv3mr7867826igb.21.1329745255368; Mon,
 20 Feb 2012 05:40:55 -0800 (PST)
Received: by 10.50.40.130 with HTTP; Mon, 20 Feb 2012 05:40:55 -0800 (PST)
In-Reply-To: <7vd399nbt2.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: xhUowfB4W5cojmqc7d2HaSdKXuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191066>

On Mon, Feb 20, 2012 at 3:34 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> John Szakmeister <john@szakmeister.net> writes:
>
>> This is my first time submitting a patch to git. =C2=A0I hope I've d=
one
>> things correctly!
>
> Looks good, except for the subject line that would have been better t=
o say
> something like:
>
> =C2=A0 =C2=A0configure: don't use -lintl when there is no gettext sup=
port

You're right, that's much better.  I'll keep your feedback in mind for
next time.

> I'll tweak the log message and queue.

Thanks Junio!

-John
