From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 02/34] Add t1510 and basic rules that run repo setup
Date: Wed, 27 Oct 2010 22:37:51 +0700
Message-ID: <AANLkTiknZEp8EoHr6auqUQQsMj+MvLwhUYxzUD9N-6L4@mail.gmail.com>
References: <1288190977-30875-1-git-send-email-pclouds@gmail.com> <1288190977-30875-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 27 17:38:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB84y-00085A-3B
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 17:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273Ab0J0PiP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Oct 2010 11:38:15 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59430 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab0J0PiN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Oct 2010 11:38:13 -0400
Received: by wwe15 with SMTP id 15so923766wwe.1
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 08:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=0PmM0Evtz4jqP3SVg5ENw4dP5Qk0tdxjYIj37NXdbV8=;
        b=lEGfG5pQMnqjSjER7kDpVgLHtAcYP5+y1ACn6ixGNB9i3xzvQj8h8zpaG9Jbm0UMnn
         uGOIXKdS0v5zjoZXVdld9Fg5U4B519SJ7ijqjz84A1248p9nBnP91JPwjNc+AB5MZuZU
         la56uXMI/GvllciUcGB08llyJ112n7WhC5qLY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=J2KFBm7DptxLLwf0sgW8GRgHXE3DA02aKcD/iOVgH4LkQr1ik6w0BBn3vUrgtINOA+
         V4qGn80yNgXD+iUnzwKFtOOyGjywiDq2CFzYxXuYbxoRouBBtNVnI3YpKB+FlvEB6VH2
         hRI0+NfCrzkFwoU6/kv0y04wIspydjH2R7lCY=
Received: by 10.216.180.74 with SMTP id i52mr1009373wem.79.1288193892328; Wed,
 27 Oct 2010 08:38:12 -0700 (PDT)
Received: by 10.216.241.138 with HTTP; Wed, 27 Oct 2010 08:37:51 -0700 (PDT)
In-Reply-To: <1288190977-30875-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160092>

2010/10/27 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>:
> +# 2. .git file is relative to git_dir. .git file is basically symlin=
k
> +# =C2=A0 =C2=A0in disguise.

This is not completely followed in my tests. If .git is a true
symlink, its link is relative to .git itself. When .git is a file, it
would be more difficult to calculate path relative to .git (you can't
chdir to a file). In my tests, the link is relative to .git's parent
directory, not .git.
--=20
Duy
