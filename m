From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Wed, 26 Sep 2007 23:07:56 +0200
Message-ID: <1b46aba20709261407g51fa83e2la96e712ffdd905c2@mail.gmail.com>
References: <7v1wdcch06.fsf@gitster.siamese.dyndns.org>
	 <7v1wd1d0le.fsf@gitster.siamese.dyndns.org>
	 <Pine.LNX.4.64.0709150047030.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Sep 26 23:08:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iae7B-0000D1-Oc
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 23:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbXIZVIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 17:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758460AbXIZVIA
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 17:08:00 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:35434 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbXIZVH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 17:07:59 -0400
Received: by wr-out-0506.google.com with SMTP id 36so941808wra
        for <git@vger.kernel.org>; Wed, 26 Sep 2007 14:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vtNZde/j6AvIcA75aRB3N08DlMh1y09hiX6TzfbAIA0=;
        b=Hx7ci8ZDi/ENRpXZGmLXkr9STnXAotg8WFwkGHhl51atq8o+lK4k90JZhi6nQRZku8CxfUsmijFzonZHcAKBC5O1FyAfB2Y/Jrl5TO+vFF0FTZeGr6/B8FqOVMraG6sfFTJVTFjzcy/EoRMCu5wxqmtBYh690sKcK+d5z098bCk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=StpcExijqz1fA3xs5YJmjI6YgDaD0xpeRNjsrbB8E15TT0UpJLV9TnUaW30ULLx8zMUTEXxF705d0YAfoQhF/QSvhy7bYtdChP3n3SPEkOdoSZcValkA8A+NFSOcVnVpHbYh8h4KywHTngYmyg4xl0uH9QS70VqI/DzsFILgt24=
Received: by 10.114.15.1 with SMTP id 1mr400030wao.1190840876633;
        Wed, 26 Sep 2007 14:07:56 -0700 (PDT)
Received: by 10.143.165.17 with HTTP; Wed, 26 Sep 2007 14:07:56 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709150047030.28586@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59248>

2007/9/15, Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> On Fri, 14 Sep 2007, Junio C Hamano wrote:
>
> > * cr/reset (Fri Sep 14 01:19:30 2007 -0700) 5 commits
> >  + Simplify cache API
> >  + An additional test for "git-reset -- path"
> >  + Make "git reset" a builtin.
> >  + Move make_cache_entry() from merge-recursive.c into read-cache.c
> >  + Add tests for documented features of "git reset".
> >
> > I found "git reset commit paths..." had problem in this series,
> > which was why jc/cachetree is merged into this topic to fix it.
> > Hopefully we can put this in 'master' soon, after giving it
> > another and final round of eyeballing.
>
> I think this is my bug.  The initial reset-with-paths functionality in the
> builtin reset came out of my feather... Sorry!

I'm sorry for not being able to review that code, but now it was
a bit too hard for my current knowledge of the git's internals.
These days I'm very busy here and I cannot continue with that work,
but I will be soon in git to learn more. Please, be free to rework the
code of builtin-reset.c without waiting for me if anyone is interested
in get it done ASAP.

--
Carlos
