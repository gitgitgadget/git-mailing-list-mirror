From: PJ Weisberg <pjweisberg@gmail.com>
Subject: Re: pushing a branch without merging
Date: Mon, 20 Jun 2011 08:51:36 -0700
Message-ID: <BANLkTik8j1g6wqeD7oGQra1Ep10uaTH0Rg@mail.gmail.com>
References: <BANLkTin4fpwX9NgnP0U1+z9tRA=akR6MDg@mail.gmail.com>
	<4DFF5B41.1000108@micronengineering.it>
	<BANLkTikWDzZD8b-aUMXJwByeN3tBsYipgQ@mail.gmail.com>
	<20110620150303.GA2782@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlo Trimarchi <mr.spoon21@gmail.com>,
	Massimo Manca <massimo.manca@micronengineering.it>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Mon Jun 20 17:51:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYglW-0003ch-DZ
	for gcvg-git-2@lo.gmane.org; Mon, 20 Jun 2011 17:51:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299Ab1FTPvj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jun 2011 11:51:39 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47445 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab1FTPvi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2011 11:51:38 -0400
Received: by fxm17 with SMTP id 17so1053784fxm.19
        for <git@vger.kernel.org>; Mon, 20 Jun 2011 08:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=oLWeEilGS6L0WFn61q/7iZf81G3mVw1zEKpxVzE35BU=;
        b=AD7jjui8Z2jYOvOrnDtr+Sx0m50qizVJQT9CnvbTYzNumn3DhWl/nWuPNIhm/Ga6g7
         ITfzLIbhxBa0UfcZF3mu8oHM9Uo89gPoEjIFye64nn9UZKapbZTAv+HeWWVStw5R/fT8
         aLM6ts1ECJNazI8jqe2kzm+e57fl0DgkOWMWc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AFXZqDPQJ4GDiKSHbsoZSHr3MZYJ/aru2nJBGw417+eia+l21AbsdHqO/qieHi2RT9
         1i0dGUhXXS8LALaYc9nqLDm7sJdBBdiszW+o/yS+Ff73TCJBoNyPqarusWocWKk9LSJP
         O1jd+B9PtXSVYqo0dkl69OVQhtdH8m0q3HYiI=
Received: by 10.223.13.211 with SMTP id d19mr550442faa.67.1308585096701; Mon,
 20 Jun 2011 08:51:36 -0700 (PDT)
Received: by 10.223.73.201 with HTTP; Mon, 20 Jun 2011 08:51:36 -0700 (PDT)
In-Reply-To: <20110620150303.GA2782@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176075>

On Monday, June 20, 2011, Carlos Mart=EDn Nieto <cmn@elego.de> wrote:

> if you want to create the branch 'experimental', or if your deploymen=
t
> system only checks out the 'master' branch, you might find
>
>  =A0 =A0git push website experimental:master
>
> useful. In this case you may have to force-push master again, which i=
s
> not recommended (though in your case it might be fine).

=46YI, that *replaces* the remore master branch with the local
experimental branch.  If you just want someone else to be able to be
able to 'git pull website experimental', what you want to do is 'git
push website experimental' or 'git push website --all'.

--=20

-PJ
