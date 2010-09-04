From: Pascal Obry <pascal.obry@gmail.com>
Subject: Re: [PATCH v2 3/3] New send-email option smtpserveroption.
Date: Sat, 04 Sep 2010 22:09:48 +0200
Organization: Home - http://www.obry.net
Message-ID: <4C82A78C.6090602@obry.net>
References: <1283630128-3472-1-git-send-email-pascal@obry.net> <1283630128-3472-4-git-send-email-pascal@obry.net>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 04 22:09:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orz3R-00049f-5a
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 22:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753430Ab0IDUJb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 16:09:31 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62061 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab0IDUJb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 16:09:31 -0400
Received: by wyf22 with SMTP id 22so1388377wyf.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 13:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :organization:user-agent:mime-version:to:subject:references
         :in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=f4ItgMVwy2dmTyVDFDVczT82UVX++4rsBaQ8qOlHg+Y=;
        b=g5qDoTbzJ7zgEPai/86AWOLcxNGdW+OTrTeYNnzh8lUaXnB9Wl9D9QNSx6UpIJuNSU
         DeZZ3fanlQzEGgg/GbqDoQuulMMYP90ZZ6FuC/FhqTlapJ0Yq5+9jvT+q3EJGQj7K8h4
         3O4sxdfasUiTDy0FvoyfcqrJ9Lg9tixeSy3Zs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:organization:user-agent:mime-version
         :to:subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=ikJGtuR7s4ZwkWt4kfb/sH6DLru6/AV7bjahJOiVmLD9h4qHz93ewlhgSCMQ+TbF2h
         s4xRCkNFKTTHi/RlYIe9xcZUBpF5nc6BVpYMi1BAr1HDG1JDb3ID8zFTzyvpvxQdq2kx
         ha/Syhhuyzk2heVH+l3fvOS8Yiog/cJvHp/pM=
Received: by 10.227.147.75 with SMTP id k11mr1043448wbv.161.1283630968271;
        Sat, 04 Sep 2010 13:09:28 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-100-4.w90-2.abo.wanadoo.fr [90.2.58.4])
        by mx.google.com with ESMTPS id a1sm2918932wbb.14.2010.09.04.13.09.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 04 Sep 2010 13:09:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <1283630128-3472-4-git-send-email-pascal@obry.net>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155354>

Le 04/09/2010 21:55, Pascal Obry a =E9crit :
> +--smtp-server-option=3D<options>::

should be:               ^
                         option

Will issue another patch set (waiting for feedback on v2).

Pascal.

--=20

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
