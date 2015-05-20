From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v9 3/5] generate-cmdlist: parse common group commands
Date: Wed, 20 May 2015 15:32:38 -0400
Message-ID: <CAPig+cR_sf9Ha_Qwmo92v86rRJqGCX1dQwphTeHVck5YmWmC2g@mail.gmail.com>
References: <1432149781-24596-1-git-send-email-sebastien.guimmara@gmail.com>
	<1432149781-24596-4-git-send-email-sebastien.guimmara@gmail.com>
	<555CE01F.806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?S=C3=A9bastien_Guimmara?= <sebastien.guimmara@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 20 21:32:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv9jP-0007gV-U2
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbbETTcj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2015 15:32:39 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:34826 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505AbbETTcj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2015 15:32:39 -0400
Received: by igbyr2 with SMTP id yr2so111410734igb.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 12:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=f8T9G1xZMTIiITOFJvDEFzDFqE7QGA4GvJVZrQg2IYo=;
        b=o9Y11VLWEivhl+7ilTZJYXYdJLVsGmdv3OduyRigKK91V8Mr6Y5Ion0tsVTaetErlJ
         iS1PNl8jFvVSyjv78ZKHHaX/bTh8Ax492ALyKL5JLsOJwNxeRZQUnlATkQvRwzD4ceJX
         Gf8+TBhpp4H+Q2KRNa41mAFjFodF/GdkAU0pJTmR3QYuzsSRdVXZg/qwzZNxiRxyJ89f
         eBf++CZkgcS08eSxoEBG9FQRTwlNuGZSHUijORpiIsGPWvGm5vzhvG+oZUsclXeCuNSO
         q8heNuVeQ9nJuLVdB95bxoDKRgYgU2fZfzKE5wQuaTfPH2CI8WI1mId9wgNOT79Hd9A0
         jULw==
X-Received: by 10.50.66.234 with SMTP id i10mr28358894igt.22.1432150358648;
 Wed, 20 May 2015 12:32:38 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Wed, 20 May 2015 12:32:38 -0700 (PDT)
In-Reply-To: <555CE01F.806@gmail.com>
X-Google-Sender-Auth: eltVU2nn5b_I79-Yo2674GHwLBk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269506>

On Wed, May 20, 2015 at 3:27 PM, S=C3=A9bastien Guimmara
<sebastien.guimmara@gmail.com> wrote:
> On 05/20/2015 09:22 PM, S=C3=A9bastien Guimmara wrote:
>>
>> From: Eric Sunshine <sunshine@sunshineco.com>
>
> It looks like 'git send-email' got confused with the CC field.
> I'm sorry for that.

Confused in what way? The patch arrived looking sane.
