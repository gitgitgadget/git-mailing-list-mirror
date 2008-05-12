From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to git-archive ignore some files?
Date: Mon, 12 May 2008 02:36:33 -0700 (PDT)
Message-ID: <m3prrr50gc.fsf@localhost.localdomain>
References: <1210097731.5238.3.camel@omicron.ep.petrobras.com.br>
	<BAYC1-PASMTP023026B88005E512F95384AED60@CEZ.ICE>
	<4820CC35.3090202@lsrfire.ath.cx>
	<7vk5i7gk6e.fsf@gitster.siamese.dyndns.org>
	<4826CE0B.8080109@lsrfire.ath.cx>
	<7vwsm06cdd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Victor Bogado da Silva Lins <victor@bogado.net>,
	Sean Estabrooks <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 11:37:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvUTJ-0006J9-1v
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 11:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429AbYELJgj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 May 2008 05:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756303AbYELJgj
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 05:36:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:35336 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755020AbYELJgi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 May 2008 05:36:38 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1043258nfc.21
        for <git@vger.kernel.org>; Mon, 12 May 2008 02:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        bh=0Cw5bswDk/4SN24/yMCtDq4Xw7ZEQaVWaPv5Eb+BEpU=;
        b=ofn/kxYj+FJzARDFDyQwkE7y084erV73wbvWuBsOcFcrRghbS6nwnIpgB9AZnwjhW1k4DoT92lYqp9ArCS+5+AirsFATTztHruaMWlCgi732oLiPE/8jGAkMJwXkveEX3oc7bzWr0BKk8r2zTZYg352ENWvx9Qts25PLxdQdoYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:date;
        b=hVTYAThI4fPwv6B6dQbfBI0BODBFkFmKAhng6lZ1cEnV+BQDxMyvoSUyDPqWs1zU0+OeYdUepFFLDDBDRyBnGvT9HwnAKTFwhyF0z7MxWN24f4LSWs9fnQeVp9Dm2c4d8nBAyLQVopEx6NpTKYGYYooot3/eSzQNoSAW70AK1Kc=
Received: by 10.210.46.12 with SMTP id t12mr6944239ebt.64.1210584995535;
        Mon, 12 May 2008 02:36:35 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.214.115])
        by mx.google.com with ESMTPS id c22sm10255301ika.1.2008.05.12.02.36.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 May 2008 02:36:33 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4C9aNWN010835;
	Mon, 12 May 2008 11:36:26 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4C9ZlN4010830;
	Mon, 12 May 2008 11:35:48 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vwsm06cdd.fsf@gitster.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81841>

Junio C Hamano <gitster@pobox.com> writes:

> Ren=E9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
> > Another idea: would it make sense to have an attribute for that ins=
tead
> > (or in addition to the command line parameter)?  I.e. files marked
> > export-ignore would not end up in the archive.  I suspect the set o=
f
> > files to ignore doesn't change from archive to archive one creates.
>=20
> That sounds extremely sensible.
>=20
> Should/does git-archive read .gitattributes from the tree being expor=
ted?

If I understand and remember correctly, current implementation of
gitattributes, and current tools (git-check-attr), use and can use
only working directory version of .gitattributes, in part because of
chicken-and-egg problem (attributes effect checkout) IIRC.

It would be nice if git-archive read and use .gitattribues from
a tree being exported; this would for example make `export-subs`
work even for bare repositories.  This would be needed for
`export-ignore`.
--=20
Jakub Narebski
Poland
ShadeHawk on #git
