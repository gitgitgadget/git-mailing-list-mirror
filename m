From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Breaking up repositories
Date: Fri, 1 Jun 2007 08:45:45 +0100
Message-ID: <200706010845.45761.andyparkins@gmail.com>
References: <465EEF96.6050307@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Josh Triplett <josh@freedesktop.org>,
	Jason Sewall <jasonsewall@gmail.com>,
	Jamey Sharp <jamey@minilop.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 01 09:46:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hu1pg-0007sz-SV
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 09:46:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbXFAHpz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 1 Jun 2007 03:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753908AbXFAHpz
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Jun 2007 03:45:55 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:2235 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbXFAHpy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2007 03:45:54 -0400
Received: by wx-out-0506.google.com with SMTP id t15so419148wxc
        for <git@vger.kernel.org>; Fri, 01 Jun 2007 00:45:53 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=W3XzpYVQ8Sy3c0PRjCcjF4ZrovTKPoc1BZ+RxsBXr9P1cr1dqIoyKJAJ9JCqq/r414oZLowHV5Qq30ANeGcKsP9v0rRPyn1olZCLJ/EL2gGID/1ntVqqwRLgWIbtluDzm//qSho9nzkTjL0fHV26EA+0prNhWAwGK1C2+KDBaMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-disposition:content-type:content-transfer-encoding:message-id;
        b=puYxahXqSLgScRIYvyqWBddwRDyjG6kmdKtrxDK6EWkkTNcxq/p0OoXWrIMDbI94jMjcYrE8vcr71gDDDxert5EQfgDcQOYIQJ+viupZgjctSiWETRWZfYBJsgMrgfBKGqVlSZaKvaVcvBogPs1YJfg8zC0gsKBf8kEHajOlnpU=
Received: by 10.82.126.5 with SMTP id y5mr718348buc.1180683951954;
        Fri, 01 Jun 2007 00:45:51 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id b33sm1586303ika.2007.06.01.00.45.49;
        Fri, 01 Jun 2007 00:45:50 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <465EEF96.6050307@freedesktop.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48849>

On Thursday 2007 May 31, Josh Triplett wrote:

> We really need to fix some things in git-split and get it merged into git.

Obviously it's Junio's call, but can I suggest that getting it in the git tree 
(presumably under contrib/) should not be dependent on fixing 
whatever "things" you are worrying about?  Waiting until it's perfect before 
submitting it.  As Voltaire said (I think), "better is the enemy of good".

Speaking from my own personal viewpoint, while I'm not a huge contributor to 
git, I do fix the odd buglet here and there - and here's the rub - I only do 
it to those files that are in the git tree.

While git-split is being maintained separately, I would argue that there are 
less eyes on it.  Get it in, regardless of state, at the very least it will 
mean that git-split's development will be tracked as publicly as git.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
