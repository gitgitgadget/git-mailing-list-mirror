From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 38/42] Remove all logic from get_git_work_tree()
Date: Sat, 30 Oct 2010 11:38:38 +0700
Message-ID: <AANLkTim1PBO3TELnRzAGXYK3B0cshzQCwj0udUncfpRb@mail.gmail.com>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
 <1288334934-17216-39-git-send-email-pclouds@gmail.com> <AANLkTim-uW4Esk1bkPzNNGRb8svZoNwCUvXF3Fqb4QmR@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 30 06:39:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PC3De-0008Lk-OB
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 06:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912Ab0J3EjB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Oct 2010 00:39:01 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50665 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731Ab0J3EjA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Oct 2010 00:39:00 -0400
Received: by wyf28 with SMTP id 28so3784924wyf.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 21:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=g/Lt5tYbUJdwzHIYBr5y2ZJulAhN0eaMSHgjX6MPLag=;
        b=ieKnDHBK6NurLmS+uLcZC9Ctd1BKsJxPUdj0o81KXuZeZMpfkWyQru/fflN9FFPk2Q
         7nYRMMCFz9V9bPcxAK0EgP7qc6JlNDOkUoQp1kJ+6lIsfZ/FHt3w82wnue9FP2ju/mLX
         EgZG5Iq+8ofZTjMvR+2bYLHEqSdyLu96QxZB4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NY6hCvO1NsayFRxQDfQuNZHwfxxNt5DtQVrkjhZJQK+MwZ6PpICzq2TqErspZioEW9
         m92QDiq5044CLEAcnEBQ0tXC8QDg/PcZSjJSfUx0hBAh3pgRSMC/v943zKEqvzojnsgb
         38vrESWuYJ31QHyQ6mhFi44d64OgiOGi/9Bwc=
Received: by 10.216.49.145 with SMTP id x17mr1720358web.55.1288413538758; Fri,
 29 Oct 2010 21:38:58 -0700 (PDT)
Received: by 10.216.135.77 with HTTP; Fri, 29 Oct 2010 21:38:38 -0700 (PDT)
In-Reply-To: <AANLkTim-uW4Esk1bkPzNNGRb8svZoNwCUvXF3Fqb4QmR@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160386>

2010/10/30 Sverre Rabbelier <srabbelier@gmail.com>:
> Heya,
>
> 2010/10/28 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>:
>> This helps break things some more. Eventually all repo setup logic
>> should be centralized in setup_* functions. This helps push all the
>> bugs back to setup_* functions.
>
> I don't know about this, do we really want to willingly break the tes=
t
> suite (and fixing it later)? Perhaps we can review this as-is and the=
n
> squash the commits before they are merged to next so that there is no
> breakage? We could even attach the original commits as notes :).

Squashing is no good in terms of readability when we look back in
history. Can git-bisect be taught that "there is breakage in this
segment of commits, consider the whole segment a single commit"?
--=20
Duy
