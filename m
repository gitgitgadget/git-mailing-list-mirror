From: Joshua Juran <jjuran@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Sat, 7 Aug 2010 21:11:30 -0700
Message-ID: <DEBA236E-B6E8-435F-AC8C-1FC4AC69AD3C@gmail.com>
References: <i372v0$3np$1@dough.gmane.org>	<AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com>	<4C599781.2020603@gmail.com>	<4C5B2F2E.4050709@gmail.com>	<AANLkTikWc0rKV9rQsLfmZvhdqAuvATmbur2ZqQ4Xu7uo@mail.gmail.com> <AANLkTikJP2d5_pA+RcQeToE+RGW0oBhcZyghLfqDoJ8E@mail.gmail.com> <fGxsOXuy8990l2eOzf2k3cXF066OSIj50KBNkGGWXJhFoVG_B5MV_Q@cipher.nrlssc.navy.mil> <4C5E28AF.7010809@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	git@vger.kernel.org,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
To: "Joel C. Salomon" <joelcsalomon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 08 06:11:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhxEk-0000q3-C1
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 06:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719Ab0HHELe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 00:11:34 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:34042 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab0HHELd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 00:11:33 -0400
Received: by pvg2 with SMTP id 2so405136pvg.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 21:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=w1mvDAA/mnaEpeKTmkBdCLoxxUzlN3CImZvBpe1YgzY=;
        b=kKl6QIRRl3TUIKZJakRnVLAKp1MAdf60g3ajHHWgnB9yiLHfVSZezeONuLzRBYQyEf
         kl42y59i03jcYIMAE2GXSrovESOYoJpxnQr7O9KwecsPNhZZsA6zOdWCRmYFDFdJL9Oo
         rXPDYtq0/V5A/jp1YXDirmgZtUhI0jcxYtolc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=AbBsyXOynmP7wtQA1NkTPkqXs+hAbFNxF3CHASy4XKtoNftmjqUKA4/UtIydNibLtr
         rAbpQ3HzFVfZgnKMnqkMfi4ZVdae7sJqNBcp5cGtBI9afa+CZyHYua3Ul7q0Aq+GrSkH
         /Jva3G0i4Q8f5d2L0gjlx/lZgapQzYYB3J34o=
Received: by 10.142.229.10 with SMTP id b10mr8633923wfh.149.1281240693205;
        Sat, 07 Aug 2010 21:11:33 -0700 (PDT)
Received: from zaphod.jjuran.dyndns.org (c-71-227-175-60.hsd1.wa.comcast.net [71.227.175.60])
        by mx.google.com with ESMTPS id z1sm4249497wfd.15.2010.08.07.21.11.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Aug 2010 21:11:32 -0700 (PDT)
In-Reply-To: <4C5E28AF.7010809@gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152883>

On Aug 7, 2010, at 8:46 PM, Joel C. Salomon wrote:

> On 08/06/2010 12:44 PM, Brandon Casey wrote:
>> Joel C. Salomon wrote:
>>> Cool, it works!  (The 13:00 should have been 12:00, but there's some
>>> DST weirdness at work.)
>>
>> Something other than the fact that -0400 should be -0500?
>
> No, that's probably it; I'd overlooked the time-zone specifier.   
> Thanks.

Daylight Saving Time wasn't adopted in the US until 1918, so all  
Eastern times before then should be displayed as -500, regardless of  
the time of year.

http://en.wikipedia.org/wiki/Daylight_saving_time

Josh
