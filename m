From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: webgit highlightes mem adresses as git versions
Date: Mon, 02 Feb 2009 14:54:20 -0800 (PST)
Message-ID: <m3ljsowisv.fsf@localhost.localdomain>
References: <200902022204.46651.toralf.foerster@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-14
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-14?q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 02 23:55:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU7hm-0000f2-E6
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 23:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753033AbZBBWyY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Feb 2009 17:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752809AbZBBWyY
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 17:54:24 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:24197 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752808AbZBBWyX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Feb 2009 17:54:23 -0500
Received: by fg-out-1718.google.com with SMTP id 16so741694fgg.17
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 14:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=ov4ZKxFvDxxRBuMIRAeyouFuLIVXx9/UkN4P9nxh6VI=;
        b=ah7s5l5mSMxTLpilcCWS5WvWr7K2KAc1mCnp5pBLIrEjkkC+2LBZ8WKD9TE6Cuq8PW
         n2DwSG+22JNtnNggrr3zOoLqdAyG1afAQm908reLrhTUUloFZcs1GT647TDUIynoCoxW
         KEQStWIrr3zW/jwfLsR66nndv14Q1QKZirHYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=EtPr7NMopIN11LER00E+2An7CnZpmtm/dHgzhJLtwCKVUnVAZ8Srrf5Wuyq/KF29cE
         ZJEEYSbp8EPwTHiElWK1S/sOhsVHtXd7OF9HfMh4HRNNNT6yeF8H+dUk4Zizyz2fA1GS
         oWvj9A+Ta6GF7zA4nCNI64+Mn27wfld77vEMU=
Received: by 10.86.92.4 with SMTP id p4mr2542198fgb.36.1233615261353;
        Mon, 02 Feb 2009 14:54:21 -0800 (PST)
Received: from localhost.localdomain (abwn190.neoplus.adsl.tpnet.pl [83.8.237.190])
        by mx.google.com with ESMTPS id d6sm1850914fga.9.2009.02.02.14.54.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Feb 2009 14:54:20 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n12MtG9j017783;
	Mon, 2 Feb 2009 23:55:16 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n12MtEbx017780;
	Mon, 2 Feb 2009 23:55:14 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <200902022204.46651.toralf.foerster@gmx.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108133>

Toralf F=F6rster <toralf.foerster@gmx.de> writes:

> As seen here=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-2.6.27.y.git=
;a=3Dcommit;h=3D8ca2918f99b5861359de1805f27b08023c82abd2=20
> the strings [<c043d0f3>] and firends shouldn't be recognized as git h=
ashes,=20
> isn't it ?

Gitweb, not webgit.  And gitweb considers ([0-9a-fA-F]{8,40}) i.e.
from 8 to 40 hexadecimal characters to be (shortened) SHA-1.  It
simply cannot afford checking if such object exists when displaying
commit message (for example in 'log' view).

--=20
Jakub Narebski
Poland
ShadeHawk on #git
