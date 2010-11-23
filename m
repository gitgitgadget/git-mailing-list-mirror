From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Tue, 23 Nov 2010 10:32:01 +0100
Message-ID: <m2zkt0jsha.fsf@gmail.com>
References: <m2oc9hkurl.fsf@gmail.com>
	<1290458128.29678.23.camel@drew-northup.unet.maine.edu>
	<m2k4k5ks0b.fsf@gmail.com>
	<1290461070.5468.5.camel@drew-northup.unet.maine.edu>
	<m2bp5glbrp.fsf@gmail.com> <4CEB7F1F.809@drmicha.warpmail.net>
	<m27hg4l8a3.fsf@gmail.com> <4CEB8774.7050504@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Nov 23 10:32:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKpEX-0007dh-D3
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 10:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab0KWJcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 04:32:07 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53002 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752550Ab0KWJcG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 04:32:06 -0500
Received: by wwa36 with SMTP id 36so8451627wwa.1
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 01:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=pFIbsuTQxT+C+txNIz0dMMTqtYhosnHjpAcAw41kuWs=;
        b=GJNjkDhOEO3D2uT8em+8fUbLCz2I7OI74bOruNahnYJtDZye9lOXUIhNFC9tqwa8AR
         XHPZZEf0dEzs5c7Y/5Wgt1sJZ0cl9tM/ejRICVSmT6lk0RQhJx8CZUF9ea/I20p5u3/p
         q3rnp3CfsgYDb/3OjEc9cefSe7DIty0ZWSrTY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=NAaF1ZFxHvKJZIzpA2wPsuVRZ+a9CH4YUfzR5iAjpTqasrFDF6Oyu8klzUwiTe9yLQ
         AZ7FsTEcsGpdzpRAXlQXpUQOPM/+bn/VwJFCUhlLPRQVd4IS5dgkf6kminbzmegli9Sv
         7V7LQ9j039eznCiGzjlLrDG/KepOn+LcyIrfo=
Received: by 10.227.145.66 with SMTP id c2mr7354127wbv.34.1290504725205;
        Tue, 23 Nov 2010 01:32:05 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id k4sm2745998weq.9.2010.11.23.01.32.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 23 Nov 2010 01:32:03 -0800 (PST)
In-Reply-To: <4CEB8774.7050504@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Tue, 23 Nov 2010 10:20:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161937>

Michael J Gruber <git@drmicha.warpmail.net> writes:

[...]

>
> That's what they all say ;)
>

But they were all drunk ;)

>
> How successful is:
>
> make XMLTO_EXTRA="--skip-validation" doc
>

still failing:

  $ make prefix=/usr/local NO_CURL=1 ASCIIDOC8=y DOCBOOK2X_TEXI=db2x_docbook2texi ASCIIDOC_NO_ROFF=y XMLTO_EXTRA="--skip-validation" V=1 doc
  make -C Documentation all
  make[1]: Entering directory `/home/fmoreau/git/Documentation'
  make -C ../  GIT-VERSION-FILE
  make[2]: Entering directory `/home/fmoreau/git'
  make[2]: `GIT-VERSION-FILE' is up to date.
  make[2]: Leaving directory `/home/fmoreau/git'
  rm -f git-fetch.1 && \
  xmlto -m manpage-normal.xsl --skip-validation man git-fetch.xml
  I/O error : Attempt to load network entity http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
  warning: failed to load external entity "http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl"
  compilation error: file /tmp/xmlto-xsl.A7kzn5 line 4 element import
  xsl:import : unable to load http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
  make[1]: *** [git-fetch.1] Error 1
  make[1]: Leaving directory `/home/fmoreau/git/Documentation'
  make: *** [doc] Error 2


> This should avoid hitting the network for the dtd under all
> circumstances. (Are you online when make'ing?)

Yes I am.

> Normally, the catalogue should take care of that but this seems to be
> failing for you.
>
> Just to make sure: You're not building as root, are you?
>

No, I'm not building as root.

> You can also use the quick-install-doc target, of course, but we want
> install-doc to work as well on a mainstream distro.

Yes I know but I wanted to report just in case there's something wrong
in the git doc build process.

Thanks
-- 
Francis
