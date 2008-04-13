From: "Matt Graham" <mdg149@gmail.com>
Subject: Re: [PATCH] Add examples section to 'git fetch' manual
Date: Sun, 13 Apr 2008 15:48:35 -0400
Message-ID: <1c5969370804131248rca9765ei338a70cb6ff304f7@mail.gmail.com>
References: <20080413093102.GC12107@mithlond.arda.local>
	 <20080413093424.GA12861@mithlond.arda.local>
	 <7v63uld1nu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Teemu Likonen" <tlikonen@iki.fi>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 13 21:49:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jl8Cj-0008CK-Fa
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 21:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757242AbYDMTsi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Apr 2008 15:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757715AbYDMTsh
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 15:48:37 -0400
Received: from wf-out-1314.google.com ([209.85.200.173]:18449 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757689AbYDMTsf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 15:48:35 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1258916wff.4
        for <git@vger.kernel.org>; Sun, 13 Apr 2008 12:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=y6vrj/71eOV85d9wQDK0PvTL/o5OBmW60s1XjHL+UQM=;
        b=Ro1MlvuL/eq1Wc0N6gCNYwjxEtuObbjZ4J6M9CsnOTuEwXYUb8u2P4aIoNvLfuBmjklyZB/b4nMeVt3EFs/y5Nj5IHxHez6dMChKc1dZfBhCN7F0s70gfCNbPFIzhTtra3JCFeSR07RyG0bgkd3aUxvF5FZNM+H39zKk8PeXU/w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XyB1bO0CBfRoZT3ykDCjgUP5ToVCXvUia7nS3wI7pVfDvvrQdZE0tTzrSS+AKsjPgEcLvQ2sLTUslKlyaANqCd6jod61q3tk6riIeQ39GgBSgv9PQLhpMBNTMMJKZ6jkgnASqt02NFTwFYwmSqOwRE44CY8F1dUVYzQBuA/ZeXw=
Received: by 10.142.98.18 with SMTP id v18mr1555064wfb.61.1208116115343;
        Sun, 13 Apr 2008 12:48:35 -0700 (PDT)
Received: by 10.142.179.14 with HTTP; Sun, 13 Apr 2008 12:48:35 -0700 (PDT)
In-Reply-To: <7v63uld1nu.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79418>

On Sun, Apr 13, 2008 at 2:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Teemu Likonen <tlikonen@iki.fi> writes:
>
>  > +git fetch origin::
>  > +     From the remote named `origin` fetch and store all branches as
>  > +     configured in `remote.origin.fetch`. Usually this means fetching all
>  > +     branches and storing them locally as remote tracking branches
>  > +     `origin/*`. See linkgit:git-remote[1] for more information.
>
>  This is a valid thing to add to the examples section, although I suspect
>  people would already know it when they encouter this page.

As a recent CVS emigrant, I'm finding the refspecs one of the more
confusing areas of git.  I think having good, basic examples might be
more helpful than experienced users expect.  In my case at least, this
is a helpful example.
