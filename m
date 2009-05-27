From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: msysgit git log slow performance
Date: Wed, 27 May 2009 11:49:59 -0400
Message-ID: <eaa105840905270849l5ca0b501id8f86c9c0b44719f@mail.gmail.com>
References: <4120f6ec0905270843u225d6b3bt701c1817d68b4648@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: guo tang <tangguo77@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 17:50:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9LOO-0000xH-NH
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 17:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757498AbZE0PuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 11:50:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757456AbZE0PuB
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 11:50:01 -0400
Received: from mail-ew0-f176.google.com ([209.85.219.176]:56927 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756389AbZE0PuA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 11:50:00 -0400
Received: by ewy24 with SMTP id 24so4460541ewy.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 08:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=4r3nK0tLdNYXgH4gK/csRp4EBDC283TJWWGhRO/PAFs=;
        b=qTrKz9fszvBjj6X5v3x/2kUmc09cBALfEADYwBrM6DKqusag28TPTCbb1SIlBJJBjI
         JWp2XacoOGoD3QSkugZ6NsaSgDFBGNhgf/WAhFvUyVjUb9Dt2/eleCYrQEy3PZSBhcm7
         GOpnu838CfX6fuNCcNXMisy0xEcJgaxFwDP/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=OgjV4BZOE8i73lB/rLWQHsXZnKKgRyjEfNq/bNHwKYeMXbouJN0eMB5i+rqV6NPfil
         2YhQSwjDqglh+7SE4j6HVNBDvZYGQvyjdpDwdIcEKulpyFG4efPLJPqJVk4QfIbrPbTa
         l9OxGfcSH9dDABf2cw1iQuQNM9//AGtRBWiek=
Received: by 10.210.116.14 with SMTP id o14mr1848792ebc.43.1243439399124; Wed, 
	27 May 2009 08:49:59 -0700 (PDT)
In-Reply-To: <4120f6ec0905270843u225d6b3bt701c1817d68b4648@mail.gmail.com>
X-Google-Sender-Auth: 80eb9ba5fbe3ee2d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120074>

On Wed, May 27, 2009 at 11:43 AM, guo tang wrote:
> Hi, Gentlemen,
>
> Anyone else has performance problem with msysgit "git log" command? In
> one of my XP box,
> git log takes about 5 seconds. I did some Google search, one email
> thread in this mailing list
> says setting "GIT_PAGER=" can solve the problem. I tried it, it really
> works. But some other
> commands like push is still slow. I am using
> http://msysgit.googlecode.com/files/PortableGit-1.6.3-preview20090507.7z
> In another XP box, the same msysgit binary, the same "git log" command
> is very fast without GIT_PAGER change.
> So it might due to some strange XP settings. Anyone has idea?

At a guess, maybe you have a (disconnected) network share somewhere in
your PATH?

Peter Harris
