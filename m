From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/8] cherry-pick: add --skip-empty option
Date: Tue, 4 Jun 2013 12:40:14 -0500
Message-ID: <CAMP44s2_Xr4bymmDezTF8BMiMKQZFpNuxXpFZd_TGJ3BkJWdGw@mail.gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
	<1369799788-24803-4-git-send-email-felipe.contreras@gmail.com>
	<7vr4gjdomk.fsf@alter.siamese.dyndns.org>
	<CAMP44s1GQ2iwwscx4Sx1cxK0U6yWWYvOJqDk_FO_GkFcNKREYw@mail.gmail.com>
	<7vehcidg1i.fsf@alter.siamese.dyndns.org>
	<CAMP44s2DvtiT6hi-RoPt_bVdGr01S367usz=089E1Ht+Bvh-tA@mail.gmail.com>
	<7vbo7l93t6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 04 19:40:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjvDa-00089S-81
	for gcvg-git-2@plane.gmane.org; Tue, 04 Jun 2013 19:40:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609Ab3FDRkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 13:40:18 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:40944 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783Ab3FDRkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 13:40:16 -0400
Received: by mail-lb0-f176.google.com with SMTP id z5so960605lbh.21
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 10:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=x8WoHucivLvlQ/L/8ohaUVIcyl2wlMeIbeiVq5TmlL0=;
        b=a9gL5/GruD8VeQklxkjxQUlUT9AFDi2gGVQF8ETvDPGleKoqL0OILjlrsf5wd8dimw
         J+K5kZ60AsFrV/ikVF68Dho64A3rfgQeU7DocS6kFDQCqalPQDUMtEyMvW+b1xkeY7oF
         tCVPunm7eRLhkrrXiCVDeWubOufr9a6Pj8g0Fxjn9+asje6OgqaYQu1BXO28MyA6A40v
         PBEoHdLyc+DyLhS7FJLNcR1R7/PJjp2eEiJsLywjYUEBDjcAnEKCvjv+FJ1fVN8Y9/Vx
         NOwoNGivqE6Ec0Jp7mFDK7sseyBqXaWoO+Rf3kRG7CVnWhyxcuq45JdDGNUQRn6Y3R5W
         UABA==
X-Received: by 10.152.26.137 with SMTP id l9mr13739875lag.2.1370367614600;
 Tue, 04 Jun 2013 10:40:14 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Tue, 4 Jun 2013 10:40:14 -0700 (PDT)
In-Reply-To: <7vbo7l93t6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226384>

On Tue, Jun 4, 2013 at 12:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> I think just "Skip commits that are or become empty" without saying
>>> "Instead of failing," is fine, too.
>>
>> I think "Instead of failing" makes perfect sense, because it's not our
>> job to describe what other options do,...
>> ...
>> simply explain what this option
>> do.
>
> Which means "Skip commits" and nothing else.  Saying "Instead of
> failing" explains what would happen if you ran the command without
> any option,

Which *BY FAR* the most widely use-case of cherry-pick. What? 99% of the time?

> which is entirely irrelevant,

It's totally and completely relevant. It couldn't be more relevant.

> We share the same "the --skip-empty option does not have anything to
> do with the --allow-empty option, and we do not have to say anything
> about what happens when the command is run with that unrelated
> option".

You didn't answer, what happens when you run --skip-empty and --allow-empty?

-- 
Felipe Contreras
