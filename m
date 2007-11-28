From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Rollback of git commands
Date: Wed, 28 Nov 2007 10:58:14 -0500
Message-ID: <9e4733910711280758x38ca3cdau4e62bfe8776e5c0d@mail.gmail.com>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>
	 <7vmyszb39s.fsf@gitster.siamese.dyndns.org>
	 <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
	 <BAYC1-PASMTP02DBA3FB25E09FE45F0BF2AE770@CEZ.ICE>
	 <9e4733910711272037r2ce3ed01y31ec8531f5803efe@mail.gmail.com>
	 <alpine.LFD.0.99999.0711280951150.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>, "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Nov 28 16:58:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxPJN-0007TH-RQ
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 16:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759084AbXK1P6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 10:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754717AbXK1P6Q
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 10:58:16 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:8865 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759084AbXK1P6P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 10:58:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1252737rvb
        for <git@vger.kernel.org>; Wed, 28 Nov 2007 07:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ZAQiGSTbxEvTGduaxQspq3m/BIfWCreXtRO3nQdTgxI=;
        b=feZTPawqKGX0aEzv2ga1ho7HXnrS8VSUJ8iOf65H3pIFpWXpELpyv2MbKxlAmZywIRHPeDcwLTFD/kkNhLb2u1BoO2alpEO5CXH7lyuBcR2F4iKZfsOLJvMjIogMoG809UvEXkYdV4BXV7bKBlTJWyBnl9mi8ynUluxXvVJSUts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JLyD1OUanUophYrpjy6MXnOhqXu4rzlMJV8hdeah2bDzczRoSA+4jkTwmPzPWoab90RaKM+EM+/hrGk3zpc8WC4XkmX+rhGGoMCPgzt0RRdEpzFknM9PEh+RYYYaxZ6hMmTiSosPV0N+YdJzAsUObabivB3GCi1dlET8o6yya2k=
Received: by 10.140.82.40 with SMTP id f40mr2639993rvb.1196265494825;
        Wed, 28 Nov 2007 07:58:14 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Wed, 28 Nov 2007 07:58:14 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0711280951150.9605@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66364>

On 11/28/07, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 27 Nov 2007, Jon Smirl wrote:
>
> > Of course you've never screwed up a repository using git commands,
> > right? I've messed up plenty. A good way to mess up a repo is to get
> > the data in .git/* out of sync with what is in the repo. I'm getting
> > good enough with git that I can fix most mess up with a few edits, but
> > it took me two years to get to that point. Rolling back to a check
> > point is way easier. User error and a command failing are both equally
> > valid ways to mess up a repo.
>
> The reflog contains all your check points, for every modifications you
> make, even the stupid ones.  You should look at it.

The state contained in the other config files in .git/* is not getting
check pointed. I can use reflog to move my branch heads around. But
doing that does not undo the changes to the state recorded in .git/*.
After the error I encountered  I moved my branch head back, but the
state stgit had stored in .git/* was out of sync with where the branch
had been moved to.


>
>
> Nicolas
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Jon Smirl
jonsmirl@gmail.com
