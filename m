From: Ping Yin <pkufranky@gmail.com>
Subject: Re: [PATCH/RFC] Hacky version of a glob() driven config include
Date: Sat, 8 May 2010 10:30:19 +0800
Message-ID: <u2p46dff0321005071930n21de08bcv62d88377f082521@mail.gmail.com>
References: <u2i51dd1af81004060115t5f837840z5adcf83622fa8882@mail.gmail.com>
	 <m3k4rfe90n.fsf@localhost.localdomain>
	 <AANLkTinCaPrThtuQd7tUFxNNn9KUx9v3_PXnH_6C8yco@mail.gmail.com>
	 <201005080143.21172.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	git <git@vger.kernel.org>, Eli Barzilay <eli@barzilay.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 08 04:30:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAZoJ-0007XB-4s
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 04:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136Ab0EHCaW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 May 2010 22:30:22 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:56823 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab0EHCaV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 May 2010 22:30:21 -0400
Received: by qyk13 with SMTP id 13so2677857qyk.1
        for <git@vger.kernel.org>; Fri, 07 May 2010 19:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9nEOUx2abkmZcLCNCWZg4q+oWdzmmz2As/riBtoIdog=;
        b=WOYoB/hYs1fpHBi5IWrncZUCIVLkF/hHPGZOevyF/IsdU2I3egVD3einJrP7hKgPd0
         l34gnGs8KCarTXjis8JFT2pY/pIaNz5JDod4MK9e6ilqV+aB21T2pc1LpyADkecJSgDE
         RinOeq8vr284aZet3Ty5D55l+Cbd0vnz0d7nU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PxAfd2mDWtCH2BjOW+3zwqHdS4+ddVxnAvlMA73PDAISpGPXpn+E37Tp0vCITjwB6e
         1kjavb3mUWqdLMnkHWhR6EfUAJY2FHOjQavQ70lWwKMR+1pMsrgzR2JcVKe2TCbtIcur
         mnr9gBDxBYmrOGYrJG3kJHQ6fBZC5JxkQ4ulk=
Received: by 10.224.78.204 with SMTP id m12mr469510qak.371.1273285819863; Fri, 
	07 May 2010 19:30:19 -0700 (PDT)
Received: by 10.229.83.145 with HTTP; Fri, 7 May 2010 19:30:19 -0700 (PDT)
In-Reply-To: <201005080143.21172.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146627>

>
> But perhaps we can break backwards compatibility here. =C2=A0I don't =
know...
>
I think we can. Because config file is not in repository, so if your
older git doesn't support it, you should not use this new syntax.
