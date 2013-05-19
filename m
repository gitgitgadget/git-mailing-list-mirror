From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/9] for-each-ref: add %(tracking[:upstream]) for tracking info
Date: Sun, 19 May 2013 06:38:51 -0500
Message-ID: <CAMP44s1a5JH1T-ckvmFomoKKhFCE61CQ79YFxi4RiQLqeqhgTw@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
	<1368959235-27777-6-git-send-email-pclouds@gmail.com>
	<CALkWK0k5qM3CZoivC1GJaBfwxWwvpDVtU7mHmm3feiLKr4kxXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 13:38:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue1x3-0004Em-Dz
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 13:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155Ab3ESLix convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 May 2013 07:38:53 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:39363 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970Ab3ESLix convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 07:38:53 -0400
Received: by mail-la0-f54.google.com with SMTP id eg20so2976020lab.27
        for <git@vger.kernel.org>; Sun, 19 May 2013 04:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=iQjoa++JCRCUhKS9/vpeQLOZVWkyluVNVra1KlaK2QY=;
        b=Cc3xI8qRwNWNzZh1gDx0dWr82gl/A3HFHRA0cBp4ajmZ+jkagvc8d+4kuElUhVS/f5
         OFCu/sWQQRq35OVuGkUBSm1YirdOxJ67jHq2U82Y+ILEuruItJrJ/Nl5MB/aIiX91hvs
         RYd2TH++6h8hXQdpnBsQJkQgIuSuYdesQMyV/RXXPYkUTjtKFfGyKBEq7CMoN5J1OtRz
         /NuyOiVITQs0lBm+MS4Wm27VV1IF0cMaAUWdZjKsu/P5LsbFqAM6tgQg0oxJsUVpFrVw
         AQU7B7Pz4luX1NDDGj2t50T5dFTaXqFq4f4FlebK5q/pVyGw812wRYfjomfvqE5c9cB4
         KLHA==
X-Received: by 10.112.125.130 with SMTP id mq2mr25524334lbb.103.1368963531574;
 Sun, 19 May 2013 04:38:51 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sun, 19 May 2013 04:38:51 -0700 (PDT)
In-Reply-To: <CALkWK0k5qM3CZoivC1GJaBfwxWwvpDVtU7mHmm3feiLKr4kxXw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224856>

On Sun, May 19, 2013 at 6:18 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>> index 498d703..b10d48a 100644
>> --- a/builtin/for-each-ref.c
>> +++ b/builtin/for-each-ref.c
>> @@ -76,6 +76,8 @@ static struct {
>>         { "symref" },
>>         { "flag" },
>>         { "current" },
>> +       { "tracking" },
>> +       { "tracking:upstream" },
>>  };
>
> You just threw the upstream atom (and "upstream:short") out the windo=
w :|

Huh? Those don't print the tracking information, do they?
"tracking:upstream" prints the upstream, but other things as well I
suppose.

--=20
=46elipe Contreras
