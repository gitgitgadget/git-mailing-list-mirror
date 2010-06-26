From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] fetch: don't output non-errors on stderr
Date: Sat, 26 Jun 2010 15:07:55 +0000
Message-ID: <AANLkTikxJ_MDLhQFweRMWvhzJy9QIfyuJTYaY4a2tPwS@mail.gmail.com>
References: <AANLkTingtgeWuTrocesTIhTPsVz4dfU8CbwZF1TEl6AI@mail.gmail.com>
	<1277418881-11286-1-git-send-email-avarab@gmail.com>
	<7v1vbvkorf.fsf@alter.siamese.dyndns.org>
	<AANLkTilToJ2ekKVgIeka5qx9_lasw6DKSy8bOhTrP4dC@mail.gmail.com>
	<7v1vbukcu8.fsf@alter.siamese.dyndns.org>
	<20100626061305.GB10290@coredump.intra.peff.net>
	<AANLkTik6jbcOtyXJ5JJav1xnLEO6RSmYTHpsX6yYaB5_@mail.gmail.com>
	<AANLkTikq4z5Qs6UUnSh8T9GjVTJBdH8Wy3djIIOlrs2Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 26 17:08:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSWzC-0007Vo-2K
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 17:08:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988Ab0FZPH4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 11:07:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:35639 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752575Ab0FZPH4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Jun 2010 11:07:56 -0400
Received: by iwn41 with SMTP id 41so2970351iwn.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 08:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zHjScU8eNdGgetrLLOZUdUTtbrp4Ul/T5gc3Mh2C5Sk=;
        b=UZpZACpjnwA/yw6LU/6Crr5tAfjRkpCfoftlGRQ+Ec99rZoyJPaXE1y/t28DjkGcbB
         2JbC+4Oq18QnAkfUeNxkHh5PJukVURzI4oeLlGeGJfoK4T2tUyfF3L4MYDgJJ+4cYYwE
         h7nePcSgnbNFdGPDKS/WoetFHSixxjXgSnCD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BoKojxxG9743qCegUhtrcpS+zg64KXt4BH5dMkzYDADG2as9FW595aXBBs0PWGmx/Z
         HszGHJn/lYDWxfOLMYbKpLgBqeYJNLRGsWOgVTQgjW1qGoiNXUyGoJrFBhE9L9AcudUd
         CRM8HYPdUnvSEJazF9r+jdmqYIGie4NGVZ1iI=
Received: by 10.231.82.74 with SMTP id a10mr2193178ibl.183.1277564875462; Sat, 
	26 Jun 2010 08:07:55 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Sat, 26 Jun 2010 08:07:55 -0700 (PDT)
In-Reply-To: <AANLkTikq4z5Qs6UUnSh8T9GjVTJBdH8Wy3djIIOlrs2Y@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149760>

On Sat, Jun 26, 2010 at 13:40, Tay Ray Chuan <rctay89@gmail.com> wrote:

> On Sat, Jun 26, 2010 at 8:14 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on
> <avarab@gmail.com> wrote:
>> But it sounds like we need some general discussion on what stdout an=
d
>> stderr should be used for in Git with regards to progress messages,
>> errors and other similar things.
>
> I'd say - submit a patch for the style guide with your proposed
> guidelines on stdout and stderr usage.

I'm not sure how such a guide should be like for the general case, but
at least making commands internally consistent (as this patch does) is
one step in that direction.
