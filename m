From: Pascal Obry <pascal.obry@gmail.com>
Subject: Re: Question about git-svn import
Date: Fri, 21 Dec 2007 14:11:40 +0100
Organization: Home - http://www.obry.net
Message-ID: <476BBB8C.3000908@obry.net>
References: <4766AF65.5060706@obry.net> <20071218034836.GA27080@dervierte> <4767724A.9040207@obry.net> <20071218153159.GA12549@alea.gnuu.de> <476A98BB.8000900@obry.net> <20071220165227.GB22683@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?J=F6rg_Sommer?= <joerg@alea.gnuu.de>
X-From: git-owner@vger.kernel.org Fri Dec 21 14:12:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5hfg-0004Xk-Gg
	for gcvg-git-2@gmane.org; Fri, 21 Dec 2007 14:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905AbXLUNLt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Dec 2007 08:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754616AbXLUNLt
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 08:11:49 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:57191 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626AbXLUNLs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 08:11:48 -0500
Received: by fg-out-1718.google.com with SMTP id e21so160972fga.17
        for <git@vger.kernel.org>; Fri, 21 Dec 2007 05:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        bh=35uUvrCrx28PG/Wj3eokDu+2JkJPVNI86SgUOP4j+DI=;
        b=j6ELbfbWEUwGB8Wmjqm72n3CnvXNgkGDg2prmYB71rm1BuqItIdX0YC5YSIoopLO3mY3zy6c6TgOLQDLrGgGTv/DLlA1jylUXNtA+BGMrR/AT9Ta+4lT+9M3n/oABFFkXkyDVGfZSWm3udbmo3BzwjnqxAoJfwY4Gkwo2Xkzrz0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=kqgXrxy5zLZkuF8NBIpS0T4AEXkVgkBWBGbMHrMK0gIGvOtHywmkcfWFSLtsocNV1y7RJAcJsD2mGTAF+WTv8rGnFy4FNA35G/kDr1AaMfr/eDNvoK5Cf0jAgl6Wg+q+6dAbvk94eSoBv11fQBFNVdd9qV1Y/Hix4swkbXTcKac=
Received: by 10.86.99.9 with SMTP id w9mr1130016fgb.22.1198242703822;
        Fri, 21 Dec 2007 05:11:43 -0800 (PST)
Received: from ?192.168.0.100? ( [81.249.63.6])
        by mx.google.com with ESMTPS id 3sm1102865fge.7.2007.12.21.05.11.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 Dec 2007 05:11:42 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20071220165227.GB22683@alea.gnuu.de>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69064>

J=F6rg Sommer a =E9crit :
> According to http://duncan.mac-vicar.com/blog/archives/282 it should =
help
> to do something like:
>=20
> git update-ref refs/remotes/git-svn master
> find -name .rev_db* | xargs rm

Ok, thanks a lot it is working!

Git is a great tool... and the community around it is really helpful.
Thanks to all!

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
