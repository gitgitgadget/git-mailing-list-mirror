From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Thu, 12 Sep 2013 19:55:00 -0500
Message-ID: <CAMP44s2z4HBR+qpVbbCmTR-OrAK_eMH4CfSfofFDuarLKP7RPA@mail.gmail.com>
References: <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<20130904092527.GB22348@sigill.intra.peff.net>
	<CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
	<20130908041805.GB14019@sigill.intra.peff.net>
	<CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
	<20130908172605.GF5359@vauxhall.crustytoothpaste.net>
	<CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
	<20130909000153.GG5359@vauxhall.crustytoothpaste.net>
	<CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
	<vpqr4cy4g5q.fsf@anie.imag.fr>
	<CAMP44s0YaQo7xAkPcV3xVTcYQStUVuyY=we-=KMgtZ-xgZzz1Q@mail.gmail.com>
	<vpq4n9tjd5z.fsf@anie.imag.fr>
	<CAMP44s2dmn48T=c6aSLrWeTY=CKf5AYnAv7gA8bLjLMyb9-MTA@mail.gmail.com>
	<vpqbo3za8r9.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Krey <a.krey@gmx.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Sep 13 02:55:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKHfA-0007ah-6N
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 02:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756382Ab3IMAzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 20:55:03 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:59338 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab3IMAzB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 20:55:01 -0400
Received: by mail-lb0-f175.google.com with SMTP id y6so1534779lbh.34
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 17:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=SxkCsftm0nnyS/pwBNToweIemiZTaJ9I91KpzqNVcF0=;
        b=pGzLtOaONVw4AwitosGAJPsQW6pAXRIFFE2Qagy1qEtvSVJrnT2spVMRI5d9lxOdRX
         l6aNjWrQCDm3wrAUeTxJ1XphFZRrmBsZzywRfBrytPTWsq+Ya2QgnAlH2EIcuwd4klBl
         a/2HJK5tlyB3DdmtSamqf6eFJSl/8LcMhU9PWdrqtsEgv+JMuH7X8tVChrHQgm3wp9RR
         rkkafUPYd1VjffiXG8ek2NwAKDBah4sNg7rTCB1bseWXe/iwTLoEzt4YF52MgBWKQUpu
         gxq3yUaDHSNuhQpyF+/NKmAVxhfPbZepyXpLOvLtHAUgBuu66S5/XXCq0lwWRfYStMh3
         aKpg==
X-Received: by 10.152.45.106 with SMTP id l10mr8637570lam.12.1379033700443;
 Thu, 12 Sep 2013 17:55:00 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Thu, 12 Sep 2013 17:55:00 -0700 (PDT)
In-Reply-To: <vpqbo3za8r9.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234716>

On Wed, Sep 11, 2013 at 6:38 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Tue, Sep 10, 2013 at 3:26 AM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>
>>> So, you insist in asking the user to chose between rebase and merge, but
>>> you also insist that they will not chose rebase? So, why ask?
>>
>> Because as you said, they don't know what that is.
>
> That does not answer my question: why ask?

If you have to ask, then you haven't read the commit messages, the
cover letter, or the relevant discussion. Even Linus Torvalds agreed
this was a good change.

> Look around you what people say about Git. See how many complain about
> Git not exposing enough complexity to the user. See how many would
> complain about Git not advertising rebase enough. Then, look how many
> complain about Git exposing too much complexity and making it too easy
> to use features like rebase.

And see how many are confused by Git doing something they never told
it to do, and then being totally lost because they are in the middle
of a state they don't understand, and how many do merges by mistake.

There's a reason why Git user-base considers 'git pull' dangerous.

-- 
Felipe Contreras
