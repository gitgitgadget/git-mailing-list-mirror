From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: tree view: hash_base and hash are now context sensitive
Date: Fri, 29 Sep 2006 22:35:27 +0200
Message-ID: <200609292235.27478.jnareb@gmail.com>
References: <20060929161619.24848.qmail@web31806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 22:35:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTP4t-0004GV-41
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 22:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbWI2UfT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 16:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422818AbWI2UfT
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 16:35:19 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:64553 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1422811AbWI2UfR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 16:35:17 -0400
Received: by ug-out-1314.google.com with SMTP id o38so313864ugd
        for <git@vger.kernel.org>; Fri, 29 Sep 2006 13:35:15 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=I1IChQdg+C700m0vKn/6zYor9Jmqgnii9AiibXWAbWVcucFGUTO23DnxwDvjy3LBHRnWs0Owh8Y+BUACFN+z52nOyHwtPNze4lcsSXXXrLYLL8rYD+xkrihAvUkdZhj7PQPMATo2w/CBvT8UVZyeBA28dFYOwYVIptZeooadUko=
Received: by 10.67.117.2 with SMTP id u2mr244581ugm;
        Fri, 29 Sep 2006 13:35:15 -0700 (PDT)
Received: from host-81-190-23-206.torun.mm.pl ( [81.190.23.206])
        by mx.gmail.com with ESMTP id q1sm2425006uge.2006.09.29.13.35.15;
        Fri, 29 Sep 2006 13:35:15 -0700 (PDT)
To: Junio Hamano <junkio@cox.net>, Luben Tuikov <ltuikov@yahoo.com>
User-Agent: KMail/1.9.3
In-Reply-To: <20060929161619.24848.qmail@web31806.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28127>

Luben Tuikov wrote:
> --- Junio C Hamano <junkio@cox.net> wrote:
> > > What are the objections to this patch?
> > 
> > No objections from me --- rather lack of objections from Jakub ;-)
> 
> We haven't heard anything from him, and on our last correspondence
> in this thread it seemed we're in agreement.

As a interim solution it is a good idea, moreover with using $hash_base
defaulting to HEAD instead of using HEAD literaly.

The correct solution would be to make "html" page (i.e. "blob" not 
"blob_plain" view) also for binary files. <img> element for image/*
mimetype, perhaps <embed> or <object>, or just plain link for other
binary (not text/* or some application/*) types

I was AFK for few days.
-- 
Jakub Narebski
Poland
