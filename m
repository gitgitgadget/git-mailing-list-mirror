From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: Re: Git Fetch / updating HEAD
Date: Sat, 17 Jul 2010 21:05:38 +0530
Message-ID: <AANLkTilp5lZn99QZPWSkCHStnRdkGx6mMU2IQBvllaU4@mail.gmail.com>
References: <AANLkTinuK4gx9SG1VKo_NbkP_QWMCmtsfJgUgfoL_KGo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 17 17:36:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oa9Qp-0003Pm-Qv
	for gcvg-git-2@lo.gmane.org; Sat, 17 Jul 2010 17:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760007Ab0GQPf7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Jul 2010 11:35:59 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39634 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755998Ab0GQPf6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jul 2010 11:35:58 -0400
Received: by gwj18 with SMTP id 18so1519719gwj.19
        for <git@vger.kernel.org>; Sat, 17 Jul 2010 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=d1yhJ03BAjn4nbOtO4QiS9oIo2ixqqRqTzilXXkFhsY=;
        b=bPiYATre3Iy2s5gf6mKZ1Rp/N+YRf2Z+9MJzXPrkbX3A3cxdy7WuOkPgDLNXmCv/i+
         n6pfbM8a1bqHLc/FIvO09XpWNJTlAFAxzrywyIvIA1169KupfzXgKiprMNRwVlU11w7I
         E6dCa4skYrVefxpUI9woTjGOmgRwoPaNnYvW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=m6VLzvtOuMMC1oNNLzC65vD/iRfML9BchejzeUV0mkbYyo2qhkCfTttlVoY3iJtjs+
         +SCSlzLEkm8/6oTO97i6fsOvafC3rsKOPFZQYS5YqyJihtZRhbBxEfQviMfOA8lQx5ZO
         jsiCENhi3g91BkmY+88JN18jyQOxZpjwlt190=
Received: by 10.90.115.2 with SMTP id n2mr1664278agc.199.1279380938843; Sat, 
	17 Jul 2010 08:35:38 -0700 (PDT)
Received: by 10.90.33.8 with HTTP; Sat, 17 Jul 2010 08:35:38 -0700 (PDT)
In-Reply-To: <AANLkTinuK4gx9SG1VKo_NbkP_QWMCmtsfJgUgfoL_KGo@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151188>

BTW - I have tried this
git  update-ref HEAD  FETCH_HEAD; is this ok ??


On Sat, Jul 17, 2010 at 9:02 PM, Mahesh Vaidya <forvaidya@gmail.com> wr=
ote:
> Hi,
>
> git fetch --all --append updates FETCH_HEAD. I'd like this command to
> update HEAD as well; is there any flag ?
>
> I have a reason to do it; trying to implement multisite
>
> A (master) -> B (readonly mirror) -> C (workspace)
>
> if sitting in B; git fetch does't update HEAD
>
>
> Mahesh Vaidya
>



--=20
Thank you and best regards.
Mahesh Vaidya=A0 / 9740500144
http://www.twitter.com/forvaidya
