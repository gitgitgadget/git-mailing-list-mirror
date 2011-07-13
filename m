From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Multiple projects with gitweb
Date: Wed, 13 Jul 2011 09:17:23 -0700 (PDT)
Message-ID: <m3bowyb1gd.fsf@localhost.localdomain>
References: <700B9246C3446949B8085B181F2C217804E59B@renexmb01.roe2.renesasmobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "Mathieu.Pogeant" <Mathieu.Pogeant@renesasmobile.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 18:17:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh287-00040n-7e
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 18:17:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755811Ab1GMQRc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 12:17:32 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:58890 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596Ab1GMQRb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 12:17:31 -0400
Received: by fxd18 with SMTP id 18so6115437fxd.11
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 09:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=VaDaYOp2ww82DZuFsVfLY2lhe5h0RXTCUMzyyEHNk+4=;
        b=ar+Ebclv1OV40FPcOJatSrbHHhmcAhwXLeKASWYP0KeSZTw+MxuqBS6RdEL3b6AA5n
         UkLU/ITcG2M6UW+hvpZA6dvQPYsa1Lu6OzsjjBurIMB70+016KvuvrS0AAvVr/AzT3Ug
         3jihvoC/7ure2IO17rE35NQiO8SNc/v7Frv14=
Received: by 10.223.91.129 with SMTP id n1mr1886706fam.113.1310573845417;
        Wed, 13 Jul 2011 09:17:25 -0700 (PDT)
Received: from localhost.localdomain (abve26.neoplus.adsl.tpnet.pl [83.8.202.26])
        by mx.google.com with ESMTPS id m5sm10593236fai.1.2011.07.13.09.17.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 09:17:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6DGGpZt018990;
	Wed, 13 Jul 2011 18:17:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6DGGZke018986;
	Wed, 13 Jul 2011 18:16:35 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <700B9246C3446949B8085B181F2C217804E59B@renexmb01.roe2.renesasmobile.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177053>

<Mathieu.Pogeant@renesasmobile.com> writes:

> Hello,
>=20
> I'm trying to have this with GitWeb.
> I have a repo under /project1 and a repo under /project2 on my Git se=
rver.
> I would like to access these 2 repo via Gitweb like that:=20
> http://mygitserver/project1 and http://mygitserver/project2.
>
> The problem is that gitweb.conf permit to use just one repo
> with directive $projectroot.

Actually it is not true.  The full path to repository is

  "$projectroot/$project"

so if you really have both repositories in top directory, try using

  our $projectroot =3D "/";

Of course to have "http://mygitserver/project1" as URL you have to do
some URL rewriting; I think there is example either in gitweb/README
or in gitweb/INSTALL.

HTH
--=20
Jakub Nar=EAbski
