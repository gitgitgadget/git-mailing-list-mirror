From: Thomas Adam <thomas.adam22@gmail.com>
Subject: Re: [PATCHv6 6/8] gitweb: add 'alt' to avatar images
Date: Sat, 27 Jun 2009 01:08:07 +0100
Message-ID: <18071eea0906261708k840737vaee1b1428cf70af2@mail.gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-6-git-send-email-giuseppe.bilotta@gmail.com>
	 <1245926587-25074-7-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906270139.55006.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 02:08:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKLSs-0005Dz-GH
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 02:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbZF0AIJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Jun 2009 20:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbZF0AIG
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 20:08:06 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:35604 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbZF0AIG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jun 2009 20:08:06 -0400
Received: by bwz9 with SMTP id 9so2307400bwz.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 17:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xK/S67ZUcz+zRyFXFFoSRLxdqPp41mRcWRUyQtShsPQ=;
        b=NuNeynMYMnAd9Z4HUBo5x3A5w5nxz0q6Ip867yCbOpm7wIsFfdDGoiBuhmTklXrCI9
         eAn3q7z/6nabx+h/VcZvqv41em/N6tTHzOMJUxQkYdbK60b+z0bS/inS1+CN+GuUx/ZQ
         g+Ir0h9qCnTw4HipFHFMETC0fglXAVxqnyLfA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PNGTgeVH3M9QnAONRU0sXe30Ymb5BOI2TO+Ft+D4KQaJW//F6/x0zPOzO0Rlm2sCSS
         1MQBquPCNW2KYQCVOOUTdKD091N7I5eAqgM2XnOGXtQOj3dPlIPawJ77qLyic6uPLsZm
         MTFPFJ2MTsNV0/z/sikQtH/GdXrZJ9uIrK1cA=
Received: by 10.204.116.15 with SMTP id k15mr4210904bkq.118.1246061287289; 
	Fri, 26 Jun 2009 17:08:07 -0700 (PDT)
In-Reply-To: <200906270139.55006.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122339>

2009/6/27 Jakub Narebski <jnareb@gmail.com>:
> After this patch:
> =A0* lynx =A0 show alt text, i.e. 'gravatar' (no [] to mark as image)
> =A0* elinks show alt text, i.e. 'gravatar' (no [] to mark as image)
> =A0* w3m show alt text, i.e. gravatar, in separate color (also no [])
>
> Lynx Version 2.8.5rel.1
> ELinks 0.10.3

That's an old version of ELinks.  ELinks 0.12 I think changed this
behaviour to at least try and display ALT tags by default.

-- Thomas Adam
