From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCHv4 15/15] Replace "unset VAR" with "unset VAR;" in
 testsuite as per t/README
Date: Fri, 1 Oct 2010 16:39:37 +0200
Message-ID: <AANLkTinQDEX8e96xfGNNKYbEZAAmO9gBjU43aWGheR8C@mail.gmail.com>
References: <1285542879-16381-1-git-send-email-newren@gmail.com>
 <1285542879-16381-16-git-send-email-newren@gmail.com> <7viq1omiv8.fsf@alter.siamese.dyndns.org>
 <AANLkTimgTAerCNcSHBR9t-s-ThWHLMXdsb2T=E2w8gpB@mail.gmail.com>
 <7v39srkyax.fsf@alter.siamese.dyndns.org> <AANLkTimmSLwZaGvM1j7CQtTzd7mJXSiBDHztj4S97rOr@mail.gmail.com>
 <20101001114514.GA18405@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 16:40:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1gmT-0001Jz-Fl
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 16:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756774Ab0JAOkG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 10:40:06 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33660 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756669Ab0JAOkF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Oct 2010 10:40:05 -0400
Received: by yxp4 with SMTP id 4so1162087yxp.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 07:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=17yinIkFUvK1e6GEe7UistlHPGWoGpM0n/mFx6RdV0s=;
        b=Gd0hnHuCldBma+nJ7rQFhDLa7DNWoiBg9yExlyQ6Wj9GwH2kZJUtFEpL9g6YeHMAsL
         M1M9z6ittOq/FQ6F879mpAWRCRYrm0PfXF4ShQJm7kCG21Np0mIjrq7mpReP+RKAP5xq
         nFJ3Iv6exf1qX/0GXomHht19BYW+qpO17Knoo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ArpXsGizb5/VlRUhF0euBwITHa05BwhbGMnJYDs/9b446VXhTQoKDtpi/N9NfOzHY7
         ntzxjxEZx2QBH0jkq5I0w2/z/fYaAy0Qt8V5Vfbq/PWyraWGwVOKH+Sa99c+Ji3n68ey
         TQ6us5eKMeHq7k5aPlWl4KmHNO/fO4+l+VkAg=
Received: by 10.231.144.74 with SMTP id y10mr5791438ibu.65.1285943997920; Fri,
 01 Oct 2010 07:39:57 -0700 (PDT)
Received: by 10.231.33.138 with HTTP; Fri, 1 Oct 2010 07:39:37 -0700 (PDT)
In-Reply-To: <20101001114514.GA18405@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157754>

Heya,

On Fri, Oct 1, 2010 at 13:45, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> I fear this would make it harder for new readers to understand what
> test_might_fail does. =C2=A0But if a new function to run "foo || true=
" is
> needed, I wouldn't be opposed to adding one with a different name.

cmd_might_fail?

--=20
Cheers,

Sverre Rabbelier
