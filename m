From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] grep: add option to show whole function as context
Date: Mon, 1 Aug 2011 17:39:37 +0200
Message-ID: <CAGdFq_go0xYy9BZWRDxAFGV95G7V-P9-=7VhsodLd+z-ho09Qw@mail.gmail.com>
References: <4E357BE2.8030409@lsrfire.ath.cx> <CAGdFq_ikKu2E44tyadtKNS=GNRw_1qkfFN-UxEtz-Rsv__Z+jg@mail.gmail.com>
 <4E36C840.9000808@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Aug 01 17:40:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnubO-0000Oh-Vm
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 17:40:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752983Ab1HAPkT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 11:40:19 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:37020 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752883Ab1HAPkS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 11:40:18 -0400
Received: by pzk37 with SMTP id 37so11695820pzk.1
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 08:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=CKQG1uQ0FasvFOuKkDpR+3z9XEle5iKSbKxLz540cL0=;
        b=CcdADWo4KQHCY9fpsXEcMU4Mfk4r2aw0MdwQzaA6cVBVbLlH6FrJPkV3uj+94JdLRW
         6xjrj7ycnggMx0LT7G9k3VViu1GTiGs9sgrG1djQ9lr7P4j2bh9ebYVQoPttKxbASwma
         HdxyU5ZiDoyQ+Dw96zVj+5WvBRyuSW5N2WKYg=
Received: by 10.68.11.131 with SMTP id q3mr1001110pbb.511.1312213217163; Mon,
 01 Aug 2011 08:40:17 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Mon, 1 Aug 2011 08:39:37 -0700 (PDT)
In-Reply-To: <4E36C840.9000808@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178352>

Heya,

On Mon, Aug 1, 2011 at 17:37, Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.a=
th.cx> wrote:
> Do you mean a diff option to show whole affected functions as context
> instead of the fixed number of context lines -U gives you? =C2=A0That=
 sounds
> useful as well.

Exactly.

> How about -W? =C2=A0It's not used by GNU grep either.

Why not give it an easy-to-remember long name instead?
--show-function-context or such :)

--=20
Cheers,

Sverre Rabbelier
