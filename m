From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: German translation errors
Date: Wed, 4 Sep 2013 20:14:31 +0200
Message-ID: <CAN0XMOJ=Mxxq03Oitkhhr63mtu-XvqM30YVNscfPrqH8mYo8mg@mail.gmail.com>
References: <2896292.CgjyIcF3NN@moria>
	<CAN0XMOJn7_c51G=peUKJzNqkQpWu7JQ8Uv2TB+hpvUO1ztPEPw@mail.gmail.com>
	<2330938.lTaCDyZdrQ@gondor>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT <git@vger.kernel.org>
To: Dirk Heinrichs <dirk.heinrichs@altum.de>
X-From: git-owner@vger.kernel.org Wed Sep 04 20:14:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHHbB-0004SC-Cv
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 20:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755712Ab3IDSOd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 14:14:33 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:37740 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752987Ab3IDSOc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 14:14:32 -0400
Received: by mail-we0-f181.google.com with SMTP id p60so756556wes.12
        for <git@vger.kernel.org>; Wed, 04 Sep 2013 11:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=gvxOBZ4zxLoQsGZsPGevuigZ5rbj4o7D9TWrs0Gcs9A=;
        b=J+FLzraAznUO3MKRqh+ki0MZ76qfDdMdsYW/+K1rgNOGH8HdhPDaKtsJjF/UfJy8uX
         VloYlM1rKd+/lK/ecbpfbA/Ss4cFj7ZdOp7kEtp3gYmbWUnFDgPNpzE5vPSXmSYhwhRl
         GFuPY2gCOVTZ2Wrsdov/Gglu5Ku8jRPCxeye4KCCiBWuuECdN3erR520PD8QpMuTQizM
         JlIagX4UjmUIdkicOS/YmtkAsxjQlQOHXMFdLzWNnw981hU416Z7HhG/2vnrP4rj0XDd
         CSJQdRPRJ7H1Yz0FNenbZWUYypUAfXLWIzrU+u5mtHoM0sCcPstBUM67E5U1LS/kL5gp
         M6/A==
X-Received: by 10.180.188.49 with SMTP id fx17mr3114662wic.49.1378318471120;
 Wed, 04 Sep 2013 11:14:31 -0700 (PDT)
Received: by 10.194.169.2 with HTTP; Wed, 4 Sep 2013 11:14:31 -0700 (PDT)
In-Reply-To: <2330938.lTaCDyZdrQ@gondor>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233853>

On Wed, Sep 4, 2013 at 3:20 PM, Dirk Heinrichs <dirk.heinrichs@altum.de> wrote:
> Am Mittwoch, 4. September 2013, 13:11:39 schrieben Sie:
>
>> this is not an error but intention. From Git 1.8.4, the German translation
>> switches from pure German to German+English. For me the most important
>> reasons for that are that terms like "Branch" and "Tag" are well-known
>> SCM/Git terms for many German people, and using "Zweig" and "Marke" could
>> be more confusing than just use the english words.
>
> Ah, OK. I must admit I also use the english words in day-to-day (german)
> conversations. However, in case of tags, when spoken, you have the ability to
> pronounce tag differently (long "a" when you mean day, short "a" for a git
> tag), which is not the case in a written conversation. How about using "neues
> Tag" instead of "neuer Tag"?
>

I've looked at books and blogs to see what others use and both versions are
used. Personally I prefer "der Tag" than "das Tag" because it feels more
natural to me. But I agree that using "das Tag" is less confusing. I'm going
to work on a patch for this.

Thanks,

Ralf

> Bye...
>
>         Dirk
> --
> Dirk Heinrichs <dirk.heinrichs@altum.de>
> Tel: +49 (0)2471 209385 | Mobil: +49 (0)176 34473913
> GPG Public Key C2E467BB | Jabber: dirk.heinrichs@altum.de
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
