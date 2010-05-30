From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Improve error message in rebase conflict
Date: Sun, 30 May 2010 14:44:52 +0200
Message-ID: <AANLkTimiZlampV3xmfCyIhb1wbCUpGGYxtZpEYnmHIr1@mail.gmail.com>
References: <1275222044-511-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Dale Rowley <ddrowley@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 14:45:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIhtI-0006PQ-Gt
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 14:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708Ab0E3MpO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 08:45:14 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56254 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753233Ab0E3MpM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 May 2010 08:45:12 -0400
Received: by mail-gy0-f174.google.com with SMTP id 13so2083993gyg.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 05:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Z/R6KuztdGVSgmluOXIBC8gKa7ONhmfQy9/lv1mucc0=;
        b=wpm53Q/IzQanHYJr1yjuSp1sl1nKWvpv8+k8EEawoighXrf+PY3fMGx0mBwfoPAwEk
         ozhdBHHPAyKX5hT/vR4SAdf7RywV40b4jOdwtEWTzK0xhJKsNhzv0q2e5Hgrs02ErZ8w
         I/b/q7NOn30+cFoW15DKMUpFk3hA9AJYINTyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=c4tJ1DhMWtZM4eRbI4zYMU579eRm1jqq6Zb6MkqezxygBoFyRzx5fOaI1RkqpkBrfK
         agA+Mv3A8b5noWRwVT1Z/lB9/kW0n3vkuEAyMW1cM77ZomnU6ykiPyV+F6RP8+45Agv2
         VtBhZaJojrW3/FCXDHowd5jgTug5YsDkaHvhU=
Received: by 10.150.173.42 with SMTP id v42mr3591015ybe.244.1275223512105; 
	Sun, 30 May 2010 05:45:12 -0700 (PDT)
Received: by 10.151.61.12 with HTTP; Sun, 30 May 2010 05:44:52 -0700 (PDT)
In-Reply-To: <1275222044-511-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148003>

Heya,

On Sun, May 30, 2010 at 14:20, Ramkumar Ramachandra <artagnon@gmail.com=
> wrote:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git diff-files=
 --quiet --ignore-submodules || {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 echo "You must edit all merge conflicts and then"
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 echo "mark them as resolved using git add"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 echo "You must edit all merge conflicts and then" \
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 "mark them as resolved using 'git add'"

Why is this change not described in the commit message? :)

--=20
Cheers,

Sverre Rabbelier
