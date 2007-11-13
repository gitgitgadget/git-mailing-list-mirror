From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Git and Scmbug integration
Date: Wed, 14 Nov 2007 10:00:49 +1100
Message-ID: <ee77f5c20711131500h6ee067ffv3e488ac7bde1d22c@mail.gmail.com>
References: <1194980792.4106.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, scmbug-users@lists.mkgnu.net
To: "Kristis Makris" <kristis.makris@asu.edu>
X-From: git-owner@vger.kernel.org Wed Nov 14 00:01:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is4kn-0006yp-49
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 00:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755135AbXKMXAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 18:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757334AbXKMXAx
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 18:00:53 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:29566 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754377AbXKMXAw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 18:00:52 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1588155nfb
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 15:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OzdawktuMySaEmhQrz+GjZ3HOyDLCpMN/IFv1ecr5/k=;
        b=lZv+bR5x+tOXJO/LF8scs+faIaadVgKa/j3WyKk8udRMmCe1Fo5lrIAp5RrJhvZuNSUjs22Ve/J1fDU9T2tcWXBvpzJeLbNArxYtqKuKVBqYGdtje0qKLq1KYM49RBizRuicjEI6xl94BDBove/KznVjHpS23ijbts4ZVjERi+A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tr4qiNTtI5SF8h2oqZRWK2XNtW+IxOHa9y31JwooN4CbIJ/Wof+2BpNwMYaqIDuI4TWr5VK1IH95oZ3gufp0WO6eZnMU6aoeg838niIDhpFLJ6PgAzx9zG+iDBS7ED4s8L2KPxmwqFbqKEelPwKUT/+/PAjJQ4RVtfCXgKQ5ziQ=
Received: by 10.142.229.4 with SMTP id b4mr378465wfh.1194994849050;
        Tue, 13 Nov 2007 15:00:49 -0800 (PST)
Received: by 10.142.142.12 with HTTP; Tue, 13 Nov 2007 15:00:49 -0800 (PST)
In-Reply-To: <1194980792.4106.6.camel@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64900>

On Nov 14, 2007 6:06 AM, Kristis Makris <kristis.makris@asu.edu> wrote:
> Hello,
>
> I've been working on adding Git support in Scmbug, a system that
> integrates software configuration management with bug-tracking. I've run
> across what seem to be limitations in the Git hooks mechanism (at least
> in version 1.5.1.3). In particular:
>
>
> (1)
>
> http://bugzilla.mkgnu.net/show_bug.cgi?id=991
>
> There's no hook that will trigger when a tag is applied.

I believe the 'update' hook is run when the tag is pushed.

> (2)
>
> http://bugzilla.mkgnu.net/show_bug.cgi?id=992
>
> Git does not offer metadata describing a change on the commit trigger
>
> The commit trigger seems to be "post-commit" but it supplies no arguments. The
> "update" trigger supplies a lot of information but that's only triggered when
> changes are published to a remote repository.

Isn't this some kind of centralised bug-tracking system anyway? It
would be nice, I see, for the 'commit' hook to take, say, the commit
SHA-1 hash as a parameter.


Dave.
