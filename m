From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 2/3] gitweb/gitweb.perl: remove use of qw(...) as parentheses
Date: Sat, 19 Feb 2011 17:02:29 +0100
Message-ID: <201102191702.29648.jnareb@gmail.com>
References: <1298124654-12051-1-git-send-email-avarab@gmail.com> <1298129262-10468-3-git-send-email-avarab@gmail.com> <201102191654.41601.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 17:02:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqpGc-0007Xg-Qt
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 17:02:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751590Ab1BSQCi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Feb 2011 11:02:38 -0500
Received: from mail-bw0-f52.google.com ([209.85.214.52]:47063 "EHLO
	mail-bw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab1BSQCi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 11:02:38 -0500
X-Greylist: delayed 327 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Feb 2011 11:02:37 EST
Received: by bwz4 with SMTP id 4so4404338bwz.11
        for <git@vger.kernel.org>; Sat, 19 Feb 2011 08:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=UE5EfFQE+G4MttdEgEmurrB5jcMSFLqv33bDkTlaKCE=;
        b=l8yr/rzuUX2TtygaACHiUekV51AaHJFGCqYOaS2W1rZrinXEiBbIJ+Vjgr0J5MHrty
         aTYC7xY/ISKrG31Kiyl6Yu7BUmCShCexHfDGZVGtJekjrYzcKWpnQUtxhLmQJQH/eEd/
         UV6QtyG8ePVmoZ5Htvdco7EjPOrjWW0WzxKgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=JJrra+1rmRKhClxdlLLOz8JgoPpu7TYkjDO2G1nc8ECnt7mhZAwUOH8cboyoE/ae2J
         sTzNQLWBkPRiRPP9IjcW48zpQTwdXjB12lfGi6/+i6E8R96hDdSaLVZolAbVXgAgEDB6
         rJojzcyAotWXBUGXeFVogQCvf25j2obW/ggO8=
Received: by 10.204.71.141 with SMTP id h13mr1780208bkj.180.1298131356918;
        Sat, 19 Feb 2011 08:02:36 -0800 (PST)
Received: from [192.168.1.13] (abwm176.neoplus.adsl.tpnet.pl [83.8.236.176])
        by mx.google.com with ESMTPS id v25sm2325907bkt.18.2011.02.19.08.02.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Feb 2011 08:02:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201102191654.41601.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167295>

Jakub Narebski wrote:
> On Sat, 19 Feb 2011, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> [...]
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -3501,7 +3501,7 @@ sub print_feed_meta {
> >  			$href_params{'-title'} =3D 'log';
> >  		}
> > =20
> > -		foreach my $format qw(RSS Atom) {
> > +		foreach my $format (qw(RSS Atom)) {
> >  			my $type =3D lc($format);
> >  			my %link_attr =3D (
> >  				'-rel' =3D> 'alternate',

Ah, sorry, if Perl reqyures to use 'foreach (@array)', then
of course one should use 'forach (qw(A B))'.

--=20
Jakub Narebski
Poland
