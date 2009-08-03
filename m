From: Jakub Narebski <jnareb@gmail.com>
Subject: Working on Git on MS Windows (was: Re: Git Logo)
Date: Mon, 03 Aug 2009 09:02:02 -0700 (PDT)
Message-ID: <m38wi0rine.fsf_-_@localhost.localdomain>
References: <d411cc4a0908030753r7bbe4038lf05c416530db46ed@mail.gmail.com>
	<742707500908030807k138c3fcco58ccc8af26c37d7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <thiago.farina@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 18:02:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXzzn-0001Us-Un
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 18:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755368AbZHCQCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2009 12:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755367AbZHCQCE
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 12:02:04 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:10400 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365AbZHCQCD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2009 12:02:03 -0400
Received: by ey-out-2122.google.com with SMTP id 9so967626eyd.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 09:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=1beCjlJIC5UXbE98J1fzEwz8pvlWggW5confJM/DkTs=;
        b=E2izFOm7ZsihHNOhJE9yXKnBEbb1HZ7QLqJWZ/S6t5/opzrb4YOY5PotMhlW02CfU5
         XwSQYaRlelvDJpd2NcWRXeWTvaG/CMLitB020cei+8XVLzLMZHqIiu3+jl84K3wdQGJx
         Sp9t5qi6xZHhOCSrv8KQ7K8LJvm5Ge35onIfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=R9IOFdV8nfVuqguNXYdmdsXx8EEdfDOYia/yfsGKlkeMQw6b8/LKhbHE3k9hxxi/SU
         GxjGMynplR37fIQqk+5bfvYbKzo5ZKp6UenFEmHDJQ1TbSBqvAVMpTwpK61h4igE0Eid
         gtE4mrlVgu/LuPVbdd9k7tsucMkJN0Wm8F9Ss=
Received: by 10.210.141.9 with SMTP id o9mr5286246ebd.10.1249315322544;
        Mon, 03 Aug 2009 09:02:02 -0700 (PDT)
Received: from localhost.localdomain (abvc247.neoplus.adsl.tpnet.pl [83.8.200.247])
        by mx.google.com with ESMTPS id 24sm659475eyx.43.2009.08.03.09.02.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 Aug 2009 09:02:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n73G1amm013278;
	Mon, 3 Aug 2009 18:01:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n73G1P2P013274;
	Mon, 3 Aug 2009 18:01:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <742707500908030807k138c3fcco58ccc8af26c37d7d@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124700>

Thiago Farina <thiago.farina@gmail.com> writes:

> Hi guys,
> 
> I'm new to git, I already downloaded the msysgit. I'm working with git
> a couples weeks now. But I want to start debugging the git source code
> in Windows. How can I do that? Can I do that using Visual Studio, or
> there are other methods to debug git?
> 
> Thanks all, great work!

First, please do not post unrelated message as a followup; this
message should be start of new thread, and have appropriate subject
(like the one above).

Second, do not toppost.  Third, only quote what is necessary.


Git uses GNU make as a build tool, so I am not sure if you can develop
Git with MS Visual Studio.  You should have GNU make installed if you
have chosen appropriate version of msysGit (the one with developer
tools).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
