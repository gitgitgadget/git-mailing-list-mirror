From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH] grep --no-index: allow to grep without git exclusions
Date: Thu, 21 Jul 2011 10:47:58 +0700
Message-ID: <CACsJy8CYJzfAWAB5yRsX6ug6uMOq27POk8EyC8TDmVTbOdoFaA@mail.gmail.com>
References: <82218b89c89f733dc0759d648b3a60bca6e20f3e.1311165328.git.bert.wesarg@googlemail.com>
 <7vzkk86577.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 05:48:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjkFW-0008MR-D4
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 05:48:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017Ab1GUDs3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jul 2011 23:48:29 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:34552 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974Ab1GUDs3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jul 2011 23:48:29 -0400
Received: by fxd18 with SMTP id 18so2782597fxd.11
        for <git@vger.kernel.org>; Wed, 20 Jul 2011 20:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=bcE69dsUoarnAzzd9rMS6psaJuXH1WqzezoV69pBIXc=;
        b=P2rraLh7CaeYQcv2UeqfHmiYmKrn2QVQIwO7N3L/Iwey1rJmMvtYrZ0SdZ2YpUdaY6
         fEwODrTHU7L0lQ8GOEoTXTFQWeJKL+QeCVuWbRzxjfOJLpVP7lHcgJQxH7xhLmgEpZ+q
         J2Ps94HAkAnYyVhX0q7fBUTo4rgzNiA4j0dts=
Received: by 10.204.32.129 with SMTP id c1mr2733696bkd.291.1311220108129; Wed,
 20 Jul 2011 20:48:28 -0700 (PDT)
Received: by 10.204.123.199 with HTTP; Wed, 20 Jul 2011 20:47:58 -0700 (PDT)
In-Reply-To: <7vzkk86577.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2011 at 3:57 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> =C2=A0- It might be useful to be able to "git grep" both tracked and =
untracked
> =C2=A0 (i.e. new files you may want to "git add") paths, but there is=
 no good
> =C2=A0 way to do so. Introduce a new option --untracked-too (or more =
suitable
> =C2=A0 name --- I am bad at naming and not married to this one) to al=
low
> =C2=A0 this. This mode always takes "exclude" into account.

--ls-files ([c|d|o|i|s|u|k|m])+? This opens door for grepping only
untracked files, for instant.
--=20
Duy
