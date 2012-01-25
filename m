From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] bash-completion: don't add quoted space for ZSH (fix regression)
Date: Wed, 25 Jan 2012 03:39:40 +0200
Message-ID: <CAMP44s2x2kJEJsQLZCJiegZY863X=kVO5xof9QBUin35i-BzhA@mail.gmail.com>
References: <20120114152030.GX30469@goldbirke>
	<1326567336-2173-1-git-send-email-Matthieu.Moy@imag.fr>
	<CAMP44s2nYMmfC36+pGaYfOZUQy3fLMYDuaSriPYjHBeApmsRVg@mail.gmail.com>
	<CAMP44s0T15idhwb6Eae5vdMxf25KK9MhY57mBf+BFN=OSC6Lhg@mail.gmail.com>
	<7vzkdmqebh.fsf@alter.siamese.dyndns.org>
	<CAMP44s3GMGMD5Y9Z=Uu_e55_eZOG2zY76u8B=ORKsMx6yoXW5Q@mail.gmail.com>
	<7v1uqxq4jm.fsf@alter.siamese.dyndns.org>
	<vpqlip5qvcm.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jan 25 02:39:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rprq0-0004fL-SH
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 02:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427Ab2AYBjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jan 2012 20:39:42 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:57712 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751457Ab2AYBjm (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jan 2012 20:39:42 -0500
Received: by lagu2 with SMTP id u2so424362lag.19
        for <git@vger.kernel.org>; Tue, 24 Jan 2012 17:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0ctKljyETl30m8jK+mvT+YOYRrDsUGq+5usQnMFuB5U=;
        b=KRxNX8p3tz24rjMlhEpJjvLhfuDMdOnnIKob6B8A1mbPCFLn9P9f0LmPTpwDtywGbe
         y0SPNDSD/MjsloW3oNtUcUFaabeV4poNFHHJY04BIUOiIP5/w9yAOD8EtHEjTf0Dc5QG
         hgfEpot0LsSdLtwBPMYV8O0IyR/uatqep7Btg=
Received: by 10.152.109.161 with SMTP id ht1mr7682463lab.33.1327455580829;
 Tue, 24 Jan 2012 17:39:40 -0800 (PST)
Received: by 10.112.10.169 with HTTP; Tue, 24 Jan 2012 17:39:40 -0800 (PST)
In-Reply-To: <vpqlip5qvcm.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189090>

On Wed, Jan 18, 2012 at 10:16 AM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> OK, so the issue the patch addresses may not be a regression in the
>> upcoming v1.7.9 we want to fix quickly,
>
> I'm running ZSH 4.3.10 (Debian stable), and for me it is a regression.
> It seems there is another bug elsewhere affecting more recent ZSH (I
> don't have a recent ZSH version installed to test), but fixing the
> regression for old ZSH is still worth it. I'm not even sur the issue
> with recent ZSH is related.
>
> At worse, my patch is not intrusive and can easily be reworked later.

I believe I have found a more generic and simpler fix that works for
both the regression in v1.7.9, and users of zsh >= 4.3.12.

Patch sent.

-- 
Felipe Contreras
