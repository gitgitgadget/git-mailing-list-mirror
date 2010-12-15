From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] get_sha1: support ref^{/regex} syntax
Date: Wed, 15 Dec 2010 10:12:59 +0700
Message-ID: <AANLkTimy5MVkxDzXqzA8T4DHJmzsSAvwqVVzRvWw5KA0@mail.gmail.com>
References: <1292209275-17451-1-git-send-email-pclouds@gmail.com>
 <1292209275-17451-3-git-send-email-pclouds@gmail.com> <7vaak7rh9k.fsf@alter.siamese.dyndns.org>
 <AANLkTikgXAg9+0TXzpFH7LT1yD2sV5Dp=025GbudnY5S@mail.gmail.com> <7v62uvrbfk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 04:13:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSho8-0007CC-Hq
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 04:13:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759255Ab0LODNb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 22:13:31 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:45921 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754331Ab0LODNa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 22:13:30 -0500
Received: by wyb28 with SMTP id 28so1090767wyb.19
        for <git@vger.kernel.org>; Tue, 14 Dec 2010 19:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9g6+iL+XRPgq+9nOmZlRmmObnvWIcbwPgIHMGCzrxc4=;
        b=Hsx2GX5oxGk7VbRnWI5T8jFwo3s+maf65T6J/wCU+7PZjZjw7bL9bA0+fX/iFovyXt
         3EA7m1kviig/W+FR9w3YecMIdM+Q4WQyWGn3UwhSZgJZsxusCl2rAI7UjxwjjEZ+tRjY
         4cI6UoDtoU0qhQggpA/DLh/0sU0ENXdwixOd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=YGkcpq1M+C8Lq2Kpm28RQIUgYLEk7T3yc14vdagRO29E1ybJhiUN37CCtuWVBlewoG
         uMmhYMsOyFC1+QxEXOK748ZWMeoI8R5E3XkW1+uvmd4W6LQfHLNVJdhn63gX+IV0Lgns
         K48Bc6Uk595usYihSZ05ZbtvUz0OQZ39qG8xE=
Received: by 10.216.59.143 with SMTP id s15mr74454wec.49.1292382809729; Tue,
 14 Dec 2010 19:13:29 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Tue, 14 Dec 2010 19:12:59 -0800 (PST)
In-Reply-To: <7v62uvrbfk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163731>

On Wed, Dec 15, 2010 at 9:56 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> Perhaps we should just reject this case. No sane body would ever use=
 it.
>
> I'd have to say that dismissing before even trying is not a very
> disciplined attitude.
>
> Shouldn't an empty regexp simply match everything? =C2=A0Even on FBSD=
8,
>
> =C2=A0 =C2=A0$ grep '' /etc/passwd
>
> seems to show everything. =C2=A0How hard would it be to do this in th=
e codepath
> we are discussing?

To make '' match everything is easy. I'll cook up something when I get =
home.
--=20
Duy
