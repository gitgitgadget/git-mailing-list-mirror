From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] doc: technical details about the index file format
Date: Sat, 19 Feb 2011 23:16:03 +0100
Message-ID: <AANLkTi=YJkk6KHChCrrazij_ziyG-Ru7kGLWc7JnUGoN@mail.gmail.com>
References: <AANLkTi=iFe=MmUiXzC_HMwueZxLJDCea+zp_-SNWvSup@mail.gmail.com> <1283769430-9263-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kusmabite@gmail.com, raa.lkml@gmail.com,
	jjuran@gmail.com, Robin Rosenberg <robin.rosenberg@dewire.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 23:25:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqvEj-0003yU-AV
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 23:25:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab1BSWZC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 17:25:02 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34944 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab1BSWZB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Feb 2011 17:25:01 -0500
Received: by yxn22 with SMTP id 22so117535yxn.19
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 14:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=C3eb38R5l6QpbHKVn/Ac8oNzEmYoVPibJJGGgMJbrRs=;
        b=epXujhocICPlWPxFPdRwXsZR+v7YIvI1uN3WWcNbyjNXvN/XdKgdPoJAJvradiDeBZ
         g349saS+/S+3oxxFC6durU4X/R1cntLnmjzlLPsxsC09myNhy835vjJtwqlFEZlCGWub
         VJHhUOUlaeikW5t6xvnFvopTtC24zzHivAntQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=nbDve/0QkWJ3+YVQhuwVQAlAdP7zE8+oiausNQaY5tKHgreTTWmC8XMhs3WauRd/e5
         WpSqcICrrG6PP2GFHXY2l8UpL+FwXqN3RlBCydEFhAItD3i2ZRUG64c2Zrpbs9ztuW5a
         aKi/0hnC3uJhy8eG48ZQ2af/BXjl/xTwbOwbM=
Received: by 10.150.96.21 with SMTP id t21mr2805402ybb.20.1298153804126; Sat,
 19 Feb 2011 14:16:44 -0800 (PST)
Received: by 10.151.158.19 with HTTP; Sat, 19 Feb 2011 14:16:03 -0800 (PST)
In-Reply-To: <1283769430-9263-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167383>

Heya,

2010/9/6 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>:
> This bases on the original work by Robin Rosenberg.

Junio, in the "what's cooking" you mention that you might jump in to
improve this? Duy, are you still interested in carrying this forward?
This patch [0] would be helpful to the hgit people as well :).

http://git.kernel.org/?p=3Dgit/git.git;a=3Dcommit;h=3D673f3d9d4e019a15c=
6d3770e9f8d9b07059f16cc

--=20
Cheers,

Sverre Rabbelier
