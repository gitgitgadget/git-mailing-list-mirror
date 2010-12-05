From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] commit: Add commit_list prefix to reduce_heads function.
Date: Sun, 5 Dec 2010 10:23:14 -0200
Message-ID: <AANLkTikxibh4QkxzokhBYQ+dMS3W6PkDaDLuqm5qN+6v@mail.gmail.com>
References: <a3f4bdc2d5f5d13c772a82de9afe2691b8a12863.1291514223.git.tfransosi@gmail.com>
	<7vsjycx05o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 05 13:23:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPDcg-0003oo-Nh
	for gcvg-git-2@lo.gmane.org; Sun, 05 Dec 2010 13:23:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170Ab0LEMXR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Dec 2010 07:23:17 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62094 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755062Ab0LEMXQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Dec 2010 07:23:16 -0500
Received: by bwz15 with SMTP id 15so9747045bwz.19
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 04:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PLsOu7BdafD9SbYKCKdFN+WFq+iukbgX9RpO1EFhUW4=;
        b=FjNbTxtKSBI4rNXJd+p6IBGunivXi6+XENfNlmPc5hLvXQ88sd6IYlumCEIOeFLl4U
         i5gw9aSt1Kp0keDPwJ+HOewNxzUhONsBS+HoHOUX6fNJ/vJgHJwmSJLxTirfdWL8NmK9
         vTmY08L51vkHckYJd7ppmMQdh+9m/3DmpI9I0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cBpZDFtXOi64gRapP95sDgKcPiezubKHcrmL/W9qEi6aKtu8azQ3HfNHic8NoKI4nb
         JFMicdDvh98H9xgfv28nG1GzK+l9Zpy1Eea7vUU+IJU1q+0PIgH9pYfeHxO8PVRDvLuw
         QMwJhZVt49MZVtAVmzaplRmk9g+P2zxxfLwJQ=
Received: by 10.204.60.66 with SMTP id o2mr4663521bkh.13.1291551794759; Sun,
 05 Dec 2010 04:23:14 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Sun, 5 Dec 2010 04:23:14 -0800 (PST)
In-Reply-To: <7vsjycx05o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162946>

On Sun, Dec 5, 2010 at 3:24 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Thiago Farina <tfransosi@gmail.com> writes:
>
>> Signed-off-by: Thiago Farina <tfransosi@gmail.com>
>
> I really do not like this.
>
I don't feel very strong about it. And as I learned from Jonathan, I
don't care if you will take or not. I think my intention was good, but
I can't please everybody

I was just trying to put commit_list in a better shape and resemble it
in a more explicit API.

> The use of type "struct commit_list" to hold the set of parent commit=
s is
> incidental; if we had "struct commit_set", we would have written a
> function with the same purpose, and named it the same "reduce_HEADS".
>
> Adding commit_list to the name makes the code harder to read (and typ=
e)
> with little added benefit. =C2=A0"LIST"-ness is not the important par=
t.
>
> If a function takes a commit_list, named "reduce_HEADS",

What? reduce_HEADS ? HEADS with CAPSLOCK?
