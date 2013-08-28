From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Wed, 28 Aug 2013 15:48:34 -0500
Message-ID: <CAMP44s2bu9gUE=McYq1prhjC3O2CRj1W_Yc+-CjTkk6Gc3JFTw@mail.gmail.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
	<1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
	<vpqhae97f8j.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Aug 28 22:48:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEmfQ-0005rt-6H
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 22:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab3H1Usg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Aug 2013 16:48:36 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:51250 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753290Ab3H1Usf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Aug 2013 16:48:35 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so5091259lab.8
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 13:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=yKekVT1490wotAClpTWGbHNUYun8lZ4EpLMFRfzHsqU=;
        b=Q01XoYUbSReU1IuOSmY+/0TcuJnWYN6+cxxQ7QnBRj3o0XnnbmTBEQp+knJzWzCtxc
         Muzo9envaJsDihgZdRI8GTR7YF0UwgSPfU1FfZXc7+resw+2wUEZoMFVzz+dxm6ucxCF
         Rs7O4F4AurVcBFW5Ps1MqXRayyT4BBlFzAKzd4fJf72qCjPBzbbRWHw3czI1nOlyF6H7
         VRJGaIFtppr+Q0TPD0ohDHH9GmEomG3XZe/xPPRQ4T9FqTps728ybCib2UucO6QpJvCh
         TFF3fxPueHlR/CLIKxQhbT/ATiWvJMwZL/67PyGfWG3h02AbDbbgRxwVh/KUUwTHrhar
         fr0g==
X-Received: by 10.152.121.65 with SMTP id li1mr3261879lab.31.1377722914214;
 Wed, 28 Aug 2013 13:48:34 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Wed, 28 Aug 2013 13:48:34 -0700 (PDT)
In-Reply-To: <vpqhae97f8j.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233211>

On Wed, Aug 28, 2013 at 3:05 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> +     echo greg >> content &&
>> +     git add content &&
>> +     git commit -m one
>
> test_commit would make it shorter.

And it would make it inconsistent with the rest of the script.

>> +     bzr log | grep "^committer: " > ../actual
>> +     ) &&
>> +
>> +     echo "committer: Gr=C3=A9goire <committer@example.com>" > expe=
cted &&
>
> Git's source code usually says >../actual and >expected, without spac=
e
> after '>'.

Not that usually:

% git grep ' > ' t/*.sh | wc -l
1943

--=20
=46elipe Contreras
