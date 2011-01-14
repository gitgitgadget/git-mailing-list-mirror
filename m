From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Fri, 14 Jan 2011 10:53:25 +0100
Message-ID: <AANLkTiksAZSi-Yo8yJv5ca9XWWvB3iVQhZOJtTs-F8gk@mail.gmail.com>
References: <AANLkTinMX0yEPvSc-c=96R42SbFZTjW5Mnveuxk3ZHS=@mail.gmail.com>
 <20110112182150.GC31747@sigill.intra.peff.net> <AANLkTimanDRHwoqSj7i9sVCZkze1L3Qp-zFYwTwHAOHX@mail.gmail.com>
 <AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
 <AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
 <AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
 <AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
 <AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
 <AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com> <AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: JT Olds <jtolds@xnet5.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Fri Jan 14 10:54:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdgM2-0004be-MH
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 10:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756984Ab1ANJxr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jan 2011 04:53:47 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:51393 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab1ANJxq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jan 2011 04:53:46 -0500
Received: by fxm20 with SMTP id 20so2578499fxm.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 01:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=JLCt/Kz5rzx3eXMqkzLGkNDxJ7jDGSzzoAHtM+LeND4=;
        b=Cvg6z4whJ+/3I5D5qcKpXnm6gM0p9OzpgCy3YuYa4ma1qSGM5GR4SNTYeEcNuKWHDN
         tQHA9iBxJN1V6CXZDEVZ9PL/pMuY2MXCCqWXPVYjKbFbjntgOv+H52E0vzSEWKLo7++z
         +FbPhjB+yn1mq2tVGZlkzlmDk3MBjonwNHRb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=lfiowvq2Gf07DWZpFeoQH8TMtsZHx9xeqF246vrsipT4+qScRgOHlYBsgA9GV0FvCN
         pt26SCcNyVmMqczgrRgrg9uMXID8V1sDCg2DW6J6pKsyTetKU6bxZnOouD1LXX0tGySY
         2ixPn24k+bLSgjLeZ/Rayphe8wxGfE1FfamME=
Received: by 10.223.83.197 with SMTP id g5mr515159fal.52.1294998825335; Fri,
 14 Jan 2011 01:53:45 -0800 (PST)
Received: by 10.223.79.3 with HTTP; Fri, 14 Jan 2011 01:53:25 -0800 (PST)
In-Reply-To: <AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165087>

(CC'ed Linus, as he wrote mailinfo's sanity-checking)

On Fri, Jan 14, 2011 at 10:24 AM, Tor Arntsen <tor@spacetec.no> wrote:
> On Fri, Jan 14, 2011 at 09:56, Erik Faye-Lund <kusmabite@gmail.com> w=
rote:
>> On Fri, Jan 14, 2011 at 9:45 AM, Tor Arntsen <tor@spacetec.no> wrote=
:
>>> I think I've mentioned this before in another thread, but first/las=
t
>>> name isn't universal, not even within countries where it's the comm=
on
>>> form. When I was as student there was a fellow student from another
>>> scandinavian country and his legal, full name consisted of a single
>>> letter.
>>>
>>
>> I'm curious, what Scandinavian country was this? Because as a
>> Norwegian, I know a lot of people from all Scandinavian country, yet
>> I've never heard of such names. In Norway, I the shortest legal name
>> I've ever heard of was five characters.
>
> Sweden (I'm Norwegian too - this guy was a Swede studying in Norway).
> Admittedly I have only that single example, and it was back in the
> late seventies. His name was accepted as legal by Statens L=E5nekasse
> (bank for students) and when the loans arrived his single-letter name
> would be found at the very end of the long lists of wide listing-pape=
r
> printouts from the bank that was stiched up on the billboard wall
> outside the administration offices. The loans arrived a couple of
> times per year but we always had to go looking - the rest of us were
> just amazed that we could really find that single letter down there
> and he wasn't bs'ing the rest of us about his name.
>
> I'm not sure why there's a 3-letter limit on git author names.. but I
> would suggest it should be set down to 1 letter minimum.. below that
> would, I think, be overdoing it..
>

Linus, you wrote sanity_check (from 2744b23). Do you remember if there
were any specific reason for the minimum length of 3 of an
author-name? It seems that in Sweden, legal names can be even a single
letter (see Tor's comment)...
