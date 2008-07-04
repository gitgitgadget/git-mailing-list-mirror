From: "Neshama Parhoti" <pneshama@gmail.com>
Subject: Re: no --dry-run to git-pull ?
Date: Fri, 4 Jul 2008 18:26:02 +0300
Message-ID: <912ec82a0807040826v64afcc55i646d9c73b6fa8cd0@mail.gmail.com>
References: <912ec82a0807040656y1c48cba8m6f9981f6bb97b36a@mail.gmail.com>
	 <20080704135944.GA4729@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Jul 04 17:27:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEnBg-0004mh-4O
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 17:27:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbYGDP0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 11:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630AbYGDP0F
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 11:26:05 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:40324 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586AbYGDP0D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 11:26:03 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1587931rvb.1
        for <git@vger.kernel.org>; Fri, 04 Jul 2008 08:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OjEVx3zOyIJwqXM8EQEeXre6hbGQv6YdiBNl8P3wz4U=;
        b=v4qM5PclWwHSLrcQXVisX6yy92cMhKF5uvU4ASotA6SYAgZTu9Cw2KF9izY6j2XqP8
         M/Q8szPbAmSH34tWECQJZqKqxbq8YzAfH9aQaAQ6b4vrqpESq8Ug9ftUwjZVJhciswTO
         rXXiwX92pSLLTu3y5AZLKFnq2D6zuu+4TABtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=pwvzvpLCNa4yG7/o82xfbQcALcT3Qn110JaUiJ5gCYVbuZ5W4LOK/KQu6y/MmUgwNH
         cR/38Z3gX63RXwuFW8VJndFNJYSK4tRpPTSzLNXdG6eg2DsaiOf/MOBklSALzbYdJYgp
         cJGNhmdGbTSYhI/mEKgzsOUjsxNAdxoSCmunQ=
Received: by 10.140.126.14 with SMTP id y14mr431298rvc.96.1215185162643;
        Fri, 04 Jul 2008 08:26:02 -0700 (PDT)
Received: by 10.141.48.20 with HTTP; Fri, 4 Jul 2008 08:26:02 -0700 (PDT)
In-Reply-To: <20080704135944.GA4729@genesis.frugalware.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87397>

On Fri, Jul 4, 2008 at 4:59 PM, Miklos Vajna <vmiklos@frugalware.org> wrote:
> On Fri, Jul 04, 2008 at 04:56:27PM +0300, Neshama Parhoti <pneshama@gmail.com> wrote:
>> Isn't there a way to do a --dry-run with git-pull ?
>
> Not really. But you can do a 'git fetch origin', then a
> 'git log master..origin/master', and it'll tell you what changes will be
> merged if you do a 'git merge origin/master'.
>
> NOTES:
>
> 1) Replace origin and master with your repomte and branch.
>
> 2) If this sounds cryptic for you, then it might be an important info
> that by default a pull is a fetch + a merge.

What puzzles me is the origin keyword. Is it set only if I initially
cloned a repo ?
Because in my case, I have just rsync'ed a repo to another station, so
I fear it will have no meaning in my case.
Thank you
>
