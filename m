From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: gitweb on Godaddy
Date: Thu, 4 Jul 2013 08:38:44 +0200
Message-ID: <20130704063844.GA17597@paksenarrion.iveqy.com>
References: <CACdXCX6-NCm00QnakagOWChK1SFq0UMY2pCPEFqs2+taqtMEsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: RR <rajaram.officemails@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 04 08:38:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UudBc-0006GP-RR
	for gcvg-git-2@plane.gmane.org; Thu, 04 Jul 2013 08:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755207Ab3GDGid convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jul 2013 02:38:33 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:49488 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754323Ab3GDGic (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 02:38:32 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so897255lbh.10
        for <git@vger.kernel.org>; Wed, 03 Jul 2013 23:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=V2eB5B3jiACfGT4VeUCC8FaLCCgMAOR3rhcrxMfsbZ8=;
        b=jiz79M2EzfnBJewQ+CknCyRoYNXjS9WKeuc70eKnPDr1Qy9jKUq6DB3DVVL420p5r/
         +1e5R0+HoSOqDbXh9bKlcwd7V0GAumAb6Kei4XJ8v66qrO8HFqMyFJAXMSHPLWU67KOF
         iPG/tup//JNmdHiweaFIT4RN9cyCNX+Dum2tImqiwe9+32+PGqdeuGUiaWSJEWdRLi/5
         B1wanOHo5q7IzUAqrXEDVDiM5W/LA3rBgQt1cYIiugnzeIIQJ5mvlNxKrXJle1yx6I+c
         pA4/H0MCyNN6NN7nBDJ/RyUReTnCBU1mWl6R9nLPDVYTq3STqmwsSvodKA6r29yqAiIY
         5YHg==
X-Received: by 10.112.200.9 with SMTP id jo9mr2791246lbc.54.1372919909363;
        Wed, 03 Jul 2013 23:38:29 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id m14sm685090lbl.1.2013.07.03.23.38.28
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 03 Jul 2013 23:38:28 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UudBk-00026D-AG; Thu, 04 Jul 2013 08:38:44 +0200
Content-Disposition: inline
In-Reply-To: <CACdXCX6-NCm00QnakagOWChK1SFq0UMY2pCPEFqs2+taqtMEsw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229557>

On Thu, Jul 04, 2013 at 11:56:40AM +0530, RR wrote:
> HI
>=20
> Can someone share procedure to setup gitweb on a Godaddy hosting
> server ? Any pointers to tutorials would be helpful
>=20

Hi,
I suggest that you contact godaddy and check with them what options you
have. Gitweb is a cgi program and you need support to run
cgi-applicatios from godaddy. You would also have to host your git
repository on the same server (or at least you should).

If that's not a possibility you might need to use a static html creator
like http://hssl.cs.jhu.edu/~neal/git2html/ .

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
