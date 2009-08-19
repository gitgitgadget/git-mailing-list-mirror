From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: question concerning branches
Date: Wed, 19 Aug 2009 22:57:21 +0200
Message-ID: <200908192257.23347.jnareb@gmail.com>
References: <m33a7noc3u.fsf@localhost.localdomain> <4a8c51f5@wupperonline.de> <20090819203917.GH27206@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ingo Brueckl <ib@wupperonline.de>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Aug 19 22:57:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdsE0-0002LM-EW
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 22:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbZHSU5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 16:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbZHSU5a
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 16:57:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:40377 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbZHSU5a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 16:57:30 -0400
Received: by fg-out-1718.google.com with SMTP id e12so866411fga.17
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 13:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=7he0tg5ljLI7ci2y2p7Pq7K8grDTkGrZDqoKYVgIe8Y=;
        b=tH+rWKJaBCFhL9Atz2WNdlvCmZI+LOF74Rr3j2DbbrdBcI0pdGsZ17tjrSCKA9vW6o
         ViFpqjg7qHwiPkTIbqPyDiWrSCOr38IeaaQUs+5/v7lfyEZ1BrNlnwSkHwFuf2D+ESE8
         +WALcacQ8jyOuBT/rsjndC/I5EZejIdF1qfwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=v9YhSXtdPdSJy412JDznJ69g6f0hBW4NqpulslhFbjD0qG7ywEuBwo0FiLshGBqfHw
         /mrPsPUgEBtKNSXRLeT9HJUE0e/We9ktzB20L55HCa9KvCmsq4/HyZldg23sszF3w8rV
         xPWZ7+ODmJISmlPhFpg9ktWgG5GvGU9iXwRF8=
Received: by 10.86.232.5 with SMTP id e5mr4490149fgh.27.1250715450707;
        Wed, 19 Aug 2009 13:57:30 -0700 (PDT)
Received: from ?192.168.1.13? (abvn197.neoplus.adsl.tpnet.pl [83.8.211.197])
        by mx.google.com with ESMTPS id e20sm9164827fga.2.2009.08.19.13.57.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 13:57:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090819203917.GH27206@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126582>

Theodore Tso wrote:

> Personally, in the cases where I can't finish a commit before I need
> to switch away to another branch, my preference is to not use "git
> stash", but instead to create a topic branch, and then check in a
> partially completed change on the topic branch, which I can later
> ammend using "git commit --amend" (or if I have multiple commits on
> the topic branch, "git rebase --interactive").  This is because I can
> use the commit description to leave myself some notes about what still
> needs to be done before the commit can be finalized.

Errr... you are aware that you can use "git stash save <message>" (i.e. 
specify commit message for stash; well, the subject), don't you?

-- 
Jakub Narebski
Poland
