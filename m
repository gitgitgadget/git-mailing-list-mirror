From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/4] rev-parse: deprecate use as an option sifter
Date: Fri, 14 May 2010 08:41:19 -0700 (PDT)
Message-ID: <m3y6fmcx0n.fsf@localhost.localdomain>
References: <20100505033536.GB8779@coredump.intra.peff.net>
	<725860e3bfc692c7241695ef5f554ff73f277b15.1273760226.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri May 14 17:41:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCx15-0001Kb-QC
	for gcvg-git-2@lo.gmane.org; Fri, 14 May 2010 17:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753554Ab0ENPlb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 May 2010 11:41:31 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:40069 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312Ab0ENPlW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 May 2010 11:41:22 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1718743fga.1
        for <git@vger.kernel.org>; Fri, 14 May 2010 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=m23/NotPy+6wv53SyWg4L+cJUgSNyCocToBL1ViLriQ=;
        b=qptkDf4kF06kQlT/m7Nl1BcJtgg/LDMdIkCrR+8OvYJbzpmXc+6mPKncuZUOlZUDep
         dIithKlZAdOLZ7AFla2P4IOYaFXhJ5qr8vCtv1bsbPRA4bpIxtQBTBrP8VTHyWLwh0cK
         +7NewUAid5diBFI4iFjFipI0MWow5Rk0w/C3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=rTvx7ReyBWnaG6oHHUXcf5PwswYU7ugU4o+P8MIrICi+L1GKJCwusdWTBCj0Gj4ZS6
         ixFFHCxrHZ2qY1JEcKCbaIVR5VDdjYQW3aOa2bHHnu2sa/vFpG94rKrLcGUQbPG+NaeA
         Fzsi95MUDFP8xhc6IehBXvrvPOvb+vssaNZ18=
Received: by 10.87.48.34 with SMTP id a34mr3120753fgk.2.1273851681062;
        Fri, 14 May 2010 08:41:21 -0700 (PDT)
Received: from localhost.localdomain (abvp84.neoplus.adsl.tpnet.pl [83.8.213.84])
        by mx.google.com with ESMTPS id e17sm3622061fke.57.2010.05.14.08.41.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 14 May 2010 08:41:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o4EFeZQx005968;
	Fri, 14 May 2010 17:40:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o4EFe8p1005957;
	Fri, 14 May 2010 17:40:08 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <725860e3bfc692c7241695ef5f554ff73f277b15.1273760226.git.git@drmicha.warpmail.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147094>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>  NAME
>  ----
> -git-rev-parse - Pick out and massage parameters
> +git-rev-parse - Parse symbolic names into object names

What about "git rev-parse --parseopt"?  Isn't it massaging parameters?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
