From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCHv2 27/56] string-list: Add API to remove an item from an
 unsorted list
Date: Fri, 12 Aug 2011 11:27:40 +0200
Message-ID: <CALxABCZj385GOZK=8+tsc=hDbRi-R0ULO4E8q7-ntXg__wJMtQ@mail.gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
 <1313126429-17368-28-git-send-email-newren@gmail.com> <4E44CF9D.8030501@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elijah Newren <newren@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Aug 12 11:28:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qro2D-00074f-FS
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 11:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385Ab1HLJ2F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Aug 2011 05:28:05 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:47734 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074Ab1HLJ2B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2011 05:28:01 -0400
Received: by bke11 with SMTP id 11so1523494bke.19
        for <git@vger.kernel.org>; Fri, 12 Aug 2011 02:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=8Asfiq5xaMEIDU01cJdeLLyG8PHjrXg3dwJgQAXREdM=;
        b=wVi+20F6neTUrqaACNutbSQLTKeDDFXC0safYRStKDo/gQJSY6ERLr7UsXUD5uxeAm
         NUDQLUwuqEiaxQej68qeoHshedwoTg3sQbvilNDe48/d6q0gyRQoFV5Gr46veA5McY8d
         c8OKLvKHI3mKc93uZDosvELYJY7dFdafE5DPI=
Received: by 10.204.177.196 with SMTP id bj4mr252345bkb.135.1313141280446;
 Fri, 12 Aug 2011 02:28:00 -0700 (PDT)
Received: by 10.204.118.71 with HTTP; Fri, 12 Aug 2011 02:27:40 -0700 (PDT)
In-Reply-To: <4E44CF9D.8030501@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179222>

On Fri, Aug 12, 2011 at 09:00, Johannes Sixt <j.sixt@viscovery.net> wro=
te:
> BTW, the code does this:
>
>> + =C2=A0 =C2=A0 list->items[i] =3D list->items[list->nr-1];
>
> i.e., it assigns an entire struct. Is this perhaps problematic with o=
lder
> C compilers? (I don't know, I'm more used to C++, where this is well-=
defined.)

Unlikely. As long as I can remember it always was a memcpy-like operati=
on.
