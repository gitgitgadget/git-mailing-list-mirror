From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git config --list --local?
Date: Tue, 03 Aug 2010 09:25:48 -0700 (PDT)
Message-ID: <m38w4npssl.fsf@localhost.localdomain>
References: <4C583EA5.5000406@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 18:25:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgKJQ-0004Ul-Mb
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 18:25:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757111Ab0HCQZv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 12:25:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49185 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756551Ab0HCQZu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 12:25:50 -0400
Received: by fxm14 with SMTP id 14so2065479fxm.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=hwqanvZpAJYiF5bo2Pvn5ECsU3To1RlXhnzpUIGOgFA=;
        b=i2weRjQ1i5Qf7BsiQ0Ok+QYaRpBqj8ygidPsnAIsdXZbHxckggdMuZG6Nim9wFhP0X
         sLLEJpM1dYMup7VPdZzngbgGg0VDS7704k0ylkKoEL7PR/lc8Pr7j3QhuBAdXoKCwGgz
         X938g7JIpGeZvKqbNmbOhwkLXeOFu9EX27o5U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=DP0TGeK2XuJ2/l2UVl/DuAtN+yEI4evOmKnegDvmkE6xg1c+FFZIbu5/LI0q8/twf2
         iS6JsWfe0fC9ZdMr4+lRgDyjmXBgNl8gztQskR/Ieon3xCe0gsoskZVMkn/t+lvet2i8
         lZHwvXVuhda0Z+W4kLLc9mNon2fJAkbkldTOc=
Received: by 10.223.110.67 with SMTP id m3mr7637835fap.24.1280852749576;
        Tue, 03 Aug 2010 09:25:49 -0700 (PDT)
Received: from localhost.localdomain (abws244.neoplus.adsl.tpnet.pl [83.8.242.244])
        by mx.google.com with ESMTPS id s20sm2575243faa.4.2010.08.03.09.25.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 09:25:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o73GPmqE001892;
	Tue, 3 Aug 2010 18:25:59 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o73GPUqU001884;
	Tue, 3 Aug 2010 18:25:30 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4C583EA5.5000406@workspacewhiz.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152525>

Joshua Jensen <jjensen@workspacewhiz.com> writes:

>   I would like git config to give me just the settings for the local
> repository (.git/config).  I am likely misreading the documentation,
> but it appears there isn't an option for that.
> 
> Would someone mind setting me straight?

AFAIK you can only fake it with

  $ git config --file .git/config --list

(or something like that).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
