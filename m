From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Rollback of git commands
Date: Tue, 27 Nov 2007 23:37:13 -0500
Message-ID: <9e4733910711272037r2ce3ed01y31ec8531f5803efe@mail.gmail.com>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>
	 <7vmyszb39s.fsf@gitster.siamese.dyndns.org>
	 <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
	 <BAYC1-PASMTP02DBA3FB25E09FE45F0BF2AE770@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:33:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKwT-0004cg-3C
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:18:57 +0100
Received: from mail-mx4.uio.no ([129.240.10.45])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxElu-0003UT-5t
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 05:43:38 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx4.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxElk-0001hB-Vh
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 05:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755204AbXK1EhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 23:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755104AbXK1EhQ
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 23:37:16 -0500
Received: from nz-out-0506.google.com ([64.233.162.232]:25354 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754803AbXK1EhO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 23:37:14 -0500
Received: by nz-out-0506.google.com with SMTP id s18so949213nze
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 20:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ue+Qu8Xh94X0SqRh/U+rNNRqk5AGyy25Lp73NN5kFrE=;
        b=SPyApLY8htlDcvagiNnC+mWGFMqhcx4pIUrpkQ26g0NP49p1cpi/bBP/jsEJcIKlQhRoaTtgCEe5aUttUdffVv+pPUhwEZgcNXJpYEAqdZV5OiJWURhxk4aUexwf7CXG/by9M88jHx9jBXF8QTwa0DkafCshsYAHs6GAIJA2LRs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rB8oW/SP2VuUBjRR+EBvOKbtECY+dHjbExI8va5BoHdXl8df6VSiYgvSvNaaBObThScnz6H9+cZ7FHm3N4X7IH9miioBfo9YPxWqIYjzOmLCbZShSvDJXMAIJtPAFYiqmE0GlM6DUkHLCUPZBQBtJSjYEjMiYDviovGFb12OyeY=
Received: by 10.115.32.1 with SMTP id k1mr932979waj.1196224633619;
        Tue, 27 Nov 2007 20:37:13 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Tue, 27 Nov 2007 20:37:13 -0800 (PST)
In-Reply-To: <BAYC1-PASMTP02DBA3FB25E09FE45F0BF2AE770@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 4841345ED008F96FE593F3D0213D3F9A23477D30
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 42 total 723809 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66302>

On 11/27/07, Sean <seanlkml@sympatico.ca> wrote:
> On Tue, November 27, 2007 8:33 pm, Jon Smirl said:
>
> Hi Jon,
>
> > I'm only looking for a command that would rollback the effect of
> > changes to the object store (you don't have to remove the objects).
> > Losing complex staging would be ok since it can be recreated.
> >
> > Let's take my recent problem as an example. I typed 'git rebase
> > linus/master' instead of 'stg rebase linus/master'. Then I typed 'stg
> > repair'. The repair failed and left me in a mess. Both of these are
> > easy to rollback except for the fact that stg has stored a bunch of
> > state in .git/*.
> >
> > After doing the commands I located my last commit before the rebase
> > and edited master back to  it. But my system was still messed up since
> > moving master got me out of sync with the state stg stored in .git/*.
> > The 'stg repair' command had changed the stored state.
>
>  From your description is seems that Git proper was able to handle the
> situation just fine.   It sounds instead like you're describing a problem
> with Stg where it became confused without a way to restore _its_ meta
> data.  There's not much Git itself can do to help in this situation
> unless Stg stores all of its meta-data as standard Git objects, rather
> than just using the .git directory.

Patch management is an important part of the work flow. I would hope
that git implements patch management as a core feature in future
versions. stgit/guilt/quilt are valuable since they blazed the trail
and figured out what commands are useful. As time passes these
features can become more highly integrated into core git.

Of course you've never screwed up a repository using git commands,
right? I've messed up plenty. A good way to mess up a repo is to get
the data in .git/* out of sync with what is in the repo. I'm getting
good enough with git that I can fix most mess up with a few edits, but
it took me two years to get to that point. Rolling back to a check
point is way easier. User error and a command failing are both equally
valid ways to mess up a repo.

-- 
Jon Smirl
jonsmirl@gmail.com
