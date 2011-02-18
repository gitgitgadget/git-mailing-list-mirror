From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Can Gitweb show a git-shortog(1) between two revisions?
Date: Fri, 18 Feb 2011 07:23:00 -0800 (PST)
Message-ID: <m31v358j0x.fsf@localhost.localdomain>
References: <AANLkTinO4fq02OJ2-EDVvG8fTGQp2B0X=bvu-fvjS0Tt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 16:23:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqSAr-000212-8l
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 16:23:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756235Ab1BRPXH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Feb 2011 10:23:07 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44968 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048Ab1BRPXF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Feb 2011 10:23:05 -0500
Received: by bwz15 with SMTP id 15so816361bwz.19
        for <git@vger.kernel.org>; Fri, 18 Feb 2011 07:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=JXfEJv4/PcUifgP9trHWbiqmOoPtvoi6LBAYemmap1Y=;
        b=goFzbYp+cptl0WBHittLx5rFinlhh+sZe2nNKfxomf5PpKXIrH3+KbqLQC7BbBbFfa
         QSPsj4OQTvxwZOoJlQc9h3cFhxrk1cSDRHYS4QrgXw7IIofJJIcF3Eoqa2BfamLWV/ye
         dEqW9Szl4vcYGD6koW0pLulbrqHzwSxj4Jg1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=RFWuHqVNsBHL9SfqOJVcif6Xa1lwrZtzNCw4kOs/97RjWRNXW5gHJAhNkk2TA+u1vK
         gHbUf+jSJvBq9RJFWmKSVRfpJT+HmSv89PB2YavSh6zXXaTvPCTFHJNN9hUa1Sy3mIr/
         BxDar2FsdfyXJRgQyZyl+x6TleSEgy1rgpX2M=
Received: by 10.204.66.130 with SMTP id n2mr782132bki.175.1298042583269;
        Fri, 18 Feb 2011 07:23:03 -0800 (PST)
Received: from localhost.localdomain (abwu244.neoplus.adsl.tpnet.pl [83.8.244.244])
        by mx.google.com with ESMTPS id b6sm1542639bkb.22.2011.02.18.07.22.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Feb 2011 07:23:00 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p1IFMXPX032551;
	Fri, 18 Feb 2011 16:22:43 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p1IFMMgx032547;
	Fri, 18 Feb 2011 16:22:23 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTinO4fq02OJ2-EDVvG8fTGQp2B0X=bvu-fvjS0Tt@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167219>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:

> I want to show a git-shortlog(1) in Gitweb (to link to it externally)=
=2E
> Can Gitweb do this? I haven't found out how, if so.
>=20
> I.e. just:
>=20
>     git shortlog x..y

Modern gitweb can, though currently you have to generate URL by hand.
=46or example:

  http://git.example.com/git.git/shortlog/refs/tags/v1.7.4..refs/tags/v=
1.7.4.1

--=20
Jakub Narebski
Poland
ShadeHawk on #git
