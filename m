From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: builtin-add.c patch
Date: Wed, 10 Dec 2008 23:10:11 +0300
Message-ID: <20081210201011.GA11244@myhost>
References: <200812101238.mBACcWQk023480@axiom-developer.org> <20081210142632.GA4137@myhost> <200812101914.mBAJEAS04718@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: root <daly@axiom-developer.org>
X-From: git-owner@vger.kernel.org Wed Dec 10 21:11:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAVOh-0007fC-85
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 21:11:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752895AbYLJUJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 15:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752817AbYLJUJp
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 15:09:45 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:53464 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752814AbYLJUJo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 15:09:44 -0500
Received: by fg-out-1718.google.com with SMTP id 19so309765fgg.17
        for <git@vger.kernel.org>; Wed, 10 Dec 2008 12:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Il86nuH2p7VmzNaaZdUhD66PEn4EsgJYBAArz+m+c74=;
        b=cBI4i+wS8kDvG3elp0yugP5J41gqhqE6RyRpo88Dy285qxdMrfqWLnijFeMHpum8Ru
         eLgykm3iX0ejP1cOFuDi5WmJ3lOwmeSjqAk/ZxBWh+oxPb1Hp98f9fRQH8rWZC1c2xf7
         j3eo2tMm5HWjJDWLJPG/N4XD7LZXeJpKE5wcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=MPR50WKawUQGIH1rKR3NygHc140Vh0cRAhj+LUZdtBfLfJuDbkOI4y9tDiSB42EJ5l
         GUUtu4ipN78m78ApK06O9dUfQQqnqbW4v7mQyXcWxoDRZDIU/uAerwDtMrlNQqbn/ejx
         GmZDufqUSv+lpQfOPKjydE/abjSgRKDEhUcn4=
Received: by 10.86.95.8 with SMTP id s8mr827882fgb.79.1228939782756;
        Wed, 10 Dec 2008 12:09:42 -0800 (PST)
Received: from smtp.gmail.com ([91.78.206.93])
        by mx.google.com with ESMTPS id e11sm110455fga.32.2008.12.10.12.09.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Dec 2008 12:09:42 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Wed, 10 Dec 2008 23:10:11 +0300
Content-Disposition: inline
In-Reply-To: <200812101914.mBAJEAS04718@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102710>

Hello, Tim!

On 14:14 Wed 10 Dec     , root wrote:
> Alexander,
> 
> I saw a suggestion that git could be used as a filesystem rather
> than as a code repository. I'm looking to convert it for this
> purpose to sit underneath Axiom, a computer algebra system written
> in common lisp. Basically the idea is that a "close" operation does
> a 'git add foo ; git commit'. 
> 
> Are you aware of anyone who has used git as a filesystem?
> 
> Tim Daly
> 

It's a quite off-topic question. But Git is not optimized to track
individual files with separate history
( see http://www.youtube.com/watch?v=8dhZ9BXQgc4 ).
Also, Git uses only 644 and 755 permissions (755 stands for
executables, often scripts - shell scripts, perl, ...), but
usual filesystems provide full range of premissions/ownership.

                                 Alexander
