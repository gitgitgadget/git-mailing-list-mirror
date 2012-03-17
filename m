From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git repo in a single file
Date: Sat, 17 Mar 2012 09:48:19 -0700 (PDT)
Message-ID: <m3bonvkwda.fsf@localhost.localdomain>
References: <20120317155445.GA18712@mailgate.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Enrico Weigelt <weigelt@metux.de>
X-From: git-owner@vger.kernel.org Sat Mar 17 17:48:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8wnq-0004JB-IF
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 17:48:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756568Ab2CQQsW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 12:48:22 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:53668 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751657Ab2CQQsV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 12:48:21 -0400
Received: by wibhj6 with SMTP id hj6so2149714wib.1
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 09:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=LuTu0KS+lk801TfV5KxUpqgzWGORLziNxRYmLjX72Qk=;
        b=0j8x6V/sDhAFlW2iNmflSSTMj0xmnLT941LwGcXlvEQa+pAdATc3IRCVf0shyMnfta
         q5G4HikwYxoTusc54YSthYhYeIKWy1U77401vUH4iOtRLmRNcr2+ZNoHtZpakMBCQaVP
         LMgsuHN4Bru5L4yJaUBYVdyQCpQQEdofWNpppvb/+vtdZE8jG1pCGRWFlFwddzDBSnPc
         7BRm3JFn+Bh8B/aWTUivEwhTLrbwzGK4L3rXj4unvt/5wuMLCKYSLO/i8fvJS/1EBIFE
         kxQEGdHyhXsI+XXSS0kSXShnOVMBVhBHHIx3nP/86TY83BiB4VT6ooiLnWSFhulNbGAR
         t0Og==
Received: by 10.180.96.228 with SMTP id dv4mr7238812wib.14.1332002900170;
        Sat, 17 Mar 2012 09:48:20 -0700 (PDT)
Received: from localhost.localdomain (aeho214.neoplus.adsl.tpnet.pl. [79.186.196.214])
        by mx.google.com with ESMTPS id ff2sm14594303wib.9.2012.03.17.09.48.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 09:48:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q2HGll4Q019918;
	Sat, 17 Mar 2012 17:47:58 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q2HGlU6l019904;
	Sat, 17 Mar 2012 17:47:30 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20120317155445.GA18712@mailgate.onlinehome-server.info>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193338>

Enrico Weigelt <weigelt@metux.de> writes:

> in several discussion with people eg. on office software fronts,
> I've seen the value of having an git repo in one file. For example,
> an office document, internally consisting of several files (like
> ODF) could be put into an git repo instead of zip. That would
> give a good basis for things like versioning, etc.

There is something like that in the form of git-bundle.
Perhaps it could be (ab)used to what you want.

-- 
Jakub Narebski
