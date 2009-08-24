From: Ulrik Sverdrup <ulrik.sverdrup@gmail.com>
Subject: Re: [PATCH] block-sha1: Use mozilla-sha1 copyright and license 
	information
Date: Mon, 24 Aug 2009 15:52:29 +0200
Message-ID: <a1b6cb1b0908240652s4714eadeha7c7997fec2ab985@mail.gmail.com>
References: <20090824120756.GA17146@ulrik-ibook>
	 <alpine.LFD.2.00.0908240923360.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Aug 24 15:52:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfZyU-0004Ow-QA
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 15:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558AbZHXNwd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Aug 2009 09:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752545AbZHXNwc
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 09:52:32 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:48548 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752537AbZHXNwc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2009 09:52:32 -0400
Received: by ewy3 with SMTP id 3so2393855ewy.18
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 06:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BsY4ERZN5QivsFMoexLyo4mZoyvFZ/FN4SSb++uCFz8=;
        b=DxDsHt/erLa+fCerL6GEW/6D8/st8U56A5e4bPrqAYVOkCIgLcE4ggkJMSlfRxxGS6
         z1GaMW65YIAtCrwSlzQteTkFKrVejVsSJr1zDAwHVRmSmjiJ45csed5evRm53Brly3Ch
         DjiX5zZzxpNhZ579+ZUpIOT7iOb8zJc/Xqx+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pCrDYhw+4oMJGWaB/Y0d5lwIAoio8P3cuVrvl+hRhQgEmi8Azx2n/FO7pCrl8yq/MW
         vMqxR36tK2CKm/UWtMb57W62FVxAozV2guHw9hBoF5vR6mifQVFVn4W2zitw2iPCb/g1
         cBPNvxgI3A7o2aIUoV6/2egbi4A57YDSowXXo=
Received: by 10.216.70.134 with SMTP id p6mr1028108wed.40.1251121949873; Mon, 
	24 Aug 2009 06:52:29 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0908240923360.6044@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126925>

2009/8/24 Nicolas Pitre <nico@cam.org>:
>
> The Mozilla SHA1 is already removed from the tree in "next", and
> block-sha1/sha1.c header modified accordingly.
>
> As there is nothing remaining from the Mozilla SHA1 code, I don't thi=
nk
> copying that Mozilla License block verbatim is appropriate. =C2=A0As =
Linus
> has put it himself, the Mozilla SHA1 code was more inspirational than
> anything else.
>
> And even if some license claim could be made, the MPL section was
> deleted anyway (as explicitly allowed), meaning that only the GPL (by
> vertu of being included in a GPL project) would then apply.
>
> A question was recently sent to all contributors (see the mail
> archive) to determine if they
> would agree
> to a relicensing of that code to make wider license compatibility.
> George Spelvin even rewrote that code as well with the goal of
> putting his version in the public domain. =C2=A0No definitive conclus=
ion
> emerged so far though.
>
> Therefore I don't think this patch is appropriate.

Agreed. I just didn't look into next.

Ulrik
