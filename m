From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] push.default: Rename 'tracking' to 'upstream'
Date: Wed, 16 Feb 2011 10:27:47 +0000
Message-ID: <AANLkTikq67jQnM555nHKeyk5t0Ln+Hp97WSztTaej_CW@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
 <vpqy65gs6hs.fsf@bauges.imag.fr> <alpine.DEB.2.00.1102160421300.14950@debian>
 <201102161108.26637.jnareb@gmail.com> <vpqhbc4mg1c.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 16 11:28:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ppecc-0006HQ-N8
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 11:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758901Ab1BPK23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Feb 2011 05:28:29 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:51009 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757837Ab1BPK22 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Feb 2011 05:28:28 -0500
Received: by gwj20 with SMTP id 20so522283gwj.19
        for <git@vger.kernel.org>; Wed, 16 Feb 2011 02:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=bOc97Kwo7dipx00IGk4sNTnVdtYMgSir/5dP0w0jFn8=;
        b=EHe2gxpWEZ6sqA4FLvKpA8/ucF0Df6Ftyf/korEB9lWZkYGJMS0UwH3DE118Jvykyv
         R0CG8cWBfL93WxIgAJKnh0vdovxt8IXSdkJ6VMIwv/W6EflyUIyqMonnZjuyRZet3Nth
         huYRomVM428riciVuU8B0kGDd94OSpjc3ru6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ojUpSu0Hz62BaRYAn7pr/xFMZxqo9LJF25Qo7SYIiiCzacxA1gatlLt3xsHi6Rs6ZV
         3R3I2eRMyenKPUbOEDgTnwvZ5zRkdDnmBCcARpEp7krA3clrjxX/Fu0YP422ROqx2/w0
         vjz3ogyBcn/oVtf1vlbC/eUV/MortHfzqayMs=
Received: by 10.151.79.13 with SMTP id g13mr537106ybl.51.1297852107613; Wed,
 16 Feb 2011 02:28:27 -0800 (PST)
Received: by 10.151.158.19 with HTTP; Wed, 16 Feb 2011 02:27:47 -0800 (PST)
In-Reply-To: <vpqhbc4mg1c.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166949>

Heya,

On Wed, Feb 16, 2011 at 10:26, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
>> I think that for 'branch.<name>.upstream' it would make more sense to

I like the idea of naming it 'upstream', although I don't care much
either way for restricting what you specify. I've always thought
'merge' was a curious name that didn't really fit with my mental model
of what I was configuring.

-- 
Cheers,

Sverre Rabbelier
