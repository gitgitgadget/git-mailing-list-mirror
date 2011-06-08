From: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Wed, 8 Jun 2011 16:37:26 +0200
Message-ID: <20110608143726.GA72373@sherwood.local>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, thomas@xteddy.org
To: =?utf-8?B?SsOpcsOpbWll?= NIKAES <jeremie.nikaes@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 16:38:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUJtz-0008BE-Es
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 16:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828Ab1FHOia convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 10:38:30 -0400
Received: from hera.kernel.org ([140.211.167.34]:47501 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754573Ab1FHOi3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 10:38:29 -0400
Received: from mail-fx0-f46.google.com (mail-fx0-f46.google.com [209.85.161.46])
	by hera.kernel.org (8.14.4/8.14.3) with ESMTP id p58EcNZs023482
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Wed, 8 Jun 2011 14:38:25 GMT
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.97 at hera.kernel.org
Received: by fxm17 with SMTP id 17so361173fxm.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=qN3aClN70PcfCHDPzWcoXzN5yDKcI3LFpGE+GnHufqw=;
        b=b7eBmltAtjBJ1hM4oOsJU0TdSMbVrG26h8Z4Ih2DZLZp9CX6TVnIxw+nn6z69DIJxb
         YWH53VcMFYf6aKeIqT+5HtjX5QPCAGxrkvELAceL5u+pffh7gStS4apivC3iuYr6D41/
         iEIfa02JqEgIIAO76wrSUZOZfO9FBdIMSbNLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=jQN+ff9TsXEKBye3jW4ISQ7yo9mvelcPBPj2/wHzijy0wiUJEC6R0WLJ0iYMbSWL6x
         j6D33WIhUmRTN0CTqZpBV96S+5egvqlIbJGb2SLbSPeAZKj7YNLYVTJ/JfGH1uaMlw0f
         8Jt+ukld53XtMw782f+4/68bl4Lzk6aviRS/Y=
Received: by 10.223.24.134 with SMTP id v6mr268424fab.146.1307543854132;
        Wed, 08 Jun 2011 07:37:34 -0700 (PDT)
Received: from sherwood.local ([89.204.137.155])
        by mx.google.com with ESMTPS id g7sm259358fac.39.2011.06.08.07.37.31
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 07:37:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST,SPF_PASS autolearn=no version=3.3.2-r929478
X-Spam-Checker-Version: SpamAssassin 3.3.2-r929478 (2010-03-31) on
	hera.kernel.org
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.3 (hera.kernel.org [140.211.167.34]); Wed, 08 Jun 2011 14:38:29 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175375>

@ J=C3=A9r=C3=A9mie NIKAES <jeremie.nikaes@gmail.com> wrote (2011-06-08=
 15:45+0200):
> But, when I look at the page on mediawiki, I see weird characters : =C3=
=83=C2=A9t=C3=83=C2=A9.
>=20
> I tried text =3D> encode_utf8('=C3=A9t=C3=A9') with no success.
>=20
> Do you have any information regarding this issue ?

I'm not a Perl guru, but i ran into the very same problem when
writing a disc-ripper/CDDB lookup/DB writer, and the following
snippet helped me out:

    $CDDB{TITLES} =3D $dinf->{ttitles};
    foreach (@{$dinf->{ttitles}}) {
        s/^\s*(.*?)\s*$/$1/;
        my $save =3D $_;
        eval { Encode::from_to($_, 'iso-8859-1', 'utf-8'); };
        $_ =3D $save if $@;
        Encode::_utf8_off($_);
    }

I forget the exact circumstances, but as far as i remember you
need to trigger the is-UTF-8 bit on the string object in an
discouraged (acc. to manual) way to make it work the way it
should.
--
Ciao, Steffen
sdaoden(*)(gmail.com)
() ascii ribbon campaign - against html e-mail
/\ www.asciiribbon.org - against proprietary attachments
