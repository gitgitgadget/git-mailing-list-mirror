From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: 404 links on some blob pages
Date: Sun, 27 Nov 2011 14:44:23 -0800 (PST)
Message-ID: <m3y5v1kwwm.fsf@localhost.localdomain>
References: <CAKD0UuxBO_Uj4dHr9g3zryO=03_ds0omFFnGY89_MPJGfxLZMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?J=FCrgen_Kreileder?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Sun Nov 27 23:44:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUnSY-0006P0-SI
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 23:44:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755825Ab1K0Wo0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Nov 2011 17:44:26 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40620 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754649Ab1K0WoZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2011 17:44:25 -0500
Received: by bke11 with SMTP id 11so7628343bke.19
        for <git@vger.kernel.org>; Sun, 27 Nov 2011 14:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=d/xhoh3lCk7ki8tF7m94/d6r3iYlbUNtsFQMcyh4rao=;
        b=xPl+x9g9hHfAJU2flNV5vJpcGLzO3Qa5JGskqErRD8TSbrAbrQQ4+dlHNVPBSIO3Gu
         WG3vaxc3TB8tneQutjZlRJ5hoq3dTA4WMY4Dhns9EdLSHjjrTXJzTfKImJh/BqbCy1R7
         J/DxiFw22UaT7xFX47vGaStZs9msXOaIQ6bZg=
Received: by 10.204.13.68 with SMTP id b4mr42241776bka.32.1322433864635;
        Sun, 27 Nov 2011 14:44:24 -0800 (PST)
Received: from localhost.localdomain (abwo176.neoplus.adsl.tpnet.pl. [83.8.238.176])
        by mx.google.com with ESMTPS id n25sm37016370fah.15.2011.11.27.14.44.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Nov 2011 14:44:23 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pARMiwdi001792;
	Sun, 27 Nov 2011 23:44:58 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pARMivJp001785;
	Sun, 27 Nov 2011 23:44:57 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CAKD0UuxBO_Uj4dHr9g3zryO=03_ds0omFFnGY89_MPJGfxLZMA@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185994>

J=FCrgen Kreileder <jk@blackdown.de> writes:

> some blob pages have broken links:
>=20
> For example, on
> https://git.blackdown.de/?p=3Dcontactalbum.git;a=3Dblob;f=3DClasses/W=
indowController.m;h=3Db84d1882cb6c3a2d2058cbdd56b2280b48f1690a;hb=3Db84=
d1882cb6c3a2d2058cbdd56b2280b48f1690a
> the blob_plain link for WindowController.m leads to '404 - Cannot fin=
d file':
> https://git.blackdown.de/?p=3Dcontactalbum.git;a=3Dblob_plain;f=3DCla=
sses/WindowController.m;hb=3Db84d1882cb6c3a2d2058cbdd56b2280b48f1690a

That is strange.  The check is the same for 'blob' and 'blob_plain'
action...

--=20
Jakub Nar=EAbski
