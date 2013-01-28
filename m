From: =?UTF-8?B?0JDQvdC00YDQtdC5INCR0LDRgNCw0L3QvtCy?= 
	<admin@andrej-andb.ru>
Subject: Re: [PATCH] remove protocol from gravatar and picon links for clear
 if Gitweb is being called through a secure server
Date: Tue, 29 Jan 2013 06:43:51 +0700
Message-ID: <CAJjU7bSF7if6BEuUooW_TOLV0gdA5sCeJqEAeQxfSTMhB+qXEg@mail.gmail.com>
References: <1359400490-16449-1-git-send-email-admin@andrej-andb.ru>
	<20130128205834.GC7759@google.com>
	<7vfw1lug6f.fsf@alter.siamese.dyndns.org>
	<20130128221026.GE7759@google.com>
	<7v7gmxuekl.fsf@alter.siamese.dyndns.org>
	<CAJjU7bQtgaV1XBeeGnuwtz8m3bDtmRYxQE-QasWkoGHNb_NPjQ@mail.gmail.com>
	<7v38xkvrbc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 00:44:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzyN4-0003O0-Jr
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 00:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533Ab3A1Xnx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2013 18:43:53 -0500
Received: from mail-ob0-f175.google.com ([209.85.214.175]:37324 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751927Ab3A1Xnw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2013 18:43:52 -0500
Received: by mail-ob0-f175.google.com with SMTP id uz6so3424566obc.34
        for <git@vger.kernel.org>; Mon, 28 Jan 2013 15:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=andrej-andb.ru; s=google;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Omozd3UIQ77lRQfCQU/hRSn6ejQlSc5Saz5Yjs1laJk=;
        b=HO7FG75SQqshqsZNu2lxL3+QsQbqkaXhqgTQV8y2y49LbK25ufggFXgF2JgJbTDLeB
         /Jqje0gStIk+JlPtVaMf81+FhbInX8J3RNKUKVqmwjrjgblXnLQfb+ULoxWB8BWfce8n
         iYdmr9qyFFGnYJCha1g9G6W1uoR3JpTHt2iG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=Omozd3UIQ77lRQfCQU/hRSn6ejQlSc5Saz5Yjs1laJk=;
        b=dv55LOrniENYhB3jP2l2JK/IfkXmIttXx5iqEPq0D3rHBim0AEL0j8oxgvCCu14GnP
         so+76b/RVdQXDpDKVw10Oa+Oi4xQ1mowBYCdOCV6t8zDOzOueieuLu1e8zblfAaImi4m
         mfdkrFgHMU6+aqSZ10FGqo8Pd41Az+YE2MkyVIotBZPDY4EJKCfAVaA5fLf2gSeSoBa1
         UXLJ9N8a3wpQMGBjKQR6Z9QGDM+F+7I7hGw31/DkjULlFVxBphSQEobcfVymuhg3eAUe
         ZJ1KQ0de+UMrTeFew+kBxIh76rz+lRKzydY6y1xuWYqFHmtPG4Cr/8iu2QCm5HK7eM70
         ai7g==
X-Received: by 10.60.32.33 with SMTP id f1mr13082925oei.122.1359416631840;
 Mon, 28 Jan 2013 15:43:51 -0800 (PST)
Received: by 10.76.9.35 with HTTP; Mon, 28 Jan 2013 15:43:51 -0800 (PST)
X-Originating-IP: [90.188.9.189]
In-Reply-To: <7v38xkvrbc.fsf@alter.siamese.dyndns.org>
X-Gm-Message-State: ALoCoQkcnCpYOhC/xL+bmviemjARoxUu+3tUNaNAauxiAVJhp039GAQJxI3vWuxkkegL2+lVNlTS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214887>

re sended. Very big thanks for example :D

2013/1/29 Junio C Hamano <gitster@pobox.com>:
> =D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9 =D0=91=D0=B0=D1=80=D0=B0=D0=BD=D0=
=BE=D0=B2  <admin@andrej-andb.ru> writes:
>
>> Or maybe option like:
>> /etc/gitweb.conf:
>> $feature{'ssl'}{'default'} =3D ['allways']; ['auto']; ['none'];
>>
>> but it's hard for me :) i don't know perl
>
> The effect is the same and your original patch is shorter and
> cleaner to see what is going on; as far as the patch text is
> concerned, the original one is just fine.
>
> Except that we wanted a bit more stuff before "---" line.  How about
> something like this?
>
>         Subject: [PATCH] gitweb: refer to picon/gravatar images over =
the same scheme
>
>         The images from picon and gravatar are always used over
>         http://, and browsers give mixed contents warning when
>         gitweb is served over https://.
>
>         Just drop the scheme: part from the URL, so that these
>         external sites are accessed over https:// in such a case.
>
>         Signed-off-by: Your Name <your@addre.ss>
>         ---
>          gitweb/gitweb.perl | 4 ++--
>          1 file changed, 2 insertions(+), 2 deletions(-)
>
>         diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>         ...
>
