From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] add -p: make the beginning of the hunk easier to see
Date: Sat, 13 Feb 2010 12:42:56 +0100
Message-ID: <6672d0161002130342h348765a0j76f63972c4bbe060@mail.gmail.com>
References: <4B768807.3030003@gmail.com>
	 <20100213112342.GA1299@coredump.intra.peff.net>
	 <6672d0161002130333m55372972x909234cae7bd0d82@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 13 12:43:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgGOu-00066D-Ae
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 12:43:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785Ab0BMLm6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 06:42:58 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:44764 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687Ab0BMLm5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Feb 2010 06:42:57 -0500
Received: by ewy28 with SMTP id 28so2452936ewy.28
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 03:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Wva0/0H0yc1fj/RlJwYeQM9VQWGdM73YN6S7ofZMctM=;
        b=W7NX39SB+AUBrkOX1+bq20IOgE9q0mv2oL0e89bJr43qZmUv996ADaPpTYNj/T0e2G
         ouoiuqxELz3wPpjOqCejAMCc9Y7PQ6jDrkxevy1wFyakDQ9273PudfjOPjZ3sdldWHSU
         YIguXSLskI3ppMvW97+AjJBGN6l3LfJrnuTNs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=lTvIFooNbmlmpvZRGQeSdSkMSa8yPDqfZ3c19sfCrgCTWM9jmEkDGFyiCP/iC5/q7E
         2xErwosBdPn3ukQoKwmeY4tCTWTQ5JdnedpnUv3L7sjoJOobRJF7KlZg75SoyOE83KbO
         RnZdsNxWC9dSdGtCIwrfvrECDpCxK8JBe6jGw=
Received: by 10.216.90.203 with SMTP id e53mr1608882wef.86.1266061376400; Sat, 
	13 Feb 2010 03:42:56 -0800 (PST)
In-Reply-To: <6672d0161002130333m55372972x909234cae7bd0d82@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139788>

2010/2/13 Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com>:
> 2010/2/13 Jeff King <peff@peff.net>:
>> On Sat, Feb 13, 2010 at 12:07:51PM +0100, Bj=C3=B6rn Gustavsson wrot=
e:
>>
>> Wow, I find this terrifically ugly. I guess you don't use
>> color.interactive, which will output a colored hunk header?
>
> I do use color.interactive, but I didn't find that distinctive enough=
=2E

As an alternative to my patch, the color coding could be changed.
The beginning of a chunk is now marked with a faint bluish color (the p=
art
that looks like "@@ -42,9 +43,8 @@").

Giving the "Stage this hunk..." prompt some noticeable color (such as r=
ed),
could make it easier to the see beginning of the hunk. Or
simply doing a form-feed (but I suppose not everyone would
like that).

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
