From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: unable to retrieve new files from the server
Date: Sat, 11 Sep 2010 10:41:13 -0700 (PDT)
Message-ID: <m3mxrokwkw.fsf@localhost.localdomain>
References: <1284223572247-5521801.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy <hoangtu69@yahoo.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 19:41:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuU51-0003aB-P7
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 19:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140Ab0IKRlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Sep 2010 13:41:17 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61185 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133Ab0IKRlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Sep 2010 13:41:16 -0400
Received: by eyb6 with SMTP id 6so2278622eyb.19
        for <git@vger.kernel.org>; Sat, 11 Sep 2010 10:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=lNGIPl9/s6T6lKJoi54nKYvWG6YhtjRTxqb44UXUoDo=;
        b=clATR7+qcEwN/XCyyBUCNQU3v//50tARiZ1m/snYCakwqFLBvFxKo3gy4obvvneTM/
         667fKQIjag9tEOR2jY62TfuSxQwvSVPog/uSmfgpaoXcoJtS3NYJJDEqST2qg1hZql1b
         wokz/BwQm1z4HUPj0zENZ/893c5RW5WRmoaEE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=NyRPsLRc3+67ciroz43JmSh6EdX5dT3ukaOORoSPevzhluLcWozJ2GeOT5YM225/DG
         tdY5modpqMBLWiV24Mz76stAmpVY+UutCPIALx7BYmK6KJBQF0zWm4EqFjc8DiVSZyB5
         Np52JHf0nvBmZcSHS2M/Q6jIPLbdvuLqzeDE0=
Received: by 10.14.47.69 with SMTP id s45mr1404676eeb.9.1284226874409;
        Sat, 11 Sep 2010 10:41:14 -0700 (PDT)
Received: from localhost.localdomain (abvl188.neoplus.adsl.tpnet.pl [83.8.209.188])
        by mx.google.com with ESMTPS id v8sm6036543eeh.14.2010.09.11.10.41.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 11 Sep 2010 10:41:13 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8BHelNU004675;
	Sat, 11 Sep 2010 19:40:53 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8BHeWl9004668;
	Sat, 11 Sep 2010 19:40:32 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1284223572247-5521801.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156002>

Andy <hoangtu69@yahoo.com> writes:

> I did a git clone https://..../abc.git.  everything was fine.
> 
> Now there are new files on the server and I did a git pull and it said
> everything is up to date.  But I still do not see the new files on my
> machine.  
> 
> How do I pull all new files down to my machine?

Did those files were comitted?  If you are using "dumb" HTTP
transport, is git-update-server-info run on server after committing?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
