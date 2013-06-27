From: Woody Wu <narkewoody@gmail.com>
Subject: Re: Off-line deverloper workflow?
Date: Thu, 27 Jun 2013 21:58:03 +0800
Message-ID: <20130627135803.GA5660@zuhnb712>
References: <20130627124656.GA2620@zuhnb712>
 <51CC4197.3000007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Woody Wu <narkewoody@gmail.com>, git <git@vger.kernel.org>
To: Jean-No?l Avila <avila.jn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 27 15:58:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsCi3-0007PR-Sn
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 15:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752647Ab3F0N6A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Jun 2013 09:58:00 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:59215 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab3F0N57 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 09:57:59 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so409703pdj.17
        for <git@vger.kernel.org>; Thu, 27 Jun 2013 06:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bmc0S1awsCfYTojhXIC4P5b/3i/e92nBL2tBw9Dx+g4=;
        b=VCIhnOarvYCOTXPYBv8YDWLkgjoqUs5ulYYGYV8rQShtZZm3mvrYf5q83cK/2AIQm1
         GnIARkBXvNy6epZoKIVF5YStXFyskz1y+Vzb8WJnuTvZmgNa2TyQ558URxVrl/epOnKu
         u4P2OG8ak9Ofy9GOeAlrj7Ga0xZGKMY09hdaIVe7vhWo6QSIJx0hlAeWk5Z+Rao9sNWA
         qioQoaD1v63mrBolba5q3QOucP4JGH4VB0K7OPDE09Vx4ugx5LX1+LAcadsLGiQoEb39
         PGnyu47jgTmw5SxSFHYhXlical+z90x0lux+E1cCSkE64U6jF4SF6qtUPZ1luRMhbYHH
         UorQ==
X-Received: by 10.66.193.199 with SMTP id hq7mr6246145pac.183.1372341478939;
        Thu, 27 Jun 2013 06:57:58 -0700 (PDT)
Received: from localhost ([119.120.31.222])
        by mx.google.com with ESMTPSA id vb8sm3308998pbc.11.2013.06.27.06.57.56
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Jun 2013 06:57:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <51CC4197.3000007@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229106>

On Thu, Jun 27, 2013 at 03:43:51PM +0200, Jean-No?l Avila wrote:
> Le 27/06/2013 14:46, Woody Wu a =E9crit :
> >Hi,
> >
> >I have a colleague who has to left our office for three month, but s=
till
> >need to work on the project which is hosted on our in-office git
> >repository. Problem is that our company has firewall, it's not possi=
ble
> >or not allowed to access the company LAN outside the building.  So I
> >want to ask you expert, can you suggest a best practice of git workf=
low
> >that suitable to my situation?
> >
> >Thanks in advance.
> >
> >-woody
> >
> >--
> >To unsubscribe from this list: send the line "unsubscribe git" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> For a short time, I had the same issue. We came up using "git
> bundle" to bundle changes and exchange them via email.
>=20
> The setup was to work in two separate branches. The roaming
> developper started a new branch when leaving. After some work, she
> sent the commits on her branch as a bundle file. The origin merged
> the branch extracted from the developper's bundle and sent back the
> bundle of the changes on origin since the last merge.
>=20
> No doubt that both side need to understand well the workflow of
> fetch/merge. Bundle files can be encrypted for better security.
>=20
> Hope this helps.

Many thanks, this method sounds suitable to me. I will go the learn
anything about 'bundle'.

Have a nice day!

>=20
> JN

--=20
I can't go back to yesterday - because I was a different person then
