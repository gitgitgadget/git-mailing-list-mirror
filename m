From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv2] gitweb: Better regexp for SHA-1 committag match
Date: Sat, 7 Feb 2009 15:01:31 +0100
Message-ID: <200902071501.34312.jnareb@gmail.com>
References: <200902022204.46651.toralf.foerster@gmx.de> <b77c1dce0902060231u358587d5o940eb322fde52a68@mail.gmail.com> <200902061149.16210.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Toralf =?iso-8859-2?q?F=F6rster?= <toralf.foerster@gmx.de>
To: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 07 15:02:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVnl7-0000MA-QN
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 15:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751837AbZBGOAo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Feb 2009 09:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbZBGOAo
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 09:00:44 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:53823 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbZBGOAo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 09:00:44 -0500
Received: by fxm13 with SMTP id 13so1779491fxm.13
        for <git@vger.kernel.org>; Sat, 07 Feb 2009 06:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=lRAexLAHdrzo08Oei7utLOh46U5MY3V0Ct1qGyYrJN4=;
        b=cCXnjGtHSCPlqbW89SAydwIBdUl6oYoO+PjoOvxLBYGpxCsr8edRI942GZo1BKWsNP
         f2yN71lheiQjXxTfKdeEMsRY6h8ohsF0ApDa/4q9UXUYyV/BEfbEqiV8myZctaenJTpP
         9Dvi72D7cDdzu6SMZx8xUowgPZeHwxP2j/ZqU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=VhEyih2HOeSSWVKjxxKXZBam8R0XAEaM0P6x0Weq8VvcUsBAZTrjZWt5eccswW75v/
         SgpEZ4ylU6ysX8JODoIhOFhikMt8FH4P3Ls2/60C9L0ZOr/hUc6cWuVUbjOO/oTybCRz
         ebLiGm7dNfOLTjjsqgfgOnsvFEomO1gI9lBpc=
Received: by 10.223.106.69 with SMTP id w5mr150002fao.17.1234015241815;
        Sat, 07 Feb 2009 06:00:41 -0800 (PST)
Received: from ?192.168.1.13? (abwn77.neoplus.adsl.tpnet.pl [83.8.237.77])
        by mx.google.com with ESMTPS id k29sm434893fkk.36.2009.02.07.06.00.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 07 Feb 2009 06:00:41 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <200902061149.16210.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108853>

Dnia pi=B1tek 6. lutego 2009 11:49, Jakub Narebski napisa=B3:

> +	if ($line =3D~ m/\b([0-9a-fA-F]{8,40})\b(!?\@)/) {

+	if ($line =3D~ m/\b([0-9a-fA-F]{8,40})\b(?!\@)/) {

Not that it matters, because adding such single-case exceptions
is not a good idea, so it is v1 which would be (I hope) in git.

--=20
Jakub Narebski
Poland
