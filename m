From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2011, #01; Sun, 5)
Date: Mon, 6 Jun 2011 09:38:32 +0200
Message-ID: <BANLkTim3Cd9yn=2NZ4K6dLJExTHgFUSR7A@mail.gmail.com>
References: <7vsjrna2x2.fsf@alter.siamese.dyndns.org> <4DEC7EE9.9060807@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Theo Niessink <theo@taletn.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 06 09:39:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTUP7-0007YK-Fg
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 09:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723Ab1FFHjN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2011 03:39:13 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52697 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755491Ab1FFHjM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2011 03:39:12 -0400
Received: by pwi15 with SMTP id 15so1936485pwi.19
        for <git@vger.kernel.org>; Mon, 06 Jun 2011 00:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=P4XoGiJpiZ4P500/nXNCfdGh/jJnigesJZJm1a7tqRQ=;
        b=DTp1BOhDE38A1X8HIj4RXT+Bo0ExJ0iZ7B+MMdmz1QiY999X0I7DN9jm4zY+xfh8o2
         zcAkkN/vnsCd0Ukf7KBPHKDYjp1ECmDUT8shkVfb+vn3Vh9EXYkTGKpkycnOxOEB6GJk
         qjhtIm4EdZJyOnRpwpQ7Hh4Bc3VFYrVQ+L8p0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=MUE6PYAlpXBSgBMpovJuHqT9Y3LB///ukULqtrwljjnXNh21fr1ypIIx6nzdZ1cExt
         YD5EvnzP8lzSwnqCkbHAU81KMDm22Xt2OQRdu+sG0ATEQisG88MkZhrjc/B21DJ9YUtJ
         JNImdvse8cNyukFFctkh2zjfN+hAfjxmFJEJQ=
Received: by 10.68.24.37 with SMTP id r5mr1771867pbf.450.1307345952036; Mon,
 06 Jun 2011 00:39:12 -0700 (PDT)
Received: by 10.68.50.231 with HTTP; Mon, 6 Jun 2011 00:38:32 -0700 (PDT)
In-Reply-To: <4DEC7EE9.9060807@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175100>

On Mon, Jun 6, 2011 at 9:16 AM, Johannes Sixt <j.sixt@viscovery.net> wr=
ote:
> Am 6/6/2011 8:29, schrieb Junio C Hamano:
>> * ef/maint-win-verify-path (2011-05-27) 3 commits
>> =A0 (merged to 'next' on 2011-06-01 at f316f68)
>> =A0+ verify_path: consider dos drive prefix
>> =A0+ real_path: do not assume '/' is the path seperator
>> =A0+ A Windows path starting with a backslash is absolute
>>
>> Will cook a bit longer.
>
> I agree to all changes. There was a bit of back-and-forth about the
> "verify_path" change. Erik, Theo, would you please check whether the
> queued version is the one you finally agreed on?
>
> -- Hannes
>

Thanks for pointing this out. No, it isn't the one me and Theo agreed
on; we simplified the logic a tas as well (but I never sent out a
version with that fixup squashed in). I'll send out an updated version
in a few days (when I finally get some time for Git again).
