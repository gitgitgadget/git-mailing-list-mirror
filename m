From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: Status of kha/experimental
Date: Tue, 9 Oct 2007 22:10:12 +0100
Message-ID: <b0943d9e0710091410w1559f1a0yb5055182fd289646@mail.gmail.com>
References: <b0943d9e0710071418o6a664981i9d31db980c04bc50@mail.gmail.com>
	 <20071007213307.GA32210@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Yann Dirson" <ydirson@altern.org>,
	"=?ISO-8859-1?Q?David_K=E5gedal?=" <davidk@lysator.liu.se>,
	"Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 23:11:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfMM0-0004k2-T0
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 23:11:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbXJIVKU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Oct 2007 17:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752243AbXJIVKT
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 17:10:19 -0400
Received: from rv-out-0910.google.com ([209.85.198.186]:56901 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbXJIVKR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Oct 2007 17:10:17 -0400
Received: by rv-out-0910.google.com with SMTP id k20so1175616rvb
        for <git@vger.kernel.org>; Tue, 09 Oct 2007 14:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=QWQvydpLR7GWgXXqa9O0DufwSdEMCc4pWug0SNlDDxk=;
        b=hIx3NjMtV9cE2sVkxqVSj6q6vwFr9xWcoeIHThBnCmAOQ8PwNX/vvdK9PORTEdHdRNIjjH3djnSXiEfaQwR9Q0CetxX1mIm/9zOkmW2Y7UjLR84TwrpiAL3aPlKywrXhOynwrRihKwNOJh82vKUIoBKsnsKYn2zifZ7isEIBSNM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TWmE7iN6DA4KQ4jUNBWAstk94ih8vfmkhT5ST9EATYng2MiPuwHU+zQ21vyDTUFJxsOThJUHxZsjlHhWp5RwNCJJL8XOPLDqR1u48CPkIKx6CY7mTcmXtTwFoZAK2JgrVoHN7XsOK3h7ff7puK/bnV/rrp9o8fz2VbaOyAgBK4I=
Received: by 10.141.34.12 with SMTP id m12mr1909678rvj.1191964217147;
        Tue, 09 Oct 2007 14:10:17 -0700 (PDT)
Received: by 10.140.187.15 with HTTP; Tue, 9 Oct 2007 14:10:12 -0700 (PDT)
In-Reply-To: <20071007213307.GA32210@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60443>

On 07/10/2007, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-10-07 22:18:44 +0100, Catalin Marinas wrote:
>
> > How stable is the kha/experimental branch? Since there are more and
> > more bugs added to the tracking system, I'll have to start looking
> > at them before a 0.14 release. Is it worth merging the
> > kha/experimental now or we better wait for after 0.14?
>
> The idea is that experimental contains changes that need testing, but
> may not yet be ready for your master. (They are generally safe,
> though; I run StGit from my experimental branch at work, for example.=
)
> When I decide that they are ready, I move them to safe. If there are
> any patches you feel should be in safe rather than experimental, just
> ask. Or you could just take them directly from experimental without
> asking, of course. :-)

OK. My plan is to merge kha/safe and have a look at what seems safer
to merge from kha/experimental. Fix bugs (and freeze the current
features). Release 0.14. Merge kha/experimental entirely post 0.14 and
test/stabilize it over couple of months. How does this sound?

--=20
Catalin
