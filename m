From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 14/20] Add test_repo_expect_success for running tests in a
 new repository
Date: Tue, 29 Dec 2015 21:12:02 +0700
Message-ID: <CACsJy8BNc57vJaVWKE_sEPj1dvkxYppHPUSEB1S1GMBsdJbjUw@mail.gmail.com>
References: <1451391043-28093-1-git-send-email-pclouds@gmail.com> <1451391043-28093-15-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 29 15:12:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDv11-0007Uc-Di
	for gcvg-git-2@plane.gmane.org; Tue, 29 Dec 2015 15:12:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753282AbbL2OMe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Dec 2015 09:12:34 -0500
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36309 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817AbbL2OMd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Dec 2015 09:12:33 -0500
Received: by mail-lb0-f171.google.com with SMTP id oh2so103991814lbb.3
        for <git@vger.kernel.org>; Tue, 29 Dec 2015 06:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RGhZ0vF5tVY4LBrcqMedswfX5+V46vInEYzFSK8A8Hk=;
        b=gPj4zVbdit6kDbvQN76/XE39Kh5BDmzmb9aP1s5r45MSaWBLbYaDGxAYkhS3SDHGzn
         GpPTTJI/N31bM1qTrooajileaeh7IzYmwV0MKUeOUhQGK4xy+fojvDtydO7mHDERdTo3
         z5tC0qUDzs8o9TJfDDv99m+o19rNu7pRb4mi0WNHUtmPmr6kYbHh6LOziHQwvVnEGgxn
         N+D1l2lkE8Qu5r/S0RYs8t/479HrPpid+ppP7q4dGDTX4TB4S7PAy5Xch3FZQ0G/YSrl
         /IwcL1/ABvduGqTIh2DDj6Oh09sfu9OxksZ551gPTaU8abpJLaQGFwglW0jgpKjU7zVL
         nLMA==
X-Received: by 10.112.141.97 with SMTP id rn1mr951402lbb.80.1451398351935;
 Tue, 29 Dec 2015 06:12:31 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Tue, 29 Dec 2015 06:12:02 -0800 (PST)
In-Reply-To: <1451391043-28093-15-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283133>

On Tue, Dec 29, 2015 at 7:10 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> This could be convenient when tests are independent from the rest in =
the
> same file. Normally we would do this
> ...

Before anybody comments about this patch. I missed Junio and Jeff's
comments when the patch was posted separately a few months ago (what
was I doing in September??). I just found this out after some random
search, so this patch may get dropped (or may stay in a different
form).
--=20
Duy
