From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2011, #05; Wed, 23)
Date: Thu, 24 Feb 2011 03:07:12 +0100
Message-ID: <AANLkTinfAESXU6OaDEqgcU7tppE2PUR=mxYpT94tOJ8j@mail.gmail.com>
References: <7v1v2y5o3p.fsf@alter.siamese.dyndns.org>
	<AANLkTinUtqJJHNyS9CxrC=VnS87v=GH=pOw9yr4r=pii@mail.gmail.com>
	<7vk4gq45bo.fsf@alter.siamese.dyndns.org>
	<AANLkTik6-AFN1T7GYz6z4ad=pPCZG4Z5LWung0qYwe2X@mail.gmail.com>
	<7v4o7u42g9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 03:07:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsQby-0001nh-Pj
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 03:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754932Ab1BXCHP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Feb 2011 21:07:15 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42780 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754260Ab1BXCHN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Feb 2011 21:07:13 -0500
Received: by fxm17 with SMTP id 17so104537fxm.19
        for <git@vger.kernel.org>; Wed, 23 Feb 2011 18:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ezpChsh00At/eYuGjVBG4ZFTHlvqqfUa7vVj8CsMduI=;
        b=W+cHRQ4EA0UuaFvjeOBFfMDOt+CEYnKCcrZnv78/nlz4Ck/b8yiSbrwF49ZV43ro/o
         rxb/jApA5YiYj/wwrjZBOLymip3XVdI7TAKi10Z7Eg8HTPGZAyitAzY9oH3XY1uE1SP/
         gWmFUTR0DVZ6hUomscGGrcmQRTL1GoWdC9LMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZNf3kP2iKjLHS3E1bt5x7NvDN3I9dcPdxdagqLXmJPnwC/jdXsaX75jqWWbkSWjQaF
         AVjWM5XzDyTSaqlW71l5QeLqiAk56GQ/wxXBJLByL5N/0dnIE3yEMjSMIPUPtVdjAbtf
         VFNPts7z09Ckp37UIZErI64fjAyyPJT/Qurwk=
Received: by 10.223.111.137 with SMTP id s9mr242677fap.98.1298513232150; Wed,
 23 Feb 2011 18:07:12 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Wed, 23 Feb 2011 18:07:12 -0800 (PST)
In-Reply-To: <7v4o7u42g9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167767>

On Thu, Feb 24, 2011 at 02:59, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Right, once we're confident (which at least I am) that the first few
>> patches really are no-op's I think it would be easier for everyone t=
o
>> merge them down sooner than later.
>
> We three are pretty much on the same page, then.
>
> Two minor points are what to do with the "#" prefix in "# POISON #"

The root cause of this is solved in a patch by Jonathan:

    https://github.com/avar/git/commit/da15d84430e5f9b68125f6ddad61f662=
51c991ac

I thought it was better to submit it later once this was in. The
current behavior is harmless hack that we're aware of.

> namespace contamination,

You mean just _ being propagated everywhere? That seems harmless.

> but other than these I don't think there is anything controversial.

Great.

>> s/corrected/connected/ also :)
>
> That typo appears only in _your_ version, not mine ;-).

Indeed. I was amending my suggestion, not your original :)
