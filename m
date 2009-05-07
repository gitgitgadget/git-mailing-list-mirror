From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: To make GIT-VERSION-FILE, search for git more widely
Date: Thu, 7 May 2009 10:54:19 +0200
Message-ID: <20090507085419.GB13123@vidovic>
References: <1241684666-18956-1-git-send-email-matthias.andree@gmx.de> <7vws8te2ht.fsf@alter.siamese.dyndns.org> <op.utjw1pa71e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 07 10:54:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1zNH-000287-5a
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 10:54:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754608AbZEGIy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 04:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbZEGIy3
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 04:54:29 -0400
Received: from mail-qy0-f125.google.com ([209.85.221.125]:48997 "EHLO
	mail-qy0-f125.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318AbZEGIy1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 04:54:27 -0400
Received: by qyk31 with SMTP id 31so1130851qyk.33
        for <git@vger.kernel.org>; Thu, 07 May 2009 01:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=5sqiObf82ll6QlE56zi0Urau59V3BPOlh5bvhm07tFQ=;
        b=mOOcEm3zl5lPbDvBNBxiIdrQRtxxQ9OTFvw0LYcuLV/tVA6c8PtE1bTIfEVdls6tG1
         99CQEMkDDE1HbIjpqBcxY76B8LxElzf0bnA+p2kb20Btm8qJIN8u3mUp/W4cyxUu62sz
         ITaESnKs5b6SfNQMww9o010iPwvSH+DWkb5Kg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=T/iPSryb6oo+o6PEbKhJEPwQYFHFp9q17XFe4xmbcgvHg25uSadx7vyQUxFQFf/us8
         wQuolI4PuMey7Z9/DglHMkonic53Rzc84tSiD+J7W47lFAjCTsqBi6SkbU/x6SES4pIx
         NnkEPeaANsLE9/duXaTNh+pzLuMLjUINd6kQc=
Received: by 10.220.76.149 with SMTP id c21mr4877467vck.66.1241686464835;
        Thu, 07 May 2009 01:54:24 -0700 (PDT)
Received: from @ (88-121-119-92.rev.libertysurf.net [88.121.119.92])
        by mx.google.com with ESMTPS id 7sm370981ywo.56.2009.05.07.01.54.22
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 07 May 2009 01:54:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <op.utjw1pa71e62zd@merlin.emma.line.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118448>

The 07/05/09, Matthias Andree wrote:

> Some points:
>
> 1. sudo is the default sysadmin setup on Ubuntu (more so than on openSUSE)
>
> 2. sudo strips the environment by default for security reasons

This is a configuration option that the sysadmin has to set (see
env_keep in man sudoers (5) or http://linux.die.net/man/5/sudoers).

I don't see any good reason to bypass this behaviour since it is what
sysadmins expect.

-- 
Nicolas Sebrecht
