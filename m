From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] t/README: Document the Smoke testing
Date: Mon, 2 Aug 2010 22:00:26 +0000
Message-ID: <AANLkTi=EuTD0M3eNo+PXW7Z2Ra2yzf-i+L4DFQVg8JZ7@mail.gmail.com>
References: <1280780684-26344-1-git-send-email-avarab@gmail.com>
	<1280780684-26344-3-git-send-email-avarab@gmail.com>
	<AANLkTim2EY7AACe=UzbG-k7oteV6UMmfPAQMEOFn0iZ7@mail.gmail.com>
	<4C5732CE.10906@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 03 00:00:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og33j-0003NR-Ia
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 00:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754526Ab0HBWA3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 18:00:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:44646 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934Ab0HBWA2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Aug 2010 18:00:28 -0400
Received: by iwn7 with SMTP id 7so4450499iwn.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 15:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1/J8p9u7XFgBxpE+2lKu3pMp/jNO5N9x8aTAaSA0AFs=;
        b=UuxLUvYMvEVsAdp1WiPvCwtdbP7hdH47v//2sSFRVAMz/nrE6X5DJBGlCzmFTNv/pr
         Od3pnFKiW6w2zRK/Cx2ZZWyhozy0Ugt+jXmALNzmGEb4XCxdu3v86JPXHrkPFi5vL48W
         +XBMP55/U0n681vuDDhCTR6KBAJgJql0Aw14A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ohkr+OwK3lxL//MgibXABv0PX32EGLqgWjRV9OSXTrj+wKTsi0l6qS1d/eoiytEdtC
         Odc7s2NwTQQR44RKuox7XfzJDLaaPifocxPiigMg9sol1k+LhdQHpB6VHJ/b9p7/X7C8
         C1nCSubpZGzFlcqINfc2MUzaoKbT6ICYWnp9g=
Received: by 10.231.13.130 with SMTP id c2mr2531593iba.24.1280786427089; Mon, 
	02 Aug 2010 15:00:27 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Mon, 2 Aug 2010 15:00:26 -0700 (PDT)
In-Reply-To: <4C5732CE.10906@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152467>

On Mon, Aug 2, 2010 at 21:04, A Large Angry SCM <gitzilla@gmail.com> wr=
ote:
> On 08/02/2010 04:54 PM, Sverre Rabbelier wrote:
>>
>> Heya,
>>
>> On Mon, Aug 2, 2010 at 15:24, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason=
<avarab@gmail.com>
>> =C2=A0wrote:
>>>
>>> Git now has a smoke testing service at http://smoke.git.nix.is that
>>> anyone can send reports to. Change the t/README file to mention thi=
s.
>>
>> Can't we run this somewhere a little less "shabby"? I'd hate to
>> introduce Yet Another Official Git Site (I'm really glad for example
>> that the Git Wiki is now on kernel.org). Is it not possible to move
>> this to git-scm.com, kernel.org, or something like that?

Do you not like the domain, that the domain's A record points to a
Linode box, or both?

I don't mind where a smoke server gets hosted, I just want it to be
there. But someone's going to have to host it and maintain it.

Unless someone else wants to do that it's going to have to either be
at a box I control, or someone else will need to give me shell access.

Of course just changing the domain would be trivial, just a matter of
someone setting up an A record somewhere, or delegating a zone to me.

An alternative would be to change how this works, e.g. making
submissions go by E-Mail to a public list, or having smokers push them
to public Git repositories which would be registered somewhere.

But that'd require more development and setup work. The current system
isn't optimal, but it works. It can always me moved somewhere else
later if smoke testing for Git takes off.

> And what's on the site tells us almost nothing about the tested syste=
ms.

Can you be more specific? What information do you find lacking at
http://smoke.git.nix.is/app/projects/smoke_reports/1 ?
