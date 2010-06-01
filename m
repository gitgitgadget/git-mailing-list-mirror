From: Sylvia Liu <sylviaonlyone@gmail.com>
Subject: Re: HELP: cannot clone a repository via http_proxy on FC13
Date: Tue, 1 Jun 2010 12:30:14 +0800
Message-ID: <AANLkTinSTJiUdtWbidlnUkJ2Gh6KczaSu56p3cwSgv5k@mail.gmail.com>
References: <AANLkTimefBKp5So03RKaZRqQXePO1KY6EgMRxN0zsf8M@mail.gmail.com>
	<AANLkTinyKoH4QiTnIbBQ60sMNZHKqtYejk-t2ygj9naK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 01 06:30:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJJ7U-0007VM-Uu
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 06:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091Ab0FAEaQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 00:30:16 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:43785 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab0FAEaP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 00:30:15 -0400
Received: by pwj2 with SMTP id 2so961556pwj.19
        for <git@vger.kernel.org>; Mon, 31 May 2010 21:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sZ3Ivtg4xPkBnhRpY/GqzQJNuY7FLixKFsaCg4m8rkY=;
        b=FBy8qXkIVM55B1XinBiUPBAQ811CmrbUrjrGPOo+TRlhjevqfAzdszoUbrGed4QwlX
         opFERWBToigDoaLQ7iDkjMylJmFdnmNSo7coFtZfk3eupOUlJ43glFhhUEy3XRMcFr+X
         rcPgFqXdGeveLk27bRj+xAhIIWFTgYmo1nJuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=W4OBu0hnltsoNx+HZ4guxZz1mTwoPhH0pb0xPOL2lPaUFjzXDfRHil5igqixDrNnyQ
         XvVNk1FixDUqL/hskvAqcLss/t466h9w93gsuhe+49rThDDW3Ku9p+4NDtWP+f5QQsbN
         TQP2uvsXbkiv33NNzI6h9p2ulbx1Z4DqEyXWs=
Received: by 10.143.153.9 with SMTP id f9mr3633589wfo.29.1275366614548; Mon, 
	31 May 2010 21:30:14 -0700 (PDT)
Received: by 10.143.40.20 with HTTP; Mon, 31 May 2010 21:30:14 -0700 (PDT)
In-Reply-To: <AANLkTinyKoH4QiTnIbBQ60sMNZHKqtYejk-t2ygj9naK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148075>

Hi Ray,

Thanks a lot.
Seems the "sudo" IS the problem, indeed.
Without the sudo, it is working.

But on Ubuntu, I use sudo all the times, and it still works. Isn't it s=
trange?
And as I remembered, while I using FC12 before, it didn't work
neither; even without a sudo....

Anyway, it is working. Thanks.

On Tue, Jun 1, 2010 at 12:03 PM, Tay Ray Chuan <rctay89@gmail.com> wrot=
e:
> Hi,
>
> On Tue, Jun 1, 2010 at 11:30 AM, Sylvia Liu <sylviaonlyone@gmail.com>=
 wrote:
>> I tried this command:
>> =C2=A0 sudo git clone
>> http://git.gitorious.org/meego-developer-tools/image-creator.git
>
> Probably not related, but why sudo?
>
