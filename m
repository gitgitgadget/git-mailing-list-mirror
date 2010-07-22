From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: Re: Avery Pennarun's git-subtree?
Date: Thu, 22 Jul 2010 14:23:25 -0400
Message-ID: <4C488C9D.60606@gmail.com>
References: <4C472B48.8050101@gmail.com>	<AANLkTilivtS4TccZXHz2N_n_2RpY6q_5sw7zwdWKdnYE@mail.gmail.com>	<AANLkTinl1SB1x1bEObLIo-LWjvxM-Yf1PfdUp4DNJda3@mail.gmail.com>	<AANLkTikl2zKcie3YGhBHrGbYbX3yB9QCtuJTKjsAfK07@mail.gmail.com>	<AANLkTimiROxqf7KcRKTZvMvsFdd4w3jK_GLeZR8n7tdA@mail.gmail.com>	<4C4778DE.9090905@web.de>	<AANLkTim9nfRGjhpn2Mj-1GntLsDX7xeyL2pegB84aZX8@mail.gmail.com> <m31vavn8la.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?ISO-8859-15?Q?=3D=3Fiso-8859-15=3Fq=3F_=C6var_Arnfj=F6r=F0_Bjarm?=
	 =?ISO-8859-15?Q?ason=3F=3D?= <avarab@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 22 20:25:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oc0Sl-0007RQ-GL
	for gcvg-git-2@lo.gmane.org; Thu, 22 Jul 2010 20:25:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759563Ab0GVSXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jul 2010 14:23:48 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61950 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759749Ab0GVSXk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jul 2010 14:23:40 -0400
Received: by gwb20 with SMTP id 20so249273gwb.19
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 11:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=8XrbNVIoR4qjTWk9jFMuHmR+WPO4si6EuHY6ZwSOfVo=;
        b=JSfTiKTj5SneN7MZR6AYE3Xl9L0gG6/VL7fDLBsLrPFlXsoWKN/cugVFMZyEcsxSp6
         kzALIJd6SJ7HGY4GXRObMtqXHE4R5M45jqqrJFj1ImjO20uJPSVVo3oQSma4c7kdDdSn
         Bdg/eWqKoMoPdarXk1RWdgkw/0Cd0yQCrgY8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=GqR40GfQw5Dzq1F1KqbTHms4aZAje36PsQa10F1Xa2kD+4Fd7vhAITkKZDJwztmX26
         p6UEdXxQCK23zHPeN1XtjqQL48NJtUWfv8XS2/uzmwsN0e0FLGptFyNQdSA+sS5Qzbds
         iOg6w2ZVSudMvU5HKq19eX1mXDcP0A7JrJmjE=
Received: by 10.90.94.20 with SMTP id r20mr2446772agb.201.1279823014508;
        Thu, 22 Jul 2010 11:23:34 -0700 (PDT)
Received: from [192.168.1.102] (69-196-182-243.dsl.teksavvy.com [69.196.182.243])
        by mx.google.com with ESMTPS id e8sm30172892ibb.20.2010.07.22.11.23.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Jul 2010 11:23:32 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10) Gecko/20100528 Thunderbird/3.0.5
In-Reply-To: <m31vavn8la.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151469>

>
> Using git-subtree has its warts too: I don't think for example that there is
> a way to get a log _automatically excluding_ history subtree-merged
> subprojects.  Or is it there?
>

It works exactly right for me when I used git-subtree in "squashed" 
mode.  Changes which were done in tree show up separately in the log, 
changes which were pulled in via git-subtree pull show up as a single 
summary entry in the log.

This discussion has been about how to improve git submodules, which is 
sorely needed.   However, it's quite clear that git submodules will 
never work as well as git subtrees in certain quite common situations. 
  If fixed, git submodules will be more appropriate in other situations. 
   However, I'm not asking to remove git submodules or prevent anybody 
from fixing them, I'm just asking that git subtree be merged.

Does anybody actually oppose the merger of git-subtree, which has (at 
least) hundreds of users despite its out-of-tree status?

thanks,
Bryan
