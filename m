From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: ignoring files/directories in git
Date: Sun, 21 Sep 2008 21:42:55 +0400
Message-ID: <20080921174255.GF21650@dpotapov.dyndns.org>
References: <19596152.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mwolfe38 <mwolfe38@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 19:44:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhSyj-0004Za-Ko
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 19:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbYIURnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 13:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbYIURnD
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 13:43:03 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:34826 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbYIURnB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 13:43:01 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1018396muf.1
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 10:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=pxkFPaeiDMIRV3BluJiOWkhcXPDGbzcdLoG/iU7Bgho=;
        b=t27L6KSK0iuqpBhpflI7gNeBR/O7cIRyVJHvUzRi36ruBJ+eRTvo7mtMb/0wRjXicZ
         mc56roePXbhVH053dC5iS0X8wfhmyQf6dUc6OmykyiLabX2yCZSE/LThstjn5MprMzG3
         9zD9wUJCYKIIuqj0zLK0IFj5olqropLizBGsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=SXTQDptXmJUHrEOfzeXm6VjqksQwgFE+/TgguzzWzoaOW1aovkdsrtCNhYKLuUYW3G
         XKODUPy1Xcm4OezPphqtgx2VMm8GSgab7tB+QuLSQwJG0gNukvDHSPXVOJ7B00nDNqNn
         b1pdhyffmMD90xAZEORKGsLxv5ILvR2P/SX1g=
Received: by 10.103.221.13 with SMTP id y13mr2010604muq.41.1222018979841;
        Sun, 21 Sep 2008 10:42:59 -0700 (PDT)
Received: from localhost ( [85.140.171.157])
        by mx.google.com with ESMTPS id g1sm20185024muf.8.2008.09.21.10.42.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Sep 2008 10:42:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <19596152.post@talk.nabble.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96417>

On Sun, Sep 21, 2008 at 09:54:38AM -0700, mwolfe38 wrote:
> 
> I've added them to the .gitignore file which I have in the initial directory
> of the repository
> The contents of my gitignore are:
> 
> .settings
> .cache
> cache/
> log/
> .project
> 
> However, if I do 
> git add .
> It will add the files from cache and log anyways.
> I know git add . will add anything that hasn't been added but shouldn't it
> ignore files in .gitignore?

It does ignore files in .gitignore. What version of Git do you use?
IIRC, some old ones did not like the slash at the end of name.

Dmitry
