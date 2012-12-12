From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Fwd: possible Improving diff algoritm
Date: Thu, 13 Dec 2012 09:34:41 +1100
Message-ID: <CAH5451=4dqqMnQa-R6O4ZrHOPSpHU9joWqf2UuOkbLtU9f8bkQ@mail.gmail.com>
References: <CAO54GHC4AXQO1MbU2qXMdcDO5mtUFhrXfXND5evc93kQhNfCrw@mail.gmail.com>
 <CAO54GHD3C2RKUvE5jK_XOCVbbDuE_c5xfe28rOL+DaE5anL-Wg@mail.gmail.com>
 <7vvcc73yzh.fsf@alter.siamese.dyndns.org> <CANv4PNm45xGBn2veKi1o0wB4K9NgsbtCsiymHNO4xbCDpJ5tDg@mail.gmail.com>
 <7vpq2f2az4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Morten Welinder <mwelinder@gmail.com>, Kevin <ikke@ikke.info>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 23:35:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tiute-0007cT-Bt
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 23:35:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755638Ab2LLWfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 17:35:03 -0500
Received: from mail-qa0-f46.google.com ([209.85.216.46]:36146 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755582Ab2LLWfB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 17:35:01 -0500
Received: by mail-qa0-f46.google.com with SMTP id r4so5313482qaq.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 14:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cJCmkhUjaRzZFsl9CTg/4GerczJCWRNarE88WeHbgBg=;
        b=nc9IWYpPI6YjRwEWLV+StP8fYIg8T9jb8XoVbea03WfmXMMiNWenJ4q3f4X4XDrXRe
         zMp62diAShze7jEJi2DRlCH6uxpEpGsK/0ioB4DDl5PJ+k712Y3Ymdry9RCra4l+r80K
         MfcLwjS59wTRfcBlBib9hka0XcSR2nLsSDT6DAD/ncS6KbUYKa54AgEDsaaqhXB2LSLv
         lnbJv5O8WtL8JkTWhUNKGdJ0u8DNwaXRvuf7fxhfLXHlHvCidKSitbIwKVWza8/tca7W
         TKulfvLAlSuxY/ke4GFXMwnq8o95xslgH1tMdMQ2dwrBhVuTHXhGt5GBecdgJ26+ylBi
         16/Q==
Received: by 10.49.48.104 with SMTP id k8mr6153243qen.49.1355351701103; Wed,
 12 Dec 2012 14:35:01 -0800 (PST)
Received: by 10.49.14.3 with HTTP; Wed, 12 Dec 2012 14:34:41 -0800 (PST)
In-Reply-To: <7vpq2f2az4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211404>

On 13 December 2012 08:53, Junio C Hamano <gitster@pobox.com> wrote:
> The output being "a correct patch" is not the only thing we need to
> consider, though, as I mentioned in another response to Kevin
> regarding the "consequences".

The main benefit of picking a more 'natural' diff is a usability one.
I know that when a chunk begins and ends one line after the logical
break point (typically with braces in my experience) mentally parsing
the diff becomes significantly harder. If there was a way to teach git
where it should try and break out a chunk (potentially per filetype?)
this is a good thing for readability, and I think would outweigh any
temporary pain with regards to cached rerere and diff data.

Regards,

Andrew Ardill
