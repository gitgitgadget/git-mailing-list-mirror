From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: permissions
Date: Sun, 6 Jun 2010 14:45:40 +0200
Message-ID: <AANLkTim1-lN6TCD__V5F0BpPkmLbULkXHF03n0CqWTOi@mail.gmail.com>
References: <4C0A19FE.1020802@wpursell.net>
	<m27hmdn704.fsf@igel.home>
	<4C0A9615.4090307@wpursell.net>
	<AANLkTileRHwUuJpvKJbivRiM9Prn9wJ0zH6abExBgcq0@mail.gmail.com>
	<4C0B6C32.1090700@wpursell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: William Pursell <bill.pursell@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 06 14:45:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLFEY-0007XS-Rg
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 14:45:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756217Ab0FFMpm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Jun 2010 08:45:42 -0400
Received: from mail-yw0-f187.google.com ([209.85.211.187]:48016 "EHLO
	mail-yw0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756201Ab0FFMpl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Jun 2010 08:45:41 -0400
Received: by ywh17 with SMTP id 17so20034ywh.1
        for <git@vger.kernel.org>; Sun, 06 Jun 2010 05:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=49IhEgu6p+/XnP87lxc/9+aFZ77ik66mZtA2nw9D3Xw=;
        b=p5787ny7+MFhW7/BEHFnR54DRCTUxi8SIKaUnX0VFmQm9wts4UqHfhjVLEw8jGJrYN
         GHXh6ncDc4B4wUizy2BrP+kgJzPf1bDLulte36VdvpwS1LLv1jS/m4/l5FeBbnaZ3gCv
         uE6UUyw9qrRa62ngL+y39X7XUprdZxedwjIF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=XWBGovUREAcaia1J1OJ+nFt2hitcdTvWS4pro2TC2VLlCSR3Hbayrtc99IOWDb1mGj
         /1MiDf2MLqPMjmnrgd8eRtmKLPjNaTYZYg/YBl6fwQzL5++Fmr37Yem/7rQKBuT6JJl2
         j5Ps379oCDtwR+fNh2DcXb1PZEf1LLuScGpIs=
Received: by 10.101.213.29 with SMTP id p29mr14685501anq.266.1275828340116; 
	Sun, 06 Jun 2010 05:45:40 -0700 (PDT)
Received: by 10.100.123.13 with HTTP; Sun, 6 Jun 2010 05:45:40 -0700 (PDT)
In-Reply-To: <4C0B6C32.1090700@wpursell.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148520>

On Sun, Jun 6, 2010 at 11:36, William Pursell <bill.pursell@gmail.com> =
wrote:
> Alex Riesen wrote:
>> On Sat, Jun 5, 2010 at 20:23, William Pursell <bill.pursell@gmail.co=
m> wrote:
>>> fatal: Not a git repository (or any of the parent directories): .gi=
t
>>>
>>> That's just weird. =C2=A0And if there is a git repository in a
>>> directory above, there may be great confusion, weeping
>>> and gnashing of teeth.
>>
>> How about just this? (I assume cwd does hold current working directo=
ry).
>
> <patch snipped>
>
> The problem is permissions, not that it's "not a git repository".
> The error message should be "permission denied".

Well, isn't it enough to diagnose the problem? (where it lies, at least=
).
