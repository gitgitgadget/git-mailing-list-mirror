From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Wed, 10 Jan 2007 10:10:44 +0000
Message-ID: <200701101010.46269.andyparkins@gmail.com>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net> <200701100904.32077.andyparkins@gmail.com> <7vbql7cjk8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 10 11:11:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4aQE-0004U7-UH
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 11:11:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932769AbXAJKK5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 05:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932774AbXAJKK5
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 05:10:57 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:58511 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932769AbXAJKK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 05:10:56 -0500
Received: by ug-out-1314.google.com with SMTP id 44so60581uga
        for <git@vger.kernel.org>; Wed, 10 Jan 2007 02:10:55 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sr38tRHVf/Uyu6C5+krzMXCpzPI9BWTZnnOT2eJIZUjM8Czt9cjjooJmKpWyXEkiT5hp2CFbBcMgyLLuTekNqU02+2l+t2cu7O6iNy50qe9ogcZtnxZURGYMFUqwNRqW2cReWSdid5r6oQyBynRUJweQyZgcrOoFzfRWJNJzX8E=
Received: by 10.66.244.11 with SMTP id r11mr233483ugh.1168423855233;
        Wed, 10 Jan 2007 02:10:55 -0800 (PST)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id j1sm42130890ugf.2007.01.10.02.10.54;
        Wed, 10 Jan 2007 02:10:54 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <7vbql7cjk8.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36496>

On Wednesday 2007 January 10 09:33, Junio C Hamano wrote:

> > If the detached HEAD matches another branch what did we need a detached
> > HEAD for in the first place?
> >
> > Seems that this check will in practice always be true.  A detached HEAD
> > by definition doesn't match some other branch.
>
> You are forgetting this:
>
> 	git checkout v1.0.0

No I'm not.  Linus's suggested check is "git checkout will refuse to switch 
AWAY from a detached head unless the SHA1 of the detached head exactly 
matches some other branch."

My question is what use is that?  In exactly the situation you describe HEAD 
doesn't match a branch.

  git checkout v1.0.0

HEAD after that doesn't match any branch so the next "git checkout" will find 
that HEAD doesn't match any branch and will refuse to switch away.  Why?  A 
checkout in this case isn't dangerous at all.

Of course I could still be misunderstanding.  If Linus meant "refuse to switch 
AWAY from a detached HEAD unless the hash of the detached head exactly 
matches some other ref", I would be less confused.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
