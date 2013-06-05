From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 10/15] for-each-ref: introduce format specifier %>(*) and %<(*)
Date: Wed, 5 Jun 2013 17:15:30 +0700
Message-ID: <CACsJy8Bm5tmyUO_e2Uus3RuyOUphyrJOT955T646BdFT060UBA@mail.gmail.com>
References: <1370349337-20938-1-git-send-email-artagnon@gmail.com>
 <1370349337-20938-11-git-send-email-artagnon@gmail.com> <CACsJy8A2h0pjZ759NpByrEJYzg3ETyDkUGTptC-FFkeZCpGSbQ@mail.gmail.com>
 <CALkWK0=9X6QhCOPfV6Gq31VVccyDoO3ciPxG+2kqpgL2foiQSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 12:16:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkAlE-0005aK-6h
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 12:16:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab3FEKQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 06:16:03 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:55170 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751904Ab3FEKQB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 06:16:01 -0400
Received: by mail-ob0-f172.google.com with SMTP id wo10so2269247obc.31
        for <git@vger.kernel.org>; Wed, 05 Jun 2013 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1QiKHB1dAg8ly1fgzKSK/L5KVbm9vnECux9DywRlTbA=;
        b=tRJT5Q99amuMqpBut3u6uomiqdPuzajs9ZiFUMJrBCn3hrNSAQzf2VcBnooDl9zr8V
         1QmhBWnlmhPm2UmCtrCAGO62COsOwmZVrNDaRl5Nc9lKY24EiAD0Y123MDa8XRnNDcZR
         i1nBzPOGeJj0w17dwfe9bI4YKEcF98pUzi5uq3QuTFZF5Wa1VZccsVfPXdAQzZzLMm4y
         NIrjAxJylskcSQDKEwbB/h5fjfTiHk0uT8qW5WXP3suOhKabhXd2rUkDfZ8jfCeYVwlf
         JC3cw33IAdkWKkif3vfkapTQkJFGOEYwJqixaCIUe1tpnBIzVMmirPMWyXlZ1nuLCzxW
         ElTg==
X-Received: by 10.182.118.226 with SMTP id kp2mr14100141obb.48.1370427360745;
 Wed, 05 Jun 2013 03:16:00 -0700 (PDT)
Received: by 10.76.171.199 with HTTP; Wed, 5 Jun 2013 03:15:30 -0700 (PDT)
In-Reply-To: <CALkWK0=9X6QhCOPfV6Gq31VVccyDoO3ciPxG+2kqpgL2foiQSw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226444>

On Wed, Jun 5, 2013 at 3:14 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Duy Nguyen wrote:
>> I mentioned it before and I do it again. This is not optimal.
>
> Yeah, I'll attempt to fix this, but it's not urgent.

Agreed it's not urgent.

>> But I guess it's ok in this
>> shape unless you run this over hundreds of refs.
>
> Oh, you can run over a hundred refs just fine, for scripting purposes;
> but why would you want to run over a hundred refs with a pretty that
> includes %>(*) or %<(*)?

Good point. "git for-each-ref|wc -l" on my git repo says I have 673
refs. A naive use for-each-ref --pretty without any ref patterns could
happen. But I guess people will quickly learn to limit the ref
selection soon after doing that :-)
--
Duy
