From: Motiejus =?utf-8?Q?Jak=C5=A1tys?= <desired.mta@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 20:19:34 +0100
Message-ID: <20110427191933.GC2667@jakstys.lt>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
 <4DB80747.8080401@op5.se>
 <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
 <4DB82D90.6060200@op5.se>
 <BANLkTi=XcR9FTPC8oe100fMneNf1nca4_Q@mail.gmail.com>
 <BANLkTikGZgEb-4jzHt+t2k__s7BMgbU9gg@mail.gmail.com>
 <20110427191612.GB2667@jakstys.lt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 21:19:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFAHF-0001IQ-9I
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 21:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759898Ab1D0TTj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 15:19:39 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64390 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759851Ab1D0TTh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 15:19:37 -0400
Received: by wwa36 with SMTP id 36so2255361wwa.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 12:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=V6Y4bWC3jrgseF0QRGmp2A7eU1LN2+jNzPmy958OqNk=;
        b=kH9Qf27Fqf0JHGF5kU4KHajAAkG/FGSDeFzM24TNKT8ankTzwDf33O/WFAG4qYahcX
         9eW9GQpATA6IUCE0Ml4qZHBcKMO8AyufbQHYw0YcyvURljeDmGKotdIb3dcE6zepu2c0
         N5OF6w63f5npdSjdVL8/tRRK4i4xzrTekih4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=dAft3jVoFiVTs1Vf0mmEyM7yKKeHv2VWZYhl/vHFugsqIxLVLjT9E8z94NKA28YtFG
         VzQMwQn9a7mHdK4oI4UiVvx5JifmtTmaKjXJCxPnKwuayxE3vNjW5YiJyI45Lw2Vk4PP
         xsOqdTDQqfrdpzFFhMBiC9zJvPaO90wkz/m4M=
Received: by 10.227.197.77 with SMTP id ej13mr2566785wbb.128.1303931976610;
        Wed, 27 Apr 2011 12:19:36 -0700 (PDT)
Received: from localhost ([109.246.247.245])
        by mx.google.com with ESMTPS id bs4sm648107wbb.35.2011.04.27.12.19.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2011 12:19:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110427191612.GB2667@jakstys.lt>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172262>

On Wed, Apr 27, 2011 at 08:16:12PM +0100, Motiejus Jak=C5=A1tys wrote:
> Which one? Say I am on debian. dpkg-buildpackage? So I would get a
> git-logx.deb, which I should install as root? In that case, you forgo=
t
> one word:
>=20
>       sudo git pm install foobar
>=20
> Or I got it wrong?

Maybe you mean this...
       $ git pm install foobar
       $ sudo dpkg -i foobar.deb

Which does not make really happy...

Motiejus
