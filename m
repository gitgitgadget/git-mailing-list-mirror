From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 20:44:44 +1000
Message-ID: <BANLkTinzHi45wJRwHjhPOQGLXQDoTXu=bw@mail.gmail.com>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
	<7vwrig9ta7.fsf@alter.siamese.dyndns.org>
	<BANLkTinFX24gTR-0PK8Tyi5aOf8rnLk6Cg@mail.gmail.com>
	<7vsjt49stq.fsf@alter.siamese.dyndns.org>
	<BANLkTinRUaGmF5xqmVGWFurGMtO8Cgb9Hg@mail.gmail.com>
	<7vk4eg9rsf.fsf@alter.siamese.dyndns.org>
	<BANLkTi=UafJRc76ePmVXo2gF+CNVnEL41Q@mail.gmail.com>
	<20110427102133.GA10057@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>
X-From: git-owner@vger.kernel.org Wed Apr 27 12:46:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QF2GV-0005A7-L0
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 12:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757648Ab1D0Kqd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2011 06:46:33 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:33134 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756952Ab1D0Kop convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 06:44:45 -0400
Received: by vxi39 with SMTP id 39so1184635vxi.19
        for <git@vger.kernel.org>; Wed, 27 Apr 2011 03:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tJjJKx6D/DDDIWUvCZWQ1p+KvpQ39l6GELrQ6U9Rk24=;
        b=KAcJyLyVeHyrepVlrRDKEhRmqm2Ai3Pxof06YdUxesJXiWJrA22O+0eZJ45pupxSuP
         +AgoKjgO+JUJHCl46Zi3yNW1p5Ka8LIBblnpGqf+/A7kdX3W/e1qYSye+F7fmp10sDh4
         X/NK56q5CRk9bCb6HU1rnKg9Gk7UtdMpW2pAs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=J+BCDG6vl9rsbhTDfHLN4jb/wtdwH6zvlXwqlcp/JteSmpXpMb0FiHvDBOWFAm/+fR
         EHd+diwdpN4bvmwqa5tSavej4pF6kG5WzrS/9F5LtXRkKjm6w6aqw3P8SETHZ+kiMzDi
         4A+HSKg/FbM7s2UdDtUHuxQcEWCi8Gwp+auyE=
Received: by 10.52.180.164 with SMTP id dp4mr1042023vdc.119.1303901084250;
 Wed, 27 Apr 2011 03:44:44 -0700 (PDT)
Received: by 10.52.160.66 with HTTP; Wed, 27 Apr 2011 03:44:44 -0700 (PDT)
In-Reply-To: <20110427102133.GA10057@bee.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172216>

>
> I'm not objecting, but when I see gpm, I think of the mouse daemon fo=
r
> Linux virtual consoles[0] and whose git clone address also ends in gp=
m.
>
> I find a name like gem (git extension manager) nicer, though that's
> taken by ruby.
>
> [0] http://www.nico.schottelius.org/software/gpm/
>
>  =C2=A0 cmn
>

Yes, I guess name clashes are not with out precedent, but perhaps we
should try harder this time or people will start to talk :-)

How about git-pm? I am thinking the script would be called git-pm
anyway, so it would make sense.

jon.
