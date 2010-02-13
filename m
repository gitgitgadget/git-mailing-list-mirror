From: =?UTF-8?Q?Bj=C3=B6rn_Gustavsson?= <bgustavsson@gmail.com>
Subject: Re: [PATCH] add -p: make the beginning of the hunk easier to see
Date: Sat, 13 Feb 2010 12:36:20 +0100
Message-ID: <6672d0161002130336l6e214a6fh6907db8fa64485be@mail.gmail.com>
References: <4B768807.3030003@gmail.com>
	 <20100213112342.GA1299@coredump.intra.peff.net>
	 <20100213112557.GA5165@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 13 12:36:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgGIZ-0002cl-Dt
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 12:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753519Ab0BMLgX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Feb 2010 06:36:23 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:54459 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346Ab0BMLgW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Feb 2010 06:36:22 -0500
Received: by ewy28 with SMTP id 28so2448897ewy.28
        for <git@vger.kernel.org>; Sat, 13 Feb 2010 03:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0HjxWUcfGnMglOD6JHQFozMHLMISbKkMGp1VA/MTFWI=;
        b=ou/6KomLrV2rk+8KTjTbkMu1VCW0CExTH5pJQxr0xKO3HjKZwLoVZTv9KVbJ7AW3Ii
         Vk40SVeBU+j2A0WWPLWmmcRGy6hoc9mEHnIcfL841cztKXosGrlIqVicr9DpIA66MkRz
         dTFMXnBZko0cuVdMagsC7gm9A+7COOCDW94VA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xIbD0kiecUGglVon6ZoPHkeiK8hd6KOKX1sWe5Fz40FuIPCFAHGxJoxbUJy8z99I0H
         XHrKZ9hDQ3QBJxLhtlZXauSPUTZw4Vz+f4CR6YXm+bKcenUjOuJem724KSNRSfLMh3Sy
         Yx3vp3Cl56GCfyeJn06nFDprmXA1MNeFoUjTs=
Received: by 10.216.90.5 with SMTP id d5mr1637553wef.147.1266060980741; Sat, 
	13 Feb 2010 03:36:20 -0800 (PST)
In-Reply-To: <20100213112557.GA5165@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139787>

2010/2/13 Jeff King <peff@peff.net>:
> On Sat, Feb 13, 2010 at 06:23:43AM -0500, Jeff King wrote:

> Side note. Even if we did want to do something like this, your
> implementation is probably not the right way. It will print the huge
> "=3D=3D=3D" separator even after the last hunk. You would want to kee=
p a
> "$shown_any" variable and output the separator before showing a hunk
> instead.

OK. I can fix that if there seems to be any interest to include it.

--=20
Bj=C3=B6rn Gustavsson, Erlang/OTP, Ericsson AB
