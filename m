From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [ANNOUNCE] diffit - A git plugin for vim
Date: Sat, 15 May 2010 07:40:22 -0700 (PDT)
Message-ID: <m3tyq9cjq2.fsf@localhost.localdomain>
References: <20100515105009.GA10517@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sat May 15 16:40:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODIXW-00069b-Od
	for gcvg-git-2@lo.gmane.org; Sat, 15 May 2010 16:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753534Ab0EOOkZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 May 2010 10:40:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:34373 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240Ab0EOOkY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 May 2010 10:40:24 -0400
Received: by fg-out-1718.google.com with SMTP id d23so2077432fga.1
        for <git@vger.kernel.org>; Sat, 15 May 2010 07:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Jxl2EHu8unmXs7gDfwx7ctvi7lnVWsKaaf8TgAsm9QE=;
        b=NxL/hz53lpmGoX4TYuRSikk2KPgPAvpAsAuNPKu3J68dsWWz0Oe5P1+zpNI2tCHG3P
         hiY0cYxPFt3DmFHPYhErM3raLHTqTHTuyR2Twr4f62fS0SuLRu8n3ruLKs/CZera4Ypn
         KT0KnB4A1TW+YrN9iE2MXKXFeUvSn7rjOqRCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=LRavhvZiki8Wjtdx8/OWtD1+7Vv/LlRtY+TeOgDsrRenrxLkhS7PZqEt+EWyi6saa6
         lqArPAv5MhoEcCRGRMiZKf5eBCdJoxMNQJGhZz4rEn7Gp0+FikYF/zbT88ircH1grfn1
         bNzg09xdigayhSSx2t9H0jyai3bdDKzgi4tfY=
Received: by 10.87.71.7 with SMTP id y7mr4822107fgk.63.1273934422868;
        Sat, 15 May 2010 07:40:22 -0700 (PDT)
Received: from localhost.localdomain (abvn155.neoplus.adsl.tpnet.pl [83.8.211.155])
        by mx.google.com with ESMTPS id 12sm4874541fks.20.2010.05.15.07.40.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 15 May 2010 07:40:22 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o4FEdojg005964;
	Sat, 15 May 2010 16:40:01 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o4FEdYAv005955;
	Sat, 15 May 2010 16:39:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100515105009.GA10517@localhost>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147152>

Clemens Buchacher <drizzd@aon.at> writes:

> I am currently working on a git plugin for vim. My aim is for it to imitate
> much of git-gui's functionality. Right now, it is still closer to "add -p".
> 
> But I believe it's already useful. And since I'm new to vim scripting, it
> can use some testing.
> 
> To install, copy diffit.vim (attached to this email) to
> ~/.vim/plugin/diffit.vim .
> 
> To toggle diffit mode, use <Leader>d, where <Leader> is '\' by default.
> 
> Control keys:
> 
>  <Leader>d      toggle diffit mode
>  s              stage hunk
>  d              skip file

> You can clone diffit from here.
> 
>  git://repo.or.cz/diffit.git
>  http://github.com/drizzd/diffit.git

Could you add information about 'diffit' to "Interfaces, Frontends And
Tools" page on Git Wiki:
  https://git.wiki.kernel.org/index.php/InterfacesFrontendsAndTools
in the 'Editors and IDE integration' section?

Thanks in advance.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
