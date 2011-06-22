From: =?UTF-8?Q?Dominik_=22Socek=22_D=C5=82ugajczyk?= <msocek@gmail.com>
Subject: Re: Git svn dcommit -> ignore one commit
Date: Wed, 22 Jun 2011 12:29:14 +0200
Message-ID: <BANLkTikD6ci-iohWcTes+njpK-rTUHhMkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 12:29:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZKgT-00078Y-CF
	for gcvg-git-2@lo.gmane.org; Wed, 22 Jun 2011 12:29:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664Ab1FVK3Q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jun 2011 06:29:16 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45145 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab1FVK3P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2011 06:29:15 -0400
Received: by gwaa18 with SMTP id a18so253413gwa.19
        for <git@vger.kernel.org>; Wed, 22 Jun 2011 03:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=6OIhE1OrRojlWna+GVY1gx5PSb7S6PwJcoaHSc2gS3A=;
        b=cvxAfcoxl5C49hjHFkVbayB+/DwjAx3BpeWFV7YN/6PCP579OUiX6wWh1S9oDNHVtQ
         B4Kz3DBCVPaS8wFtzy990JL/d5kLfLoc8xs3mDWPKg9DVaRyeZdQ8g02VS4Gh+banLVg
         fmVmRt1a2BvS/Bcyp85ERxXtZYlFTDwXL7gd4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=H1BJCWDsHzwI9kZAfdWw/JKWvk7lr7QdLobcM6G1vCHNZc20XeKNGnRCW0SEgksFeU
         +ui3qcqLa7qMPG8wjfaZSgqehu0d49Grxm+T0pQUuneZ0woj23YPFG9OhN9mTimBlJTW
         JtwCeyWmGLScxw0XtmBzb4KzLOb7Y2ylGcAZY=
Received: by 10.101.105.27 with SMTP id h27mr571189anm.118.1308738554984; Wed,
 22 Jun 2011 03:29:14 -0700 (PDT)
Received: by 10.100.198.13 with HTTP; Wed, 22 Jun 2011 03:29:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176232>

> You can probably use "git svn set-tree" for the commit after the one =
you
> want to ignore. Test on a dumb repo before doing it in production ;-)=
=2E
>
> --
> Matthieu Moy

I have tried it, but when we use set-tree, all the files need to be
synchronized. Folder with submodule can not be synchronized:

g svn set-tree 45d8cc5dfec08747d8176966eb6d0d517fa70159
	A	INC/app_events/webroot/js/sharedjs
ccff2965f5602d8a9620d5dd8da1a3c015b88725 doesn't exist in the
repository at /usr/lib/git-core/git-svn line 4801
=46ailed to read object ccff2965f5602d8a9620d5dd8da1a3c015b88725 at
/usr/lib/git-core/git-svn line 3508

I do not know what to do.

--=20
Pozdrawiam
Dominik "Socek" D=C5=82ugajczyk
