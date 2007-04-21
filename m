From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Why SHA are 40 bytes? (aka looking for flames)
Date: Sat, 21 Apr 2007 16:08:01 +0100
Message-ID: <200704211608.06171.andyparkins@gmail.com>
References: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 21 17:36:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfHdk-00058q-8O
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 17:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750925AbXDUPgl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 11:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbXDUPgl
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 11:36:41 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:29056 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbXDUPgk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 11:36:40 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1115605uga
        for <git@vger.kernel.org>; Sat, 21 Apr 2007 08:36:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=C3eUc7WiQ1SrEeOFl7gdXZ0LMHu0ykdynPEah0kV7LKfhAimMX1Z0EzCOQbOyaviXJqRmidr42ta6yN10r0ZUyH91oavMrHg9sKy/Hd5KJIdZmbXhY8OxpMnL1koptEyqsbfB2vDL5mdCo9zqxSHGuGDbFDPo6dxx6/C9BLzVl4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=CFnxDoObvhxQ+YoOa6lICtYeK9e5DIitSTNrfBiDNijHMA+XGczJ1FBcpaUBR2XjFw8PF3i1UQOkhMbNEzIqwq2CCzUwX99+Im9QupCqHOS5eG9EdE2fxtO2kkmRE9L+c4S1x2go8+pEc+SLY+4vxD/dtHZCt9ChrFhLCHvhRaU=
Received: by 10.67.119.13 with SMTP id w13mr3710764ugm.1177169799457;
        Sat, 21 Apr 2007 08:36:39 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id o24sm8616125ugd.2007.04.21.08.36.37;
        Sat, 21 Apr 2007 08:36:38 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <e5bfff550704210635r4008c3c6tf5f55f970bf85e44@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45175>

On Saturday 2007, April 21, Marco Costalba wrote:
> Well, why to store always the full length SHA?

Well apart from being easier than working out the optimum size for every 
single object write, one really good reason would be that there is no 
way to predict that an object in the future won't have a conflicting 
SHA - every object /has/ to be stored with its full hash, because you 
are preventing conflicts with everything object now, in the past and 
all possible futures.

Wow - git is like a time machine.


Andy

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
