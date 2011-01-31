From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [1.8.0] default "git merge" without argument to "git merge @{u}"
Date: Mon, 31 Jan 2011 22:32:54 +0200
Message-ID: <AANLkTintp8Je8msnn5X+T8MwvNjSrKm5m8KvshiWEuum@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
	<7vwrll57ha.fsf@alter.siamese.dyndns.org>
	<7vsjw957fq.fsf_-_@alter.siamese.dyndns.org>
	<20110131201419.GA9070@sigill.intra.peff.net>
	<7vaaig6d64.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Miles Bader <miles@gnu.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 31 21:33:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk0Qr-00061e-8r
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 21:33:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256Ab1AaUc4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Jan 2011 15:32:56 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46229 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755815Ab1AaUc4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jan 2011 15:32:56 -0500
Received: by fxm20 with SMTP id 20so6021861fxm.19
        for <git@vger.kernel.org>; Mon, 31 Jan 2011 12:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Qu9FA2pyTlXHDgTMpbuIfbfXopg9l9kKmqKGGj2saMk=;
        b=YQ4GIXhzu66r2HTGqRaMDX3fmZZgZ9AFn2yB70ojZeSooTtYKMVkxmtmDm9ERxnIAg
         XFqtP1Q/xHN2AnXCVN+2HpeUmz0OaAf0CNoG7fClK/Y2v8YREXW0khaxu94nehDcGvOu
         1YUACI6I9cvSZD6O8vwsEM/cB3uIqHeVRjl0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=o60mFtplk+Gt6luuyPg1BijNAeSgTpu2TLjnuj8s+sNp4n2HZv0nhuCYQz0H+KeelS
         zWpGLLGWMNpIcUcUIjeoSBcjM/NkDOviyZWMdWHnEE2VN6Gxj6/QdcRZR2viCHAjMuVt
         PE594oE90UYW3pzxDvbGmpgDbv4T5mAomCYX0=
Received: by 10.223.74.200 with SMTP id v8mr6432814faj.144.1296505974706; Mon,
 31 Jan 2011 12:32:54 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Mon, 31 Jan 2011 12:32:54 -0800 (PST)
In-Reply-To: <7vaaig6d64.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165749>

On Mon, Jan 31, 2011 at 10:17 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Jeff King <peff@peff.net> writes:
>
>>> In 1.8.0, flip the default for merge.defaultUpstream to true.
>>
>> Other than that, I think the proposal and migration plan are fine.
>
> Heh, thanks.
>
> It's not my proposal though ;-). =C2=A0It is just an illustration of =
how I see
> an item from people's wishlist should look like to make it easier to
> discuss them.

Ok, I share the same opinion as Jeff; we should not care about scripts
doing something so wrong. But if the migration path is the only way to
get the change in, I guess I can do that.

--=20
=46elipe Contreras
