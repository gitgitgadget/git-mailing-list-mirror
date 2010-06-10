From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] check_aliased_update: strcpy() instead of strcat() to 
	copy
Date: Thu, 10 Jun 2010 19:00:16 +0000
Message-ID: <AANLkTin8kU-Ods3GV3ZpetSdpu0tisipDuWzlqdiCLPT@mail.gmail.com>
References: <AANLkTimPCMbprIKQ__SfMej3oST5agPZ06hM2dkyiUfj@mail.gmail.com>
	<f99f845d5d0aa77b0a95c35f9289f1b031897d43.1276195180.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erick Mattos <erick.mattos@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jun 10 21:00:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMmzL-0005kw-Hc
	for gcvg-git-2@lo.gmane.org; Thu, 10 Jun 2010 21:00:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759596Ab0FJTAT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Jun 2010 15:00:19 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48959 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759500Ab0FJTAS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Jun 2010 15:00:18 -0400
Received: by iwn37 with SMTP id 37so242926iwn.19
        for <git@vger.kernel.org>; Thu, 10 Jun 2010 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=png1UvhPpXjZ+vxWgfs6wSG6DMAXCT1endA1GiQ45ls=;
        b=XtVG//gj5DWVwaWPg9K3WW8TkCG9F6lO6uPUFU5K66ukdf8QraoLQkL0e+Vo3YLlU9
         xQ9vTYOrDmR4F9ZTCQRm3GjligRkV7H/qazTsZwDeTFzHfRHhcv0CIjlJ+aYtemJQbVj
         lZ0evWbQ0+bpICJZMjNPQ3Yh/TYd1xHryJdK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GUBwafP0zVIneRLxVyh1yJxRV3zBOeutWQ/oEqSrIYY/RdI6TsFk7YNxXqouqx2+W4
         St3qcCxxkjbLuoiusnY8BaBNsUHtwR8iIDN1xLIOmolW7oYVdj9PV5Wl2s1KzZ09HPD0
         DXM0jTC74wGKEzQ7FAs+Q5FAPJU2VYKYMiD8c=
Received: by 10.231.194.196 with SMTP id dz4mr566776ibb.66.1276196417197; Thu, 
	10 Jun 2010 12:00:17 -0700 (PDT)
Received: by 10.231.155.144 with HTTP; Thu, 10 Jun 2010 12:00:16 -0700 (PDT)
In-Reply-To: <f99f845d5d0aa77b0a95c35f9289f1b031897d43.1276195180.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148910>

On Thu, Jun 10, 2010 at 18:43, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> da3efdb (receive-pack: detect aliased updates which can occur with
> symrefs, 2010-04-19) introduced two strcat() into uninitialized
> strings. =C2=A0The intent was clearly make a copy of the static buffe=
r used
> by find_unique_abbrev(), so use strcpy() instead.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> Reported-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>

Tested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

This fixes the problem I was having. Thanks.
