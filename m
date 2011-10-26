From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb/Makefile: Remove static/gitweb.js in the clean target
Date: Wed, 26 Oct 2011 02:36:58 +0200
Message-ID: <201110260236.59509.jnareb@gmail.com>
References: <4EA6EEA8.3000204@ramsay1.demon.co.uk> <1319583484.10399.41.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Oct 26 02:37:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIrUZ-0002NO-Li
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 02:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155Ab1JZAhI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Oct 2011 20:37:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61393 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754074Ab1JZAhH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 20:37:07 -0400
Received: by faan17 with SMTP id n17so1082948faa.19
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 17:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=V1gaa7xZOw3qeq2Ez8yuvEgJnb0yZ/FffQ3gDWigTNI=;
        b=MQcwNlrx1W2LH9dZgccqAKQQ947UZLMiwAMm+uALmz1fc9NDkspmft7BaaqOzGSp0c
         q0hsWuQ8nSODldseDM+U2es+9hdFkZm4T1N2fgEZ6jUgpLrtpoMmFSQQllX/rbv7vg2M
         JNlGLQc9GYIRKk+Ci9S/21tMLpUfo5OEVVmrI=
Received: by 10.223.14.3 with SMTP id e3mr52941225faa.25.1319589426031;
        Tue, 25 Oct 2011 17:37:06 -0700 (PDT)
Received: from [192.168.1.13] (abvy69.neoplus.adsl.tpnet.pl. [83.8.222.69])
        by mx.google.com with ESMTPS id a8sm714512faa.11.2011.10.25.17.37.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Oct 2011 17:37:04 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1319583484.10399.41.camel@drew-northup.unet.maine.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184245>

Drew Northup napisa=B3:
> On Tue, 2011-10-25 at 18:15 +0100, Ramsay Jones wrote:
> > Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
> > ---
> >  gitweb/Makefile |    4 +++-
> >  1 files changed, 3 insertions(+), 1 deletions(-)
> >=20
> > diff --git a/gitweb/Makefile b/gitweb/Makefile
> > index 1c85b5f..4191c6b 100644
> > --- a/gitweb/Makefile
> > +++ b/gitweb/Makefile
> > @@ -185,7 +185,9 @@ install: all
> >  ### Cleaning rules
> > =20
> >  clean:
> > -	$(RM) gitweb.cgi static/gitweb.min.js static/gitweb.min.css GITWE=
B-BUILD-OPTIONS
> > +	$(RM) gitweb.cgi static/gitweb.js \
> > +		static/gitweb.min.js static/gitweb.min.css \
> > +		GITWEB-BUILD-OPTIONS
> > =20
> >  .PHONY: all clean install test test-installed .FORCE-GIT-VERSION-F=
ILE FORCE
> > =20
>=20
> Forgive me for sounding a bit numb, but what does this fix? I don't s=
ee
> it in the commit message.

gitweb.js is nowadays a generated file.  Though that bit should be
in commit message...

--=20
Jakub Narebski
Poland
