From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Unify the name of the second option in the text
Date: Sun, 03 Feb 2008 04:04:34 -0800 (PST)
Message-ID: <m3y7a25jqt.fsf@localhost.localdomain>
References: <1201996688-5559-1-git-send-email-joerg@alea.gnuu.de>
	<1201996688-5559-2-git-send-email-joerg@alea.gnuu.de>
	<1201996688-5559-3-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Sun Feb 03 13:05:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLdb1-0005Aq-43
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 13:05:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759133AbYBCMEj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Feb 2008 07:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758269AbYBCMEj
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 07:04:39 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:61641 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbYBCMEi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Feb 2008 07:04:38 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1631949fga.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 04:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        bh=z/n15FjM8wvGWaerfjiKpahmcbp2e/AZ8YLPxuInUlQ=;
        b=WINrtLLsiX69ETdCSZy+lTzpiIbrTRwsLSvT2hB8VzVeL7TsllWJiHvfbst6SO4HJQqh2AQeV7Yyr4Y2hOGfvLZeruEzYXdJkFMDO4ZgyeDtCbGwHPV6dkyeDqzvX3B6ytDX1RqKNbkpHMckVjEaoSLYBtGSwzSeXdkhQK43nhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        b=Bma5AqgaA28TXgZFdPt5WUvGZTOkEufqRSRdVUx3bLXwnWlh/yC/zR+e/T52pGkFv+w4IIm3LWZ/nFgXitAt0dA27E2taJqz29zk2KYKSNvkzUlylrhYEL3obK/HjNQCS+YOWGCjlOx/85U0CwDJiEl3BkgoSCj45aNHrdUgVHI=
Received: by 10.78.205.7 with SMTP id c7mr10032794hug.29.1202040275786;
        Sun, 03 Feb 2008 04:04:35 -0800 (PST)
Received: from localhost.localdomain ( [83.8.194.189])
        by mx.google.com with ESMTPS id c14sm16068645nfi.6.2008.02.03.04.04.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Feb 2008 04:04:34 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m13C4TtG004390;
	Sun, 3 Feb 2008 13:04:29 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m13C4QYq004387;
	Sun, 3 Feb 2008 13:04:26 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <1201996688-5559-3-git-send-email-joerg@alea.gnuu.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72353>

J=F6rg Sommer <joerg@alea.gnuu.de> writes:

> Signed-off-by: J=F6rg Sommer <joerg@alea.gnuu.de>
> ---
>  Documentation/git-push.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 5f24944..18e0c06 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -53,7 +53,7 @@ side are updated.
>  +
>  `tag <tag>` means the same as `refs/tags/<tag>:refs/tags/<tag>`.
>  +
> -A parameter <ref> without a colon pushes the <ref> from the source
> +A parameter <refspec> without a colon pushes the <refspec> from the =
source
>  repository to the destination repository under the same name.
>  +
>  Pushing an empty <src> allows you to delete the <dst> ref from

Err... that is incorrect without further surgery. <refspec> is either
<ref>:<ref>, <ref> or some other exotic case; in the form <ref>:<ref>
it can include globbing. The fragment above talks about situation
where <refspec> is <ref>, and does not contain colon.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
