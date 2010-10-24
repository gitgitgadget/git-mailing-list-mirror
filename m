From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 0/4] update-index: migrate to parse-options API
Date: Sun, 24 Oct 2010 19:50:44 +0700
Message-ID: <AANLkTik9OtRvB2P7OFFsYoUsPjdM8FofKVtGRt+VFQpm@mail.gmail.com>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-4-git-send-email-pclouds@gmail.com> <20101022063837.GA6081@burratino>
 <20101022064258.GB6081@burratino> <7v8w1qnkr1.fsf@alter.siamese.dyndns.org>
 <20101024072032.GA23455@burratino> <20101024081316.GA29630@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephen Boyd <bebarino@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 24 14:51:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PA02d-0001ZN-Ne
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 14:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581Ab0JXMvH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Oct 2010 08:51:07 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:60117 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932478Ab0JXMvG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Oct 2010 08:51:06 -0400
Received: by wwe15 with SMTP id 15so2557249wwe.1
        for <git@vger.kernel.org>; Sun, 24 Oct 2010 05:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Au+CYaXnQJ2j+iq2pbQaiQKhL6kYIiw9BTECCukikFo=;
        b=qfiwGS4EB4vmjNerlzOu3NqbBUyBunTRQMt+lqs3HPeE8evvCoukrpc/Q8NEv5Olb+
         /m5O7Sv9+onOuDy0uT+L4A87/839jS4ZBehbTmYWlKAOScSzUIMTGzj80hfJcdn09+Tm
         9JAq8TRd6fTLKyqDtNw91k6lanqyn6Iy8yW+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uu0TBqwNAkE9XpZOfGAmY9Ttmyi1Ydy+QfnD8uNHblFjq6Nzu0/3mBp9sn8eYs4R93
         zRAim3d6OOK/anowd/+kbq2xRLI6F6pi53y4EWxPWVU4b5WWATVqLQi0xQmf5ZU+IGip
         roDpZzuvkisWCzfsFLf4cifh2EXx29c1l/oOM=
Received: by 10.216.1.149 with SMTP id 21mr1748044wed.10.1287924664596; Sun,
 24 Oct 2010 05:51:04 -0700 (PDT)
Received: by 10.216.241.138 with HTTP; Sun, 24 Oct 2010 05:50:44 -0700 (PDT)
In-Reply-To: <20101024081316.GA29630@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159875>

On Sun, Oct 24, 2010 at 3:13 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Jonathan Nieder wrote:
>
>> Here's a helper to make it easier for commands that use parse-option=
s
>> to adopt that nicer behavior. =C2=A0It writes its output to stdout, =
so it
>> should only be used to be used to handle the -h option.
>
> Alas, "git update-index" does not use parse-options yet. =C2=A0But th=
at
> is easily enough changed...

I don't know parse-options well enough to give comments. If I did, I
would have converted update-index long ago (hit it a few times and
always ran away). Thanks for the conversion.
--=20
Duy
