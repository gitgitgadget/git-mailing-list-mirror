From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: RFC: Subprojects
Date: Thu, 12 Jan 2006 18:39:10 +1300
Message-ID: <46a038f90601112139l2f2bde5bx15102a1afcf4ec25@mail.gmail.com>
References: <43C52B1F.8020706@hogyros.de> <200601120919.08354.lan@ac-sw.com>
	 <46a038f90601112046u13d7075dsc2108111e2462152@mail.gmail.com>
	 <200601121125.33696.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Simon Richter <Simon.Richter@hogyros.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 12 06:39:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwvB5-0002ZG-9I
	for gcvg-git@gmane.org; Thu, 12 Jan 2006 06:39:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbWALFjM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jan 2006 00:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbWALFjM
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jan 2006 00:39:12 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:425 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964782AbWALFjL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2006 00:39:11 -0500
Received: by wproxy.gmail.com with SMTP id i34so310498wra
        for <git@vger.kernel.org>; Wed, 11 Jan 2006 21:39:10 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nOKV1TfJogNTzUyxBMvAH907C0CP6aTuxXhcLAcqQS6RqzDPTGMTJNx52E1RFx9gDq6W2BiU51v9cmGO69jLq++CtrVhLUi6xyuJ7rXmgLeYZiMMPbrn7s26nPH144sqEam5VaZ+Q1r6rql2rMuH4d73LJwGprA+LmFEoHzCE0k=
Received: by 10.54.112.5 with SMTP id k5mr2015205wrc;
        Wed, 11 Jan 2006 21:39:10 -0800 (PST)
Received: by 10.54.71.5 with HTTP; Wed, 11 Jan 2006 21:39:10 -0800 (PST)
To: Alexander Litvinov <lan@ac-sw.com>
In-Reply-To: <200601121125.33696.lan@ac-sw.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14547>

On 1/12/06, Alexander Litvinov <lan@ac-sw.com> wrote:
> > What is your show stopper?
>
> I would agree to make separate commits for each sub project.
>
> 1. I need to have ability to make tags, branches thru all subprojects.

I suspect that this is a bad idea -- for the same reason as committing
to a subproject is a bad idea. The subprojects most likely have their
own external repositories -- and lifecycles of their own. The same
headname/branchname won't do.

> 2. Update (pull) sould update each subproject, it is hard to update them by
> hands.

A simple shellscript can help you here.

> 3. The need of some sort of checkout script (can be solved by storing this
> script in base project, but it would be much nicer allow git fetch all
> subprojects)

As you say, a bootstrapping shellscript can sort this out.

Sounds quite doable ;-)

(have to warn you though -- git is quite addictive. there's no going back...)

cheers,


martin
