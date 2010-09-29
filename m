From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH] checkout: add a space between the commit and "..."
Date: Wed, 29 Sep 2010 08:13:27 -0500
Message-ID: <AANLkTimRhvsozBJ+8Jup75nRgzoHAmCQ3_96qLPU_b0B@mail.gmail.com>
References: <20100928222332.GA28859@soprano.nvidia.com>
	<tNUxsuXC1ZklaaYn-pkW6hae44B_tB2hStuto66EU4k9w2Q79GA6LQ@cipher.nrlssc.navy.mil>
	<4CA2E8C7.4040100@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>,
	Aaron Plattner <aplattner@nvidia.com>, git@vger.kernel.org,
	jkain@nvidia.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Sep 29 15:13:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0wTX-0002DH-4x
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 15:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991Ab0I2NNa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Sep 2010 09:13:30 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:32900 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758Ab0I2NN3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Sep 2010 09:13:29 -0400
Received: by pxi10 with SMTP id 10so159516pxi.19
        for <git@vger.kernel.org>; Wed, 29 Sep 2010 06:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/sgatSSNym+J88zzVX/Ebt1/KCrHh9qk5JJTO9a0AI8=;
        b=MmrWMACaXR+UnfMSy9B/2nX/U11iIlQfWgj4yb+FfygCgN1iCF2Aa5gPLPAK5JdWK2
         RPJJ1gAnvTcoOQvg/LueImrSehrFJwVgj+FKsJBq2hplSsWr7XU7fpaAXYdpteGtjc45
         e+tZr5bUppuA9PmRajvolXY9FxWNSNyrF+fQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fp6DYTCg4jFpE1eWf4D6AJex6/5YV6telQQ4gQiIDR2HQMD1wkEeIbM9Ns9xU91i1y
         RWPq5w9DNIzvMygSlgwZYiGu5RW/W5hLdvDT7/oFcl8JvBV4jKFqIEXWNTwvukP9TLCi
         /mtwGZnF9ZHGseN8TKKNE8TNRBKFVaQviasWI=
Received: by 10.142.230.13 with SMTP id c13mr1357060wfh.115.1285766007986;
 Wed, 29 Sep 2010 06:13:27 -0700 (PDT)
Received: by 10.220.203.3 with HTTP; Wed, 29 Sep 2010 06:13:27 -0700 (PDT)
In-Reply-To: <4CA2E8C7.4040100@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157564>

On Wed, Sep 29, 2010 at 2:20 AM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 9/29/2010 0:40, schrieb Brandon Casey:
>> On 09/28/2010 05:23 PM, Aaron Plattner wrote:
>>> Switching to a detached head prints something like
>>>
>>> =C2=A0 HEAD is now at 9d14017... dir.c: squelch false uninitialized=
 memory warning
>>>
>>> These dots get selected when you double-click on the abbreviated
>>> commit hash, which makes it annoying to copy and paste.
>>
>> This must be another gnome-terminal/konsole "innovation".
>>
>> xterm still does the "right thing"(tm) _and_ it doesn't eat my
>> alt keystrokes like alt-b to move the cursor back a word. /rant
>
> You must be running an xterm with settings from the stone ages. I had=
 the
> impression that modern installations have the selection configured su=
ch
> that a file path can be selected with a mere double-click,

=46edora 11 (and hopefully later versions), default settings.

   $ appres XTerm | grep charClass; echo nada
   nada

It's probably an ubuntu thing.

> without dragging.

Just right-click to extend the selection.  It's a lot easier than reduc=
ing an
over-aggressive selection (read: impossible).  Try using right-click to
adjust a double-click selection with and without the charClass setting
that you mention below.

> For this, the dot must be in the same class as letters and
> digits. Just for reference (I don't know how to read this):
>
> $ appres XTerm | grep charClass
> *charClass: =C2=A0 =C2=A0 33:48,37:48,43:48,45-47:48,64:48,126:48,95:=
48

Thanks, now I know what to disable when I use ubuntu.

   $ echo charClass | xrdb -remove
   # Then start a new xterm

-Brandon
