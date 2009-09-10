From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: obnoxious CLI complaints
Date: Thu, 10 Sep 2009 18:50:24 +0200
Message-ID: <200909101850.26109.jnareb@gmail.com>
References: <ef38762f0909091427m5b8f3am72c88fd4dbfebc59@mail.gmail.com> <m3fxavvl5k.fsf@localhost.localdomain> <4C1FB36D-F8A6-4C01-A42A-8AD2355A9961@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brendan Miller <catphive@catphive.net>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 18:50:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mlmqs-0000Tw-Dl
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 18:50:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbZIJQuS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Sep 2009 12:50:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbZIJQuS
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 12:50:18 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:46857 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbZIJQuR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 12:50:17 -0400
Received: by fxm17 with SMTP id 17so239258fxm.37
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 09:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=CAb0KkrkEjaj4dlNNiuoQcvaWjsnOtyrJNtdTLyF2VE=;
        b=QwM11eBOoybQe1XVtvDPmlrD/0+OBiZhGuGDG9cfCM7T+OIpCMV7vfJcmDLCZtyUHK
         QWfWwKcx0LBZlPqwv9LTMled5C5/bw6CsyXPhC+9/+OQkTSnA01oPUcXwQ23cF0ma5uB
         txVGNqwsySgQfgd9cgxfkzDPgjnDzTKW4eZik=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=WCk3F7bX54cp0Ws5kZij9uzOMiB0Q0epEgAC2jW9ZMW9mWYiP63G4YS35SAIwFx6n/
         YTUy3rzZpLtzA8IR8O8ehBhuy8DSy125puS3XVHMhCwg48QeSBCPeIl1A8a4ZhdIeRYO
         4/sehYiOu4/09uQ4cwhwoIgBBh5tgpXDRA+qs=
Received: by 10.86.41.19 with SMTP id o19mr1370935fgo.45.1252601419327;
        Thu, 10 Sep 2009 09:50:19 -0700 (PDT)
Received: from ?192.168.1.13? (abwt218.neoplus.adsl.tpnet.pl [83.8.243.218])
        by mx.google.com with ESMTPS id e20sm607875fga.20.2009.09.10.09.50.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 10 Sep 2009 09:50:17 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4C1FB36D-F8A6-4C01-A42A-8AD2355A9961@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128126>

Dnia czwartek 10. wrze=B6nia 2009 00:06, Wincent Colaiuta napisa=B3:
> El 09/09/2009, a las 23:54, Jakub Narebski escribi=F3:
>> Brendan Miller <catphive@catphive.net> writes:
>>
>>> 5. Most commands require lots of flags, and don't have reasonable
>>> defaults. e.g. archive.
>>>
>>> $ git archive --format=3Dtar --prefix=3Dmyproject/ HEAD |=20
>>> > gzip myproject.tar.gz=20
>>>
>>> Should just be:
>>> git archive
>>> run from the root of the repo.
>>
>> I'd rather not have "git archive" work without specifying tree-ish.
>=20
> Why, out of interest? I would've thought that HEAD would be a pretty =
=20
> good default, although I confess that I have never used "git archive"=
 =20
> without specifying a particular signed tag.

=46irst, it would be consistent with how ordinary archivers such as tar
or zip are used, where you have to specify list of files to archive
(in our case this list is HEAD).  Second, I'd rather not accidentally
dump binary to terminal: "git archive [HEAD]" dumps archive to standard
output.

--=20
Jakub Narebski
Poland
