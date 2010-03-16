From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH/RFC 02/12] grep docs: grep accepts a <tree-ish>, not a 
	<tree>
Date: Mon, 15 Mar 2010 20:47:06 -0400
Message-ID: <ca433831003151747r3e9d7a8bp7bc2ed43b8c694a9@mail.gmail.com>
References: <1268455984-19061-1-git-send-email-lodatom@gmail.com> 
	<1268455984-19061-3-git-send-email-lodatom@gmail.com> <7v1vfn7uje.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 01:47:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrKwY-0001so-UI
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 01:47:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937251Ab0CPAra convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 20:47:30 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45586 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937235Ab0CPAr3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 20:47:29 -0400
Received: by gwaa12 with SMTP id a12so113738gwa.19
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 17:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tJmzw8wI3bInnSo7ohNiAcMBqmBHixnyHPeC6tAaaR0=;
        b=vWEDMvoGfHdCZNryQRzcqXKXzg38Q+OZNHuG74z4C+yvHZcCecRx+61hxPHnALjl31
         77tdIBu1tGMNVbCaaLlJTL0j9QtIaJMuxqgoMC2fhbMrV+hvUGOpjRhprlyBOVkiAZTJ
         yra+hsfK/+zg6upRqR2cYLit3yTwnIIEDEHso=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=B2ti2saW5+JdjOr0c2ANzfrLftig1lZkaPnEJJP9qgm1Hh2BBKTAiGAuevzuJ6GJWd
         nw42RwlGYR9hQ24STyXZY2fK8wrfg4ZnAefZaCilhiH/tztTIfpmenk+UcbpyuThpoiE
         M3d+qKb5Y+J1XeST7/GBAa4kNkwDWARB0YBNQ=
Received: by 10.90.16.12 with SMTP id 12mr4173247agp.46.1268700446199; Mon, 15 
	Mar 2010 17:47:26 -0700 (PDT)
In-Reply-To: <7v1vfn7uje.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142286>

On Sat, Mar 13, 2010 at 5:59 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Mark Lodato <lodatom@gmail.com> writes:
>
>> =C2=A0Documentation/git-grep.txt | =C2=A0 =C2=A04 ++--
>> =C2=A0builtin/commit-tree.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
>
> Yuck; plonk, try again.

Oops, sorry about that.  I'll fix it in v2, since the commit-tree.c
part should go in the previous patch.
