From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 12/18] revert: Save command-line options for continuing operation
Date: Wed, 27 Jul 2011 21:19:50 +0530
Message-ID: <CALkWK0=y4qzEOgvn+1WfHuMeCmx8=bgbUKSPQiT7Eram9xiHug@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-13-git-send-email-artagnon@gmail.com> <20110727050515.GH18470@elie>
 <CALkWK0=5drVxLe4SAVLem3cpWCB=Eg3dTFQGhLKFD+Z77RHohA@mail.gmail.com> <20110727142116.GB24785@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 17:50:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm6NE-0001yL-Pd
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 17:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab1G0PuM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Jul 2011 11:50:12 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55012 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751491Ab1G0PuL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2011 11:50:11 -0400
Received: by wwe5 with SMTP id 5so1555343wwe.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 08:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GEnvW+vjmTufA/rPf/QRt1T1TT7ehGqZ8WTJdIHCthg=;
        b=G/wFQHoE0lfUMWyECTs/OQF/rpMPtTPen9ulT+/mDh0DwEIeA9ZJlaGS1U9q/Mg0/N
         YPJy8wNaYGtagzz7Uariu6w0y5TWTuF7156z0hcr+7PH4eW3PLcR5++bAvZrjW5QMuOJ
         HU79cg86wgW+6p5r0eOb1wl4H8+NpBLPDzpjs=
Received: by 10.216.9.134 with SMTP id 6mr22500wet.111.1311781810071; Wed, 27
 Jul 2011 08:50:10 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Wed, 27 Jul 2011 08:49:50 -0700 (PDT)
In-Reply-To: <20110727142116.GB24785@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177976>

Hi again,

Jonathan Nieder writes:
> Ramkumar Ramachandra wrote:
>> Jonathan Nieder writes:
>>> It would be nice if some
>>> day the config parser could learn to treat dashes as insignificant,
>>> just like it already treats case distinctions as insignificant.
>>
>> Is the documentation out of date? I can't find any special handling
>> for `-` in the code either. =C2=A0What are you talking about?
>
> "It would be nice if some day the config parser could learn" implies
> "The config parser does not behave like this", no?

Ah, I misread that.  Sorry.

> One problem with dashes in names of real configuration variables is
> that most git multi-word configuration variables are already named
> using InsignificantBumpyCaps, which means the user does not have to
> remember where the word breaks are as language drifts (e.g., is it a
> "file name" or a "filename"?). =C2=A0A convention of using dashes to
> separate words would probably have been about as good, while
> inconsistently sometimes using dashes and sometimes not would be far
> worse.

Hm, case insensitivity is nice, but ignoring dashes may not be such a
good idea.  I suppose we can use them where it's totally sensible and
unambiguous like in this case (command-line options).

> Of course, the .git/sequencer/args file is not gitconfig, and changes
> in its format are not as hard (since unlike for gitconfig, any
> backward-compatibility synonyms probably do not need to be mentioned
> in documentation). =C2=A0So I am not too worried and this was mostly =
an
> aside.

Cool.  Thanks.

-- Ram
