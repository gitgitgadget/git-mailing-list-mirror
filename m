From: bill lam <cbill.lam@gmail.com>
Subject: Re: [ANNOUNCE] tig-0.14.1
Date: Mon, 16 Feb 2009 18:34:00 +0800
Message-ID: <20090216103400.GB7458@b2j>
References: <20090215231101.GA7032@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Feb 16 11:35:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ0p8-0004BU-7C
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 11:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234AbZBPKeJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Feb 2009 05:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753795AbZBPKeI
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 05:34:08 -0500
Received: from ti-out-0910.google.com ([209.85.142.190]:49917 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753232AbZBPKeF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 05:34:05 -0500
Received: by ti-out-0910.google.com with SMTP id d10so1688063tib.23
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 02:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=F8Gnm85S3AZ32EcocBtyyGBKKTbSS6oeCtOCWy7Oe+o=;
        b=HnWwM981lwHkxzmwl1tyljy5d8rTngrX+xaDS1U5tixIS1gAA+tE0HKlgvcEBDf7ts
         29F1Wnwlud/96PlVffp7KeQ2WvB9VCGVRIkg6zl6jG/4xwSRPexPKWTnfD8g/J8/wsSy
         vsiCSKiXo5HAbnM77BVRIFUPifLOtcbQUMorM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        b=rW/lND1I7iNT8HdBBj6YJynBeU2ID0VcnMrh8om4MdFNlMb9uRorzNicC8rSd4DsFL
         SuWfo4tk5ZppI8OGQYyH4D1hkTowjLDmfjrDM0VL2fgj7+zZzosNgl5pDbQZyopKlEIa
         JxiZIXE1eKaeptACC3bbl/O0alxkiJJqKb4M8=
Received: by 10.110.69.14 with SMTP id r14mr458497tia.1.1234780443971;
        Mon, 16 Feb 2009 02:34:03 -0800 (PST)
Received: from localhost (pcd632183.netvigator.com [218.102.164.183])
        by mx.google.com with ESMTPS id a4sm58766tib.31.2009.02.16.02.34.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Feb 2009 02:34:03 -0800 (PST)
Mail-Followup-To: Jonas Fonseca <fonseca@diku.dk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20090215231101.GA7032@diku.dk>
User-Agent: Mutt/1.5.19 (2009-01-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110163>

Thank you another update.

I was ignorant that readline did not work well with ncurses.  Anyway
will it be easier to make backspace act as ^H and uparrow to recall
the last input line?

--=20
regards,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
=E5=94=90=E8=A9=A9123 =E7=8E=8B=E7=B6=AD  =E7=B5=82=E5=8D=97=E5=88=A5=E6=
=A5=AD
    =E4=B8=AD=E6=AD=B2=E9=A0=97=E5=A5=BD=E9=81=93  =E6=99=9A=E5=AE=B6=E5=
=8D=97=E5=B1=B1=E9=99=B2  =E8=88=88=E4=BE=86=E7=BE=8E=E7=8D=A8=E5=BE=80=
  =E5=8B=9D=E4=BA=8B=E7=A9=BA=E8=87=AA=E7=9F=A5
    =E8=A1=8C=E5=88=B0=E6=B0=B4=E7=AA=AE=E8=99=95  =E5=9D=90=E7=9C=8B=E9=
=9B=B2=E8=B5=B7=E6=99=82  =E5=81=B6=E7=84=B6=E5=80=BC=E6=9E=97=E5=8F=9F=
  =E8=AB=87=E7=AC=91=E7=84=A1=E9=82=84=E6=9C=9F
