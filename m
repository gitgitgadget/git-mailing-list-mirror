From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Multiple projects with gitweb
Date: Wed, 13 Jul 2011 09:20:51 -0700 (PDT)
Message-ID: <m34o2qb1ao.fsf_-_@localhost.localdomain>
References: <700B9246C3446949B8085B181F2C217804E59B@renexmb01.roe2.renesasmobile.com>
	<1310566351.5205.9.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mathieu.Pogeant@renesasmobile.com, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Jul 13 18:21:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qh2BH-0005gZ-Dh
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 18:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084Ab1GMQUz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 12:20:55 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:41408 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756006Ab1GMQUy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jul 2011 12:20:54 -0400
Received: by eyx24 with SMTP id 24so2148208eyx.19
        for <git@vger.kernel.org>; Wed, 13 Jul 2011 09:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=pKSEa3/eMs3PN+uW/+TsdzwDsWmi8Ga8vVUvSiXMTCU=;
        b=lapyPDoQUpPosvvmhGcMz16Y+jvSfVydoJNiDsxwhroOlsqgKvHnDjhZI3WodRMPQQ
         j5EFijr27G+kTYjqXoFSMl4oWOz2/X3q+8l3D/uLMS85rjbE08oVCRM/+hkEbDFikbno
         RJ4bB7DhaM9ceHiV1CIsR6GvGLiIBtTYSHEuk=
Received: by 10.205.65.68 with SMTP id xl4mr623439bkb.303.1310574052947;
        Wed, 13 Jul 2011 09:20:52 -0700 (PDT)
Received: from localhost.localdomain (abvw29.neoplus.adsl.tpnet.pl [83.8.220.29])
        by mx.google.com with ESMTPS id q1sm336949faa.3.2011.07.13.09.20.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 13 Jul 2011 09:20:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6DGKFoc019037;
	Wed, 13 Jul 2011 18:20:25 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6DGJxZq019028;
	Wed, 13 Jul 2011 18:19:59 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1310566351.5205.9.camel@drew-northup.unet.maine.edu>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177054>

Drew Northup <drew.northup@maine.edu> writes:

[...]
> The /etc/gitweb.conf file is not meant to provide for that
> customization. The way that gitweb is currently constructed, if you u=
se
> a local configuration file for an instance it will completely ignore =
the
> system-wide configuration file (I didn't make that decision, as it
> doesn't make much sense to me either), so you will have to make sure
> that ALL settings required are set in each instance-local configurati=
on.

There were some patches sent to alleviate it (with read_config_file
that one can use in per-instance config file) and fix it (with
introduction of common configuration file /etc/gitweb-common.conf),
but I don't know what happened to it.

> I plan on re-submitting my touch-ups to that documentation now that a
> have a minor window of sanity here at work (not that I expect that to
> last).

That would be very nice.

--=20
Jakub Nar=EAbski
