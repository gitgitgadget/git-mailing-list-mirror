From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2011, #04; Wed, 12)
Date: Wed, 12 Oct 2011 23:02:45 -0700 (PDT)
Message-ID: <m3zkh577ln.fsf@localhost.localdomain>
References: <7vipnu9hbj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Cord Seele <cowose@googlemail.com>,
	Cord Seele <cowose@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 13 08:03:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REENf-0003RJ-FQ
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 08:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab1JMGCu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Oct 2011 02:02:50 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44755 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab1JMGCt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Oct 2011 02:02:49 -0400
Received: by eye27 with SMTP id 27so1475069eye.19
        for <git@vger.kernel.org>; Wed, 12 Oct 2011 23:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=+I3HGAohnsJ9I2CgWry4Mu2V7ANRMNtrr7MpwFQxpYE=;
        b=YG0eLYrHqryxsfsCTBh+W+RkuaLwiRxuUzhmlANlcHA0yZM9d0ZUYermjhQNC65ke5
         C6/Tdz8ORPATcX1gm7HVfCi4u3mNTezatDH/zMH0BaCmqVXW6fKxQc57feNneQakTs+y
         A/5bxoyixCTuAhGOas98g/VWyuX27Zk5flBbU=
Received: by 10.223.75.27 with SMTP id w27mr3955176faj.11.1318485766506;
        Wed, 12 Oct 2011 23:02:46 -0700 (PDT)
Received: from localhost.localdomain (abwe119.neoplus.adsl.tpnet.pl. [83.8.228.119])
        by mx.google.com with ESMTPS id w14sm7999266fae.13.2011.10.12.23.02.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Oct 2011 23:02:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9D626CH027157;
	Thu, 13 Oct 2011 08:02:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9D61e2h027146;
	Thu, 13 Oct 2011 08:01:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vipnu9hbj.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183442>

Junio C Hamano <gitster@pobox.com> writes:

> * cs/perl-config-path-send-email (2011-09-30) 2 commits
>   (merged to 'next' on 2011-10-06 at 93c00f0)
>  + use new Git::config_path() for aliasesfile
>  + Add Git::config_path()
>=20
> Originally merged to 'next' on 2011-10-05.
> Will merge to 'master' in the second wave.

What about

   . Refactor Git::config_*

from

   [PATCH/RFC 3/2] Refactor Git::config_*
   http://thread.gmane.org/gmane.comp.version-control.git/182310/focus=3D=
183111

Ahhh... sorry, it is marked as an RFC.  Should I resend?
--=20
Jakub Nar=EAbski
