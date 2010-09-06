From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/4] tree-walk: copy tree_entry_interesting() as is from tree-diff.c
Date: Tue, 7 Sep 2010 08:09:56 +1000
Message-ID: <AANLkTimG1JzOtSDKh_BwAMj92iHWCA2bHThVcT2k4bZn@mail.gmail.com>
References: <1283645647-1891-8-git-send-email-newren@gmail.com>
	<1283748429-31076-3-git-send-email-pclouds@gmail.com>
	<AANLkTikmTcKdEjwX+3+BZoV25cJQk=XDC4V03kc5G44s@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 00:10:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsjtQ-0004is-Cn
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 00:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752746Ab0IFWJ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 18:09:59 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59041 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab0IFWJ5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 18:09:57 -0400
Received: by wyf22 with SMTP id 22so3475700wyf.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 15:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oMuS5VVzGnRSDJMCXg7DEvjJ048bYncDJR7Ps6xZ9So=;
        b=e2kr6sWuJLc4Wy3i0M/fQoGdGzWkX/SiWtFQatnOC8R6DsCh2Gxqz7FVP4C4sQ2jiy
         rRFJ149TT9iE5fT6tHVhA8jQzm7iZ4NPT2G6zaLLBfbAOdFXQGwsaQ65qSlQp/BIF3aO
         yOhu6FKCzEquCjcDcstYeEnpiAzfEKg3cpcMo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kBI9sIghLGRtWRr9YimGD8HNf3Pd6J43wRVOIwgidEBMfxhyEYUhw7F+BtDzPnWUvW
         meifANej1xw9An2JqzVyTK0Azt7hX1qcqDaO20KeFUJ6YqQPIhCwbrn9N5wH0PfhQUG6
         sFbhHUp52VvOo/KDthths8JOvgyizvO6gc3y4=
Received: by 10.216.35.74 with SMTP id t52mr1099041wea.41.1283810996338; Mon,
 06 Sep 2010 15:09:56 -0700 (PDT)
Received: by 10.216.184.17 with HTTP; Mon, 6 Sep 2010 15:09:56 -0700 (PDT)
In-Reply-To: <AANLkTikmTcKdEjwX+3+BZoV25cJQk=XDC4V03kc5G44s@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155631>

2010/9/7 Elijah Newren <newren@gmail.com>:
> 2010/9/5 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
>> Just a straight copy. The function is not used anywhere. It is to
>> separate changes that will be made to this function in the next patc=
h.
>
> Why copy instead of move?
>

Right. I wanted to keep it in buildable state at anytime so I made
zero changes to tree-diff.c. But you're right, that should be a move
and make sure the code builds.
--=20
Duy
