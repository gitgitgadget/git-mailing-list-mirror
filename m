From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] build: add default configuration
Date: Sat, 21 Sep 2013 14:02:57 -0500
Message-ID: <CAMP44s34=HW=C5Fex6xabyQ=Zv4pg7p8RddMEOSVZqudgUkQ_A@mail.gmail.com>
References: <1379764036-3782-1-git-send-email-felipe.contreras@gmail.com>
	<523DEC3F.9080807@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Sep 21 21:03:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VNSSN-000528-84
	for gcvg-git-2@plane.gmane.org; Sat, 21 Sep 2013 21:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab3IUTC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Sep 2013 15:02:59 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:43102 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398Ab3IUTC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Sep 2013 15:02:58 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so1609341lbh.9
        for <git@vger.kernel.org>; Sat, 21 Sep 2013 12:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GaLOcIVXOtmHJeDoBsdTCXtx5ObzPhPZu5Sg7rmgGJs=;
        b=AXjmGxkUIxnQ5wyTTewNPQWzQElsZpyiJrRpQd6iQ2wRoazkrkleR4TYafpw+7+3yE
         /yH17WFMVARda83z43nCqMJoi40oWChdMrfjScimx9zCQcvtlp2+SZNfRrsuJNcWtxOL
         qwncrEyQgxiV9cR7Xc0VDJJJrM3GfjY8DQDgfCdAGo0P9/k1IJLamcYOTZn1OL+yCiiI
         0Ys5/Ao6o4+Wy5TqWvJr0E8geaqJlitR6aLdTaFuaKvjV2NiUv4ah547gRXJFaL+KiCD
         q2J8JS1zqQrDWV6kNNe+UjfSoAE7W6J9S/uVD/SRwcK+JpH/xsm/Li0zyJWWdHcoJDxx
         fIuQ==
X-Received: by 10.112.0.242 with SMTP id 18mr11739944lbh.18.1379790177487;
 Sat, 21 Sep 2013 12:02:57 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Sat, 21 Sep 2013 12:02:57 -0700 (PDT)
In-Reply-To: <523DEC3F.9080807@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235143>

On Sat, Sep 21, 2013 at 1:58 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 21.09.2013 13:47, schrieb Felipe Contreras:
>> diff --git a/Makefile b/Makefile
>> index 3588ca1..18081bf 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -1010,7 +1010,7 @@ ifndef sysconfdir
>>  ifeq ($(prefix),/usr)
>>  sysconfdir = /etc
>>  else
>> -sysconfdir = etc
>> +sysconfdir = $(prefix)/etc
>
> Not good: There is a reason why this is a relative path. Please dig the
> history, it's pretty clear.

It's pretty clear it's *not* a relative path.

What is relative about 'sysconfdir = /etc'?

-- 
Felipe Contreras
