From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-submodule documentation: fix foreach example
Date: Sun, 28 Jun 2009 05:34:23 -0700 (PDT)
Message-ID: <m3tz20wmzv.fsf@localhost.localdomain>
References: <20090628113931.GC10895@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Levedahl <mlevedahl@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jun 28 14:34:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKtaa-0007Mm-SF
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 14:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbZF1MeW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 08:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbZF1MeV
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 08:34:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:56678 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbZF1MeV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 08:34:21 -0400
Received: by fg-out-1718.google.com with SMTP id e12so294017fga.17
        for <git@vger.kernel.org>; Sun, 28 Jun 2009 05:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=q06BWk2RDgshowcH/OddpPyR6oanqAMx1/iwINJSeko=;
        b=q3WCGV0qiLXOvx56gX3tPJ1kGRA/voFcrYQvsIua4twf9uQDzEhGvAJHOfF8jGK+Pl
         lKm1ZnJJ8RPifOth3ePKs5BSqmT31Gx8SE+tRHokmeysycM3G41GiWE9qH91Agy+ybyr
         EeS52OTRC0cLWYtboQDwRKdUfzYNqz/OWgLdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=OavWLdxC+WUBVxgDj7LdFrYoO3OasiV5wpVVJbZnmnOO63qKfHkSqqXSbo21JSdDDF
         1whRVU1WjS8vwFSCrx1AlfF5PaAoWkxA+sEtInKqzc+adoSc4htWLTUwjJ+Kg4epLuw5
         oXeK+VFqgTL1PxFSpphaGCfNk9ZERxBFDC2Dg=
Received: by 10.86.66.20 with SMTP id o20mr192351fga.15.1246192463338;
        Sun, 28 Jun 2009 05:34:23 -0700 (PDT)
Received: from localhost.localdomain (abvg228.neoplus.adsl.tpnet.pl [83.8.204.228])
        by mx.google.com with ESMTPS id 4sm4279241fgg.2.2009.06.28.05.34.22
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Jun 2009 05:34:23 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5SCdqQF024718;
	Sun, 28 Jun 2009 14:39:52 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5SCdnp3024712;
	Sun, 28 Jun 2009 14:39:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090628113931.GC10895@genesis.frugalware.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122401>

Miklos Vajna <vmiklos@frugalware.org> writes:

> Backstick and apostrophe are asciidoc markup, so they should be escaped
> in order to get the expected result in the rendered manual page.

[...]
>  startsb=&#91;
>  endsb=&#93;
>  tilde=&#126;
> +backstick=&#96;

It is 'backtick' (or 'backquote'), not 'backstick'.  There is no 's'
in its name.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
