From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 14/22] refs/files-backend.c: mark strings for translation
Date: Tue, 1 Mar 2016 17:40:07 +0700
Message-ID: <CACsJy8Agex+c4Neg7OduwAKzZ8uCPg4VHhT3=9iwPwxE49thvw@mail.gmail.com>
References: <1456555333-5853-1-git-send-email-pclouds@gmail.com>
 <1456555333-5853-15-git-send-email-pclouds@gmail.com> <xmqqfuwbbbmi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 11:40:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aahjP-0002V2-Cz
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 11:40:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752358AbcCAKkj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2016 05:40:39 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:36526 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090AbcCAKki convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Mar 2016 05:40:38 -0500
Received: by mail-lf0-f54.google.com with SMTP id l83so63051497lfd.3
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 02:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KfZKIdybHlRB8iOo9bz09q6a5Ufn1LEZgtwFEXVuSNw=;
        b=K3nUHqgU6b1Suv5QfGa+7TcV6qzXmyDgRYL8xUjTUSOtG+24i3MRYQ+EBKXdiZc9+N
         RDUF/k2Ew7V26HhNoN5P3fB1eo8dmAQe37ci9rBye3Njt56FCikn+sLYi2UbwuTuBwzT
         EnyIFosmQVUPdZsIxy+QeJOWpnNzHNrtr91Gab5KtVr7vWR71TVCelOdvIhSf07YdvKK
         kvBgfpTiFFYP6Zyxfioz4+Nsx8e+IkqT5MGHEZLaLrBDzRLZEWfqFhQOiS876i+t3sa3
         PYMC2KOWk8m8Q2i1e5ougc40fhBkAT71jDBzo/vwj1rZam+Re3H+4KXajW0M+hVM4a0S
         jxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KfZKIdybHlRB8iOo9bz09q6a5Ufn1LEZgtwFEXVuSNw=;
        b=Is5x59HipOMDVWRwUZ3fThRq4l3cJtSFJxjcHSx8I7iDcQTAq8ZBJVKGfA+lErWO1V
         JeMA1iVPvJiHukO22DjGcbowlH4DF5m7LvY+VDaxAVWjekMviZXT3YmX+JjSf65vLvC+
         thnuY19YqAOstksAe+Z7Z9kzxaoA054KJhbvwVCxLYhHLqNI0y8waC3N4f7g2z8Om94O
         SlL60gVSJ6NYUkzl67u7VT5mTf9V9Bn6U/HygnSUHftvc7mzYptDTCbLHB8t+gXw93E3
         VGNUwGOGYMUjMlwULmB1jZ1O+1n98LM+PuWNkbZCULwIoxhDC5o7yoOzrDskwfj9Tr/P
         Xunw==
X-Gm-Message-State: AD7BkJKk7/jQlIy/XvRdK/n4kgmDg0UW+QX7Z6qCceZZU+IJCgkYHY2wmnz5QYuWc9tfI5rU9kW+bnLtaC9niQ==
X-Received: by 10.25.159.68 with SMTP id i65mr7594813lfe.94.1456828836639;
 Tue, 01 Mar 2016 02:40:36 -0800 (PST)
Received: by 10.112.51.99 with HTTP; Tue, 1 Mar 2016 02:40:07 -0800 (PST)
In-Reply-To: <xmqqfuwbbbmi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288005>

On Tue, Mar 1, 2016 at 1:43 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> I'd really prefer to avoid any code churn on this file before the
> dust settles for David's and Michael's series (the former is in
> 'pu', the latter is not but was already rerolled once) both of which
> touch this file heavily.

Yeah. I actually dropped a patch on fetch-pack.c because my series
shallow-deepen also changes a lot there, then somehow I forgot that
David's series moves a bunch of refs code around. I'll keep an eye of
those series and resend once they enter 'next'.
--=20
Duy
