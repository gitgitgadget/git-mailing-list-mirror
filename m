From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Enhanced auto-discovery of httpd location and call conventions.
Date: Thu, 12 Jun 2008 00:52:36 -0700 (PDT)
Message-ID: <m3r6b3qedj.fsf@localhost.localdomain>
References: <1213235480-21925-1-git-send-email-flavio@polettix.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: "Flavio Poletti (polettix)" <flavio@polettix.it>
X-From: git-owner@vger.kernel.org Thu Jun 12 09:54:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6hd2-0001ay-J2
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 09:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbYFLHwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 03:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753530AbYFLHwk
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 03:52:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:26419 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbYFLHwj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 03:52:39 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2400784fgg.17
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 00:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=N8y68dyKURE0FIjla/VRctuvzc1pIHOgHMTX2BcuUpM=;
        b=JLKB8qlUUiFPOVCa4x91tU1KPtIm4+alXrazE6dFnGiUqQ7xid5fwkwWHceNEA7sx7
         aenTGYE4E85oaUNkGG3/2YNfvG5vogI5Avw6TNVOZQIaFsrQVahaKExTmlr6++oSDZja
         KP2eFc0UJ3zZ34hFf8XW+IO0Fac8R1oDRf1v8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=RSUfLajWc67XrjxI12v1I7uHORqHNu5NB3ULGy/daVoOLBFNK8k5Sq86WUrNv5Rx/m
         kpVzAaAvAuoq1FQ5tNQQhLyJbt+SHplmzzw79sskbcZcTevXW9Ozjh4omPUa5O05aOoN
         53by6nKEM28fymKvTMR83wBQSsVmcKiuxvVW8=
Received: by 10.86.49.13 with SMTP id w13mr1679058fgw.65.1213257157788;
        Thu, 12 Jun 2008 00:52:37 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.226.105])
        by mx.google.com with ESMTPS id 12sm2034284fgg.0.2008.06.12.00.52.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Jun 2008 00:52:36 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5C7qVqO029734;
	Thu, 12 Jun 2008 09:52:32 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5C7qPJw029730;
	Thu, 12 Jun 2008 09:52:25 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1213235480-21925-1-git-send-email-flavio@polettix.it>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84734>

"Flavio Poletti (polettix)" <flavio@polettix.it> writes:

> Another minor change is a substitution of a shell sub-call using "$()"
> by means of backticks. In my understanding, plain /bin/sh does not support
> "$()".

But POSIX shell does.  And git does make use of it rather extensively.

Besides, see Documentation/CodingGuidelines:

  For shell scripts specifically (not exhaustive):

   - We prefer $( ... ) for command substitution; unlike ``, it
     properly nests.  It should have been the way Bourne spelled
     it from day one, but unfortunately isn't.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
