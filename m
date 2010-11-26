From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Breaking t1510-repo-setup.sh tests in pu
Date: Fri, 26 Nov 2010 09:45:11 +0700
Message-ID: <AANLkTim1G__J6KAnd+pNmKWwEDTHexUSJU2E7=7WFZmp@mail.gmail.com>
References: <AANLkTim=_0WiphBv-RBhJ2i9rGzXvz8yKcZcm_7pYXFc@mail.gmail.com>
 <AANLkTikvXhKoRg4a0FuyW8cG45b6AM9+NbbHuJQWtb4L@mail.gmail.com> <AANLkTinhgMhrcMtPKL0aOrkeVgo8NE8Sq0fuPuCcbdbq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 26 03:45:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PLoJx-0002dx-Lk
	for gcvg-git-2@lo.gmane.org; Fri, 26 Nov 2010 03:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753208Ab0KZCpo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Nov 2010 21:45:44 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:34086 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006Ab0KZCpn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Nov 2010 21:45:43 -0500
Received: by wwa36 with SMTP id 36so1587730wwa.1
        for <git@vger.kernel.org>; Thu, 25 Nov 2010 18:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=7Rrf9Ijs+sz0YJxRPvkyBMdlQ4HTXOBagxR9sYjEluo=;
        b=mmj6kgV5zbV6rxmr8yrLHuyl9DQVgJKYYKxq5mzBrImujL/+SoV59/at3HwfaphktI
         MdXMMjbYDsqfyt0rKSo9o2yCBbH5kU502mx3eZWTsGMKYyGe0QkZSns8enHwW+eHQ+Ug
         R6y912VYGgmI8h2LSDzMyZyoRMFhQ48Gz4z8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FuoB6qaCFrBSdgK5JsQQODRx9D0hwZWakFPt6AAOTv2vMqr6iqrJXmKufvXvV9VXjL
         Vf67LX6aTSd0+m0CDacfg0q5FVUQM2gC9psuBkJL1r+TlcbQmjWZFabb1mNCMhrwYnIc
         mWzCD97DWycG1TN71LJQzFRycc58h2eTVSRNM=
Received: by 10.216.5.21 with SMTP id 21mr1461736wek.19.1290739541940; Thu, 25
 Nov 2010 18:45:41 -0800 (PST)
Received: by 10.216.21.14 with HTTP; Thu, 25 Nov 2010 18:45:11 -0800 (PST)
In-Reply-To: <AANLkTinhgMhrcMtPKL0aOrkeVgo8NE8Sq0fuPuCcbdbq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162182>

On Fri, Nov 26, 2010 at 8:21 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Nov 25, 2010 at 12:40, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
>> Interesting. That looks like real breakage. I have just run the test=
s
>> on pu (f4b0626). It passed. Can you send me the entire log and
>> /tmp/t1510-trace.log after applying this patch?
>
> Here it is. Hope it's useful.
>

OK it's probably bashisms. I think it will pass if you run it with
bash :-P I'll resend the series later without bash specific
constructs.
--=20
Duy
