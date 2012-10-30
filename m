From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Tue, 30 Oct 2012 18:18:57 +0100
Message-ID: <CAMP44s2b=it8vtFDKd7F2yecm+j7C4N=YfMDt0_3LdFO3_HJNA@mail.gmail.com>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com>
	<20121029085045.GA5023@sigill.intra.peff.net>
	<CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com>
	<20121029212643.GA20513@sigill.intra.peff.net>
	<CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com>
	<20121029215631.GF20513@sigill.intra.peff.net>
	<CAMP44s1SLpNpbjRXF6QHrOTO=_1=wjPo1_kV3jZV-HXOYXPbnQ@mail.gmail.com>
	<20121029220604.GA21712@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 30 18:19:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTFT6-00079h-4c
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 18:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914Ab2J3RS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 13:18:58 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:64253 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964823Ab2J3RS6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 13:18:58 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so498703oag.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 10:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OWi6qob15cAKoZHvkcS0tJ/h/E92Tp/9dQY0a4zKi6E=;
        b=P5tNPctKlWer9yT6I+624+HjyWa87LCOZzulbnKBt3IfX6CM09EcAr9/hDM2tzZJOG
         t80bMH7+NRh4SFgwFQEQ7XtT2VbpAuwBQIeuFOIy0VoSAsEXIrCIIYSge8+YWmTPbcdS
         tDMtKN6qAg1NLN0ukbfN7vjz7hMxArVrEo+J2W3HtzhpMjjNABnX05YIFpi/Q0Ntc52J
         i85bkwE7sBwgG0YEUgyy954cBO+aLMKfvuv29LlfchadSQGU3+kUMzea6PvAygJueZW/
         SJ3Vs+oR9t4T0vgzMH9zFPfgGdBqfZnSc53b29UUuvPVtzfafFV+1R1r6NXoMjyfwFW/
         pSuA==
Received: by 10.182.52.105 with SMTP id s9mr28348650obo.25.1351617537254; Tue,
 30 Oct 2012 10:18:57 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 10:18:57 -0700 (PDT)
In-Reply-To: <20121029220604.GA21712@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208709>

On Mon, Oct 29, 2012 at 11:06 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 29, 2012 at 11:02:31PM +0100, Felipe Contreras wrote:
>
>> > If remote-hg is going to live in contrib, it probably makes sense to
>> > have its tests live there, too, like subtree.
>>
>> Probably, I'll check that option.
>>
>> But eventually I think it should be installed by default, unless
>> somebody can come up for a reason not to. For now contrib might be OK.
>
> I would one day like to have it as part of the main distribution, too,
> but it would be nice to prove its worth in the field for a while first.
> I especially would like to find out how it compares in practice with the
> work that is in msysgit.

Yeah, I would like to compare it with that work, if only the patches
were readily available somewhere.

-- 
Felipe Contreras
