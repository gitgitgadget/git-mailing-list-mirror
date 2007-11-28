From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Rollback of git commands
Date: Tue, 27 Nov 2007 23:53:55 -0500
Message-ID: <9e4733910711272053t211afd06ocae6731a2844d93f@mail.gmail.com>
References: <9e4733910711271523p3be94010jac9c79e6b95f010d@mail.gmail.com>
	 <7vmyszb39s.fsf@gitster.siamese.dyndns.org>
	 <9e4733910711271733r6f280618pbb14095aebba3309@mail.gmail.com>
	 <BAYC1-PASMTP02DBA3FB25E09FE45F0BF2AE770@CEZ.ICE>
	 <9e4733910711272037r2ce3ed01y31ec8531f5803efe@mail.gmail.com>
	 <BAYC1-PASMTP101A96ADE42981D2708652AE770@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:36:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IxKwO-0004WS-JD
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 12:18:52 +0100
Received: from mail-mx4.uio.no ([129.240.10.45])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxExI-0002Nq-Il
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 05:55:24 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx4.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IxEx9-0001hB-K3
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 05:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754170AbXK1Ex5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 23:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754126AbXK1Ex5
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 23:53:57 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:12278 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753999AbXK1Ex4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 23:53:56 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1582920wah
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 20:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=MU0ldvwPypcOHrnp/8J5C/ERrj//O7FdjVHdt4opeD0=;
        b=uxSShV2vRRICwRBxaqs5PPfGpRfPbQMkytovMtqOECyeWEvq4FV7tXvGiX/MPNeXqMHMZgfOfIk219lqKeLMjPQSWbWYhi5vkcSP+yvRJrxSxKJ0pwhbaat0PaXWKObLc5ambbvsIiJWvgZVl8T/uMqA+jtnFcQVMMwHlCqq36I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AIeiSGV85G8PzgwM2NM5WtpzfyVXRQfNFASmCLM6CArYqFVo/rw+2d8E/IKKYtWQndemYiu+BT2sBsjSkQEm0sh/NEKpWtei8beecI8oWivZ3EGHOpU4iVx73/3aygkFpKDZeE/CF9Xomssve0rzTjLnONgo7WUxry59dhPvcs4=
Received: by 10.114.92.2 with SMTP id p2mr1991876wab.1196225635505;
        Tue, 27 Nov 2007 20:53:55 -0800 (PST)
Received: by 10.114.160.3 with HTTP; Tue, 27 Nov 2007 20:53:55 -0800 (PST)
In-Reply-To: <BAYC1-PASMTP101A96ADE42981D2708652AE770@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-ClamAV-Virus: No
X-UiO-Spam-info: not spam, SpamAssassin (score=-7.0, required=5.0, autolearn=disabled, RCVD_IN_DNSWL_MED=-4,UIO_VGER=-3)
X-UiO-Scanned: 11A40B9EBE3AD98DA9A5588897934B6962AEF2CE
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -69 maxlevel 200 minaction 2 bait 0 mail/h: 63 total 723830 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66306>

On 11/27/07, Sean <seanlkml@sympatico.ca> wrote:
> On Tue, November 27, 2007 11:37 pm, Jon Smirl said:
>
> > Patch management is an important part of the work flow. I would hope
> > that git implements patch management as a core feature in future
> > versions. stgit/guilt/quilt are valuable since they blazed the trail
> > and figured out what commands are useful. As time passes these
> > features can become more highly integrated into core git.
>
> Think this is a separate topic from where we started though.
>
> > Of course you've never screwed up a repository using git commands,
> > right? I've messed up plenty. A good way to mess up a repo is to get
> > the data in .git/* out of sync with what is in the repo. I'm getting
> > good enough with git that I can fix most mess up with a few edits, but
> > it took me two years to get to that point. Rolling back to a check
> > point is way easier. User error and a command failing are both equally
> > valid ways to mess up a repo.
>
> What are you looking for that reflogs don't already handle?

A UI that doesn't need a year of using git before you know what to do with it.
Delta tracking of changes made in .git/* that aren't currently being tracked.
reflogs is a piece of the complete solution.

A higher level of integration for stgit would probably make it more
bullet proof.

>
> Cheers,
> Sean
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
