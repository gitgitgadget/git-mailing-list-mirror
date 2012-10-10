From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] grep: stop looking at random places for .gitattributes
Date: Wed, 10 Oct 2012 19:03:33 +0700
Message-ID: <CACsJy8BG0HJNePG-j27SrfEenEkZ5a5nCdMEuDGn=qXxq=VzhA@mail.gmail.com>
References: <7vk3uzfp3p.fsf@alter.siamese.dyndns.org> <1349868894-3579-1-git-send-email-pclouds@gmail.com>
 <1349868894-3579-4-git-send-email-pclouds@gmail.com> <5075615B.8020702@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 10 14:04:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLv1M-0003xa-Oj
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 14:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607Ab2JJMEH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Oct 2012 08:04:07 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61447 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab2JJMED convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Oct 2012 08:04:03 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so655514iea.19
        for <git@vger.kernel.org>; Wed, 10 Oct 2012 05:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RKzTHW71HUIXycrO68ecvq6Y44+YDXUEGLnE+sofgl4=;
        b=NDQ1Fzr5Pygfc+OsAMSd/iQJCZbPx5/wUuTgvzBNk/0FOrmDKcT69X+QKE/KiIF58V
         RRmEtlk0Fg/j6718Y5rznKP/0ATqPrRg2NmEHvNL1bR7/+bK9ozqFftNQCuvShqupDQp
         mJXAAMHho1rP+jwP7MfXjR2wktL3lBsZ/ra1xZiUQt8wV0SRw8i+jf2IP5b56Kb+c4v8
         uzBrQCninCQ837+pWJKMDJhsH0oOocY20ds6+oo5pI05UWkVn1Es2AGTNaWSHgOS8caI
         fmo4FAqUbX3bJS3nD9O1n9OsAjDEDKEvZO/HFgQdx09ENSRDpspJlVjk8TsrHOeyBbYZ
         JWvg==
Received: by 10.50.53.199 with SMTP id d7mr4999328igp.47.1349870643419; Wed,
 10 Oct 2012 05:04:03 -0700 (PDT)
Received: by 10.64.143.168 with HTTP; Wed, 10 Oct 2012 05:03:33 -0700 (PDT)
In-Reply-To: <5075615B.8020702@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207405>

On Wed, Oct 10, 2012 at 6:51 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Thanks for working on this issue!
>
> Am 10/10/2012 13:34, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y:
>> +     linkgit:gitattributes[5]). Note that .gitattributes are only
>> +     support for searching files in working directory.
>
> Does this mean it does not work for 'git grep --cached'? That would b=
e a
> real loss.

I missed this case. I don't think it works correctly before as it
reads worktree's .gitattributes instead of the index version. But at
least we support reading .gitattributes from index. Patches coming
soon.
--=20
Duy
