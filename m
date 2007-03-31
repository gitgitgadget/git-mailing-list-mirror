From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: git-add has gone lstat() mad
Date: Sat, 31 Mar 2007 11:18:58 +0100
Message-ID: <200703311119.10581.andyparkins@gmail.com>
References: <200703302055.13619.andyparkins@gmail.com> <7vslbmxkcv.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0703302020510.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 31 12:22:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXail-0008KY-DJ
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 12:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbXCaKWE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 06:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbXCaKWE
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 06:22:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:19832 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752842AbXCaKWC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 06:22:02 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1051440uga
        for <git@vger.kernel.org>; Sat, 31 Mar 2007 03:22:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uO6xFHr+xhZUdrRfqap6kD7trbDFcwk9wHai5AbIEwQVvGDBPx6ZivGEtcPSoLUWmJccSJVcsyMAjDssJvjgU47qEdZ0aZwGee3tFwE0qDRTOjgNUZfPxpmSxsqyw8AZii52VoXnNRweDCDDSR4XhAKtOsPIEm93AGpwxt0JwQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=NgchnhG6teoeiCUa5uJo7JjO+lLAiq44jNFQn12+FG1FGeOqk38hhp+4I7sp+MlZtQNXD3//D3FpAeToYLJO9DEPr6JL3RmpBaeTKh4Q+hUfFhGOeIznKF3rWSXrLjqo2uO5ewJBTqxu5SFWSho99DSSXwLwqRZtRTRF1qITGd4=
Received: by 10.67.29.7 with SMTP id g7mr2662048ugj.1175336520646;
        Sat, 31 Mar 2007 03:22:00 -0700 (PDT)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id e34sm4342713ugd.2007.03.31.03.21.59;
        Sat, 31 Mar 2007 03:22:00 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0703302020510.6730@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43542>

On Saturday 2007, March 31, Linus Torvalds wrote:

> on the kernel took 0.110s for me before, and it now takes 0.014s. And
> maybe Andy's case more noticeable. Andy?

Blindingly fast.

Previously, I never completed a git add .bashrc as it was taking so 
long.  Now it's instant.  This is back to true git form - I wasn't 
entirely sure git-add had done anything :-).  git-status confirmed that 
it had worked successfully though.

I've not done any extensive tests for regressions, but I've done

 cd $HOME
 git init
 git add .bashrc
 git add somedirectory/

And they work fine.  So - it's works for me from me, and a big happy 
grin.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
