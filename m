From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v13 5/8] bisect: introduce --no-checkout support into porcelain.
Date: Tue, 2 Aug 2011 14:04:37 +0200
Message-ID: <CAP8UFD3XzUjxiz6QQzyTOYzfiWrF4ckiv0h+gvi7YuZkma6yiw@mail.gmail.com>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
	<1312284545-2426-6-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com,
	j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 14:04:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoDiF-0002gM-D4
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 14:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119Ab1HBMEj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Aug 2011 08:04:39 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:55678 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073Ab1HBMEi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Aug 2011 08:04:38 -0400
Received: by yia27 with SMTP id 27so4008353yia.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 05:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9xK5aGmi7kaCcl6x/kM0yq0M+DC0phraBJnszeBlr7U=;
        b=KbEl4ppYXOerUzUaVSutfsO8rq8patZAZUp6rMzi3FOKGzPan+8evMFNGbfUQohzin
         4iThFSMBxL3MU2OF8ej0kX8ws1hh28JogqvoKbly6akkoLVKhIidk6ziliJUbeBC0ZEk
         zila4A7sjyUJYssUR7wF3BF0CGN6SNmepQ9yA=
Received: by 10.236.185.132 with SMTP id u4mr4461438yhm.224.1312286677539;
 Tue, 02 Aug 2011 05:04:37 -0700 (PDT)
Received: by 10.147.35.16 with HTTP; Tue, 2 Aug 2011 05:04:37 -0700 (PDT)
In-Reply-To: <1312284545-2426-6-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178462>

On Tue, Aug 2, 2011 at 1:29 PM, Jon Seymour <jon.seymour@gmail.com> wro=
te:
> @@ -34,6 +34,8 @@ require_work_tree
> =A0_x40=3D'[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
> =A0_x40=3D"$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>
> +BISECT_MODE=3D$(test -f "$GIT_DIR/BISECT_MODE" && cat "$GIT_DIR/BISE=
CT_MODE")

Could you put this line just where it is needed, that is in
bisect_next() and bisect_reset()?

Thanks,
Christian.
