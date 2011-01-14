From: Tor Arntsen <tor@spacetec.no>
Subject: Re: Git Rebase blows away GIT_AUTHOR_NAME
Date: Fri, 14 Jan 2011 10:24:47 +0100
Message-ID: <AANLkTi=PTgmOSC7pRLjujO5fi9Wdp69Jmj4zCkhGSYSz@mail.gmail.com>
References: <AANLkTinMX0yEPvSc-c=96R42SbFZTjW5Mnveuxk3ZHS=@mail.gmail.com>
	<20110112182150.GC31747@sigill.intra.peff.net>
	<AANLkTimanDRHwoqSj7i9sVCZkze1L3Qp-zFYwTwHAOHX@mail.gmail.com>
	<AANLkTimvK3p3M8kbGzLxyhchoFONiD4=FGPWxxs=i0GA@mail.gmail.com>
	<AANLkTikqfX3jhSdP5xhFj=VktqW2S6AeGL_MF18g8ZA_@mail.gmail.com>
	<AANLkTimf2rwKqyWwQbdj7cjS8YcQwCXYGRCvQbZ5HZ19@mail.gmail.com>
	<AANLkTik15iV9SOv6rRL5+DQkAZ4JwBGTS+gqS3nXy2hN@mail.gmail.com>
	<AANLkTikk7Xdiey76Dmy848_B4qNX2-Vbis7p=E8vtNL9@mail.gmail.com>
	<AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: JT Olds <jtolds@xnet5.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Jan 14 10:25:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pdftw-0003uV-AB
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 10:24:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951Ab1ANJYw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jan 2011 04:24:52 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36847 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab1ANJYs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Jan 2011 04:24:48 -0500
Received: by qyk12 with SMTP id 12so3141142qyk.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 01:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/+iSbuS6VWetC430dPlp1VK8zAOUW/cy9oqXnY7M630=;
        b=HJNMME8Eu9NO9FbODG0+HMNb2l2rm1WFKT+mSgA+nSdaYZ/CFBWTOUKQoi/tPRI17y
         XxbCu1JuHAMaVLokeIJLhm+FVXD6dEIQSwRXifXVuVMcqe2LFhLw20WzhHrCgvHyVaSV
         aXkziVdzH7gAOqO2tLSOq6vgD8OYThWn65URw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=lqg+5dlVIitFynxY2FgCBSRqmMTPUiMc/lF6nuZuUw6gORVyBdmZtpTSFZ1U2TdgSW
         CpOVwioNa2b6U+nPoEjYxCM8R+Rpso2eoGuNQFGg46tx6T8MIja+MZjK6Egze0OFX2WP
         n0xUMWStMd3LEpK0ZZa+AgsUluKSsuuV6GcSA=
Received: by 10.229.245.4 with SMTP id ls4mr471251qcb.208.1294997087938; Fri,
 14 Jan 2011 01:24:47 -0800 (PST)
Received: by 10.229.84.202 with HTTP; Fri, 14 Jan 2011 01:24:47 -0800 (PST)
In-Reply-To: <AANLkTimONqL4=E4Unrsj9PU5u57KGXrmO6xWUOCLorgs@mail.gmail.com>
X-Google-Sender-Auth: O_IH67yQ566V6-QuU7IbzjGYNTc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165086>

On Fri, Jan 14, 2011 at 09:56, Erik Faye-Lund <kusmabite@gmail.com> wro=
te:
> On Fri, Jan 14, 2011 at 9:45 AM, Tor Arntsen <tor@spacetec.no> wrote:
>> I think I've mentioned this before in another thread, but first/last
>> name isn't universal, not even within countries where it's the commo=
n
>> form. When I was as student there was a fellow student from another
>> scandinavian country and his legal, full name consisted of a single
>> letter.
>>
>
> I'm curious, what Scandinavian country was this? Because as a
> Norwegian, I know a lot of people from all Scandinavian country, yet
> I've never heard of such names. In Norway, I the shortest legal name
> I've ever heard of was five characters.

Sweden (I'm Norwegian too - this guy was a Swede studying in Norway).
Admittedly I have only that single example, and it was back in the
late seventies. His name was accepted as legal by Statens L=E5nekasse
(bank for students) and when the loans arrived his single-letter name
would be found at the very end of the long lists of wide listing-paper
printouts from the bank that was stiched up on the billboard wall
outside the administration offices. The loans arrived a couple of
times per year but we always had to go looking - the rest of us were
just amazed that we could really find that single letter down there
and he wasn't bs'ing the rest of us about his name.

I'm not sure why there's a 3-letter limit on git author names.. but I
would suggest it should be set down to 1 letter minimum.. below that
would, I think, be overdoing it..

-Tor
