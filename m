From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] blame: prevent a segv when -L given start > EOF
Date: Mon, 8 Feb 2010 22:50:11 -0500
Message-ID: <76718491002081950g52b3dae7ta22377dfdd3479df@mail.gmail.com>
References: <1265687293-11168-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <junio@kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 04:50:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Neh7F-0008JR-6V
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 04:50:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753681Ab0BIDuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 22:50:14 -0500
Received: from mail-iw0-f182.google.com ([209.85.223.182]:53817 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753601Ab0BIDuN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2010 22:50:13 -0500
Received: by iwn12 with SMTP id 12so8153126iwn.26
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 19:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=HFlOnp+I7rpfphJuhAoyvXkrzSjU6U5oSkPYL+TylZE=;
        b=tj59xB9LA7lbW0eUm00W4GAtxrUfMnM0UQx1FNDoNVAvhAa21G4UUo1xLARn1+Oqs2
         iOiRMXUyyWeuygS/7on/zTgJv5fgyPj4YXBCS+L3Jvhmv/D6iv932+3zoYwGnM5q79NL
         R+cWq4FgcAVgkSEYEEdHqDWS+O3thQTVuSgbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=BfDx2Fvi6xmAnG9kQfPdrPSpxATYAkdL7NjOVb+jveCK9urEhcQUFSVP7/UuKSDePY
         WB8KRALmBgpe55RzDFfDGtYSIuNSOLOneIvC7ctTD/iJKPfM0xlWvLHCEcaP1xbeLMVH
         zfCUBPSIsBBmuAWLcf6MJ4M93YZc3T8sZT8No=
Received: by 10.231.154.207 with SMTP id p15mr78278ibw.91.1265687411351; Mon, 
	08 Feb 2010 19:50:11 -0800 (PST)
In-Reply-To: <1265687293-11168-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139356>

On Mon, Feb 8, 2010 at 10:48 PM, Jay Soffian <jaysoffian@gmail.com> wro=
te:
> +test_expect_success 'blame -L with invalid start' '
> + =C2=A0 =C2=A0 =C2=A0 test_must_fail git blame -L5 tres 2>&1 | grep =
"has only 2 lines"
> +'

Sorry, please remove test_must_fail after applying. Otherwise correct.

j.
