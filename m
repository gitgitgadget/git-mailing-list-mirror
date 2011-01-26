From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't find the revelant commit with git-log
Date: Wed, 26 Jan 2011 20:50:30 +0100
Message-ID: <m2lj27zbp5.fsf@gmail.com>
References: <m2ipxd2w78.fsf@gmail.com> <4D3EF650.20407@lsrfire.ath.cx>
	<m2y668yr6k.fsf@gmail.com> <4D406A64.1000200@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Jan 26 20:50:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiBOI-0003MQ-8F
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 20:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880Ab1AZTuh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jan 2011 14:50:37 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:42715 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867Ab1AZTug convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jan 2011 14:50:36 -0500
Received: by wwa36 with SMTP id 36so1357821wwa.1
        for <git@vger.kernel.org>; Wed, 26 Jan 2011 11:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:references:mail-followup-to
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=/KpOKAQBSg2Z4G6bM/dXuLNOuo6CnZa7hiQZaOtJq8Q=;
        b=SCK0Mxa9oenbquV7eNZCnJK1v73+2kuYY0H/QMv+UcJXnLkLk3oxrAML+mWMRh3GTU
         fQSw64812rmJdNp3NmmgsCxqTg+AelNlHFE/oSw1FQururdRIGrWjJEqH9GbfbK2OGXC
         w40OO0XkY03alk8VAiCNgikXvSASpPZS2nx2Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:mail-followup-to:date:in-reply-to
         :message-id:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=mu834MU4nRSwmO75wktK962omtTKhlkan5hl2pScXfXaxrkghYnznUrUNzaAYA4z9c
         VKDjB0vAmvsNjj2N37ogu7anVvMYHAcu+1ynr6NAis2kie6cGXwd92RhlOYHJaZHfieX
         zmG/SCwIJ8MH09e6e0vdIOytLQfPfk0/qEUgs=
Received: by 10.227.177.207 with SMTP id bj15mr1739953wbb.229.1296071435078;
        Wed, 26 Jan 2011 11:50:35 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id f35sm11206345wbf.8.2011.01.26.11.50.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 26 Jan 2011 11:50:33 -0800 (PST)
Mail-Followup-To: =?iso-8859-1?Q?Ren=E9?= Scharfe
 <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
In-Reply-To: <4D406A64.1000200@lsrfire.ath.cx> (=?iso-8859-1?Q?=22Ren=E9?=
 Scharfe"'s message of
	"Wed, 26 Jan 2011 19:39:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165535>

Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 26.01.2011 10:01, schrieb Francis Moreau:

[...]

>>     error: The following untracked working tree files would be overw=
ritten
>>     by checkout:
>>        arch/x86/es7000/Makefile
>>        arch/x86/es7000/es7000.h
>>        arch/x86/es7000/es7000plat.c
>>        drivers/pci/dma_remapping.h
>>     Please move or remove them before you can switch branches.
>
> These are untracked files; your tree is not clean.  Either commit the=
m,
> stash them away or delete the files.  Or make a local clone just for
> bisecting purposes.
>

Hmm, I'm wondering how those files get there...

Maybe they are some left from some git commands which failed, I dunno.

--=20
=46rancis
