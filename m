From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: Why does adding an existing repo as a submodule modify .git/config?
Date: Mon, 23 May 2011 21:19:02 -0400
Message-ID: <4DDB0786.5020006@gmail.com>
References: <irbq5a$h38$1@dough.gmane.org> <4DDAAAD2.1010708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christopher Wilson <cwilson@cdwilson.us>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue May 24 03:19:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOgHB-0005V8-O8
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 03:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934214Ab1EXBTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 21:19:08 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:63258 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753811Ab1EXBTG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 21:19:06 -0400
Received: by vxi39 with SMTP id 39so4562027vxi.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 18:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=A+lWop0F3ZO2vqD3WVS0kZM5oIgehHlDOThrfXjsSW4=;
        b=oQf8sg62NddDxxfkfjmm63ZXUEzcjY3K9EVV7pjsGhWI4aCpzLxAAom4nDVVE961q0
         4ge/Uiio4b1q6T3LxuabJTWcZ7KXUin8dPVEighmJN5Q4LPdy3oDWfH+Dq6+pG32Lwww
         g1lpTdYIskmzm26oWCbxdDHJG/ax3vAXE1xKg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=WTzecyTskZjPJJAsvTWH5DRyVsQnKejdcBSHxSLcdGm+whdiHcs+Mdz2CDOlPBAjwa
         sxoz51ySOnaw5XDZnh4xbEbFtgjF3E1xdFNib71hDPKVJ5wX36HDx2e4/qspHKIX5NYv
         pVk2gI6ydiRsYFy+YDBR5K3AWoP7N3ngR7VrY=
Received: by 10.220.106.6 with SMTP id v6mr869249vco.225.1306199945048;
        Mon, 23 May 2011 18:19:05 -0700 (PDT)
Received: from mark-laptop.lan (pool-108-28-57-40.washdc.fios.verizon.net [108.28.57.40])
        by mx.google.com with ESMTPS id c8sm1482576vcc.9.2011.05.23.18.19.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 May 2011 18:19:03 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DDAAAD2.1010708@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174309>

On 05/23/2011 02:43 PM, Jens Lehmann wrote:
> Am 22.05.2011 22:02, schrieb Christopher Wilson:
>
> Hmm, this looks like an inconsistency to me too. It would be great
> to hear about the background, so I added Mark to the CC, maybe he
> can shed some light.
>
I think the comment in c2f939170c651 describes the reasoning well 
enough. (You may disagree with the reasoning, but that is a different 
matter :^).

Mark
