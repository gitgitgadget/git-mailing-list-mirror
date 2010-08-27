From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Does changing filename case breaks git's rename heuristic?
Date: Fri, 27 Aug 2010 11:06:32 +0530
Message-ID: <20100827053629.GC22527@kytes>
References: <AANLkTinxvj85Jzb-ykK0=MmRHkz8aQzmVxexC8H+Xgno@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dan Loewenherz <dloewenherz@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 07:38:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oordx-0003rw-FW
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 07:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab0H0FiU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Aug 2010 01:38:20 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37254 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204Ab0H0FiT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Aug 2010 01:38:19 -0400
Received: by pvg2 with SMTP id 2so939946pvg.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 22:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=eOwNv9GPD25bAxgOL7cLj9GlPns134GfDzSRAy525rA=;
        b=CXY7mwGhCNypiZt2laJpsLdlE6Gir6QyQEeDmTxYIxljn46Ihvfdet/rVNbPlvZ61z
         HDarBEa7muCCPfFX6km7PKjlvzBAOWNo8xnnPtuERziOofPpZ2YaMAwZ5bVjDhhyNV9l
         JXe2ETPuTaeDM5zcedCJqmMhytz/A5L1J2vXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=whFVcBVT/c1hWMDCTOKav6VDJpm7hCSUQkXjDWFaRHbR+S6iWPAdBXxVEWgt738oZI
         pwClnifzIHKRa+hH0MIpAkrhmOG88mitdhSMWbFsFQsIGYleiuolthMBGFx8RQ7kGNiy
         kGO2SflSRBb51tPpTtaH31TVyZ1X7jcVlBjSA=
Received: by 10.142.172.10 with SMTP id u10mr789147wfe.213.1282887499407;
        Thu, 26 Aug 2010 22:38:19 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 33sm3904510wfg.9.2010.08.26.22.38.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 22:38:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinxvj85Jzb-ykK0=MmRHkz8aQzmVxexC8H+Xgno@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154584>

Hi Dan,

Dan Loewenherz writes:
> I may be mistaking a design decision as a bug, but I wanted to throw
> this out to the list to make sure. I think that re-enacting it will b=
e
> the best way to explain it.
>=20
> $ mkdir test
> $ cd test
> $ git init
> $ cat > readme
> This is a test file.
> ^D
> $=A0git commit -am "first commit"
> [master (root-commit) fae0d05] first commit
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> For personal reasons, I now want readme to be uppercase.
>=20
> $ mv readme README
> $ cat > README
> This is the revised README.
> $ git status -sb
> ## master
>  M readme
[...]

Thanks for taking the time to explain! Unfortunately, I'm not able to
reproduce this. Which version of Git are you using, and which platform
are you on?

-- Ram
