From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Tests in Cygwin
Date: Fri, 8 May 2009 18:45:43 +0200
Message-ID: <81b0412b0905080945k46753edcy377cdaf5c4eb2e43@mail.gmail.com>
References: <83prfbhasp.fsf@kalahari.s2.org>
	 <4A01E64C.7050703@SierraAtlantic.com>
	 <7vvdoet13g.fsf@alter.siamese.dyndns.org>
	 <4A028A0A.5070003@viscovery.net> <4A030277.2000708@SierraAtlantic.com>
	 <20090508020037.GA1264@coredump.intra.peff.net>
	 <4A03CAFE.4060503@viscovery.net>
	 <7v4ovwaygf.fsf@alter.siamese.dyndns.org>
	 <81b0412b0905080228j6b114631p35395464c0c98540@mail.gmail.com>
	 <4A043F7E.5070702@SierraAtlantic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>, Hannu Koivisto <azure@iki.fi>,
	git@vger.kernel.org
To: Don Slutz <Don.Slutz@sierraatlantic.com>
X-From: git-owner@vger.kernel.org Fri May 08 18:45:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2TCr-0005jO-FE
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 18:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754327AbZEHQpo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2009 12:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753171AbZEHQpo
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 12:45:44 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:36225 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456AbZEHQpn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 12:45:43 -0400
Received: by fxm2 with SMTP id 2so1499116fxm.37
        for <git@vger.kernel.org>; Fri, 08 May 2009 09:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Kg2fMCK3LjGb7aVfW/XZVCiawHWUit58VCmMz2ypAZs=;
        b=Y/AnJAJyB2F1p8gPDx2qXOKqOoWRUth/ZvGxVzP90YYoyiWRLU1Wi8PBJDUpwqESzU
         dpdWhVa4G7jTIQto/SwQ2TiajVcCo8+JxxVF+E2/gmmpOCEEEg3XiDjmJ3qKVmApdEZj
         RkS8QzlnHYbW2yGQ4nHQEVKEAZGMxFIARW/Zc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=F1JLH4EOkxLbmghEgCaduVPChui8pZNqygcaxJE8epKmuny9W/L3N1AiEBgBC/c8/1
         OwYSid2Zj3pyrpl4KLG4lpfpK84HF6ZSY/JC9qoNl59Ul4TIBXEiGf5N9GGlmmiFYh+9
         o0zYy3VIdA8FPqnDN4rLx1pYnDdNncVlsPnPg=
Received: by 10.204.102.76 with SMTP id f12mr3739821bko.137.1241801143218; 
	Fri, 08 May 2009 09:45:43 -0700 (PDT)
In-Reply-To: <4A043F7E.5070702@SierraAtlantic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118617>

2009/5/8 Don Slutz <Don.Slutz@sierraatlantic.com>:
> Here is some testing that does not require a sub-shell and does suppo=
rt
> options:
>
> rhf2-1:~/tmp>foof() { local IFS=3D' =C2=A0 =C2=A0 =C2=A0 ,+';local ar=
gs=3D"$*"; for i in $args;
> do echo i=3D$i; done; }

I like this :)
