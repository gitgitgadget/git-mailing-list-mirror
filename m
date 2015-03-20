From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] Documentation: Add target to build PDF manpages
Date: Fri, 20 Mar 2015 15:19:04 -0700
Message-ID: <CAGZ79kaDnRiUQ6=3gVvsPrkSzkNbACRvgQBSo8gmpRZ8bka84g@mail.gmail.com>
References: <1426850584-9951-1-git-send-email-thosch97@gmail.com>
	<CAGZ79ka7tPA17Y-vPPp5W_4-0UMnHMfM9+eQ8jc4eu23FpM2ug@mail.gmail.com>
	<xmqq4mpfe7xm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Schneider <thosch97@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 23:19:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ5G3-0006fB-EA
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 23:19:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbbCTWTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 18:19:07 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:35223 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090AbbCTWTF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 18:19:05 -0400
Received: by igcau2 with SMTP id au2so3741268igc.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 15:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3JzpZlIjmwOckx5suimbvPSSQ/OhEPlJcy1EVHvvIkk=;
        b=CfLZfWPAJ3z5nHHddNQ0hIsWWp+8tAXB6IsviqBhLTsi9rhNPGZhqRNPviJ9OqdGP6
         JjQQ66CGujdLC4N0z2i0vsl7Yt6yjWTXfqkiBMh6EfwIqcUlLnsVstu0Cou7qKhsJyiy
         1OBn6yCII+1t2oK9ehpiF1mZw3efr9Fqgd8nhRuAtzJMjK8/Gr2jU/Q461fWX68ev0Ym
         DhU7dGnPWAo1TmbnBgJgNkLUrYCwVk5onrSBn9x9uYmkFO53+eZx47S0RDAxupsTSBbC
         C9NV2pM1Jv14F/rFRWt9Bl3Spvhix/ZO6aJWd//n518FjK2/emcTVrju+d9DI2wp+Tqp
         ny8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=3JzpZlIjmwOckx5suimbvPSSQ/OhEPlJcy1EVHvvIkk=;
        b=BFKo5sPjpD2+w5J34hvkAAoiTDoFq3HlBv7+UKtNyTeRW+bE9ftDjdpaZKqBl6g5lk
         EmPhFTCR9sS3DmqzKM63lpJTdM3wPJQVScuiVBFeITsvTcET3n3mc6Gj79My0bPuyeaX
         EeAxSuGc2R5w9q4NNvhfEtIq3LLrMy/1ry0fdi61346015mEi1Wkc7ftByEljIN9rNRu
         nuoQuM16I1dqyrqJeSpUKF0eFxjjsK6mR2SSNYyi4ykumxL8oLQnVq4prZ6y3LHnuxdC
         D5BW9x8A0bbG7IinEohdj57HDKlMl8jWAAQov19kzkX7CeLUElv4P1AlnDvXBaPyZpLJ
         beKQ==
X-Gm-Message-State: ALoCoQmcD+gTKu21ZqJETqb+IfypMjSmioBBMHcAR7CmVABfJmMtOakGiTsCYvj+Ra3UDGXwMRBR
X-Received: by 10.50.122.5 with SMTP id lo5mr8678563igb.37.1426889944602; Fri,
 20 Mar 2015 15:19:04 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Fri, 20 Mar 2015 15:19:04 -0700 (PDT)
In-Reply-To: <xmqq4mpfe7xm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265975>

On Fri, Mar 20, 2015 at 1:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> ... though how would I read man pages in pdf
>> format? I tried searching the web and all I can find is how
>> to convert the a man page to pdf. So is there a conveniant
>> way to tell `man` to prefer opening pdfs when available?
>
> I presume that "man -Tpdf git.1" is not what you are looking for, as
> that would literally be how you get the manpages in PDF format?

Not quite as that is producing a pdf. So I could do

    man -Tpdf git add >tmpfile && evince tmpfile && rm tmpfile

but that is inconvenient to type, so I'd rather be looking for

   man_or_pdf_when_possible git add

and I could alias man_or_pdf_when_possible to a short name.

>
> Personally, I honestly am not quite sure why anybody wants to
> generate manpages in the PDF format like this patch does, unless
> they are planning to print them on paper, in which case the existing
> manpages (git.1 and friends) or html pages (git.html and friends)
> should be an already available source format.

This is what I was wondering about as well and my conclusion was
it is nicer than the output of man itself to look at, so there must be an
obvious command to read pdf instead of man.

Thomas referencing reading the man page offline, made me wonder
why you wouldn't read the man pages itself as they can also be
carried around offline. But the striking point is "on an iPad", which
doesn't offer you the convenience of a shell etc, but pdf is fine to read
there. Also you can add comments to pdfs more easily that html pages
I'd guess.

So the patch makes sense to me now. It's just a use case I'm personally
not interested in for now, but I don't oppose it as is.
