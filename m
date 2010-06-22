From: Pascal Obry <pascal.obry@gmail.com>
Subject: Re: [PATCH v3] Do not decode url protocol.
Date: Tue, 22 Jun 2010 19:22:40 +0200
Organization: Home - http://www.obry.net
Message-ID: <4C20F160.2010203@obry.net>
References: <AANLkTik2M4Wxa-C6iRf7ShlcrwXu1ALNXtKwbA-mO5ge@mail.gmail.com>	<vpq39wf82y3.fsf@bauges.imag.fr> <4C20E92B.1030405@obry.net> <vpqfx0fxaeo.fsf@bauges.imag.fr>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 22 19:21:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OR7AO-0000cD-40
	for gcvg-git-2@lo.gmane.org; Tue, 22 Jun 2010 19:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756746Ab0FVRVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jun 2010 13:21:35 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:40299 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756697Ab0FVRVd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jun 2010 13:21:33 -0400
Received: by wyi11 with SMTP id 11so50906wyi.19
        for <git@vger.kernel.org>; Tue, 22 Jun 2010 10:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :organization:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=QLxkCaAPBH08/9IR7AmpOvJw+h8TPZ/AGAU0dr6shAs=;
        b=DyEABZWGL03wzw8nkCnZzvw7jRH2p2FLuk3qjq8qgjxMhn79ZFxmn+PwY0XMpjKuXF
         YDDFgxyAnyWzC/F+pKr9F1R+ywFfTPrNpKIlp1Gm6yyqcE0zrH3PeXedEN4WwS1DpnkN
         68YMRRsdO3+xP451fFe55KMWR+xqCCVhbuCbw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:organization:user-agent:mime-version
         :to:cc:subject:references:in-reply-to:x-enigmail-version
         :content-type:content-transfer-encoding;
        b=aWI44OnH5KFJvheJkxSL4t7DqW3RBoTF8nUlpjsOZSI2xkx+zIc3zPOjpSb0gRaGH1
         /yyXMEhHKiTFWoSBhDn21WgGdbz8Jfjk6DXOXuK5mx2Nh0alf2kNHu4bnQgy1a6/3zh0
         hpuQvWcbrXocqn791j8M3ERzKrEiHgctD7iQY=
Received: by 10.227.127.148 with SMTP id g20mr6331327wbs.192.1277227291744;
        Tue, 22 Jun 2010 10:21:31 -0700 (PDT)
Received: from [192.168.0.100] (AVelizy-154-1-11-160.w82-124.abo.wanadoo.fr [82.124.73.160])
        by mx.google.com with ESMTPS id k33sm4643133wbn.12.2010.06.22.10.21.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 22 Jun 2010 10:21:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <vpqfx0fxaeo.fsf@bauges.imag.fr>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149486>

Matthieu,

> which advances "query" as the URL is decoded, hence passing query as a
> pointer to the argument being parsed, not to the full URL.

Ok, I've missed that and I'm wrong :) Will propose another patch.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
