From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git svn branch tracking + ignore paths
Date: Wed, 28 Oct 2009 01:20:32 -0400
Message-ID: <32541b130910272220p59482397wef0d51b1adf1a5bd@mail.gmail.com>
References: <41F0F1D6-4F99-4828-9259-1B2BDC689747@gmail.com> 
	<32541b130910271616ha861d08xa4b90b822d31f0ea@mail.gmail.com> 
	<AC7B0CB1-1B14-4EAE-A6B6-D0845EACE626@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git list <git@vger.kernel.org>
To: Lachlan Deck <lachlan.deck@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 06:21:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N30xu-0007OD-Tb
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 06:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757368AbZJ1FUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 01:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757347AbZJ1FUs
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 01:20:48 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:62140 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757290AbZJ1FUr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 01:20:47 -0400
Received: by ywh40 with SMTP id 40so369483ywh.33
        for <git@vger.kernel.org>; Tue, 27 Oct 2009 22:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=unEYbC1q9E2l2sUUgqwR2A3HABOk5mpAVbO/BhgFdJY=;
        b=eAjkv7NoMm+Ai0r+ZAo3e4mAdVVY8hpgVgKDD6AI7cNA1UDdImkVL2trfEVeqRG5c/
         8/1IZHkytYVp6Hu8A9Wn0z6q0osxDd8Bqq09Mzob6b4uVFBHu6Z0knz6HMKO4giDhgri
         u/kdXjMDERQUbID8d9meEPvtuFIDuLajWFyOM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Y5ObIVfUCR8CCwSu1HgBbXSFT8YETJzjpHW08wfC/uhJW0dX56it9EKrUhOSw+fh+v
         Xi+te8CYI6rCz3tzSqIS273RFxAkufRkanB9vDhDkanCOQepDKkAxDuP751+pFHjfdY6
         ZiZLnxBmnJ896ywwwFWGO2xrDlF8hqPcQ/UfQ=
Received: by 10.151.92.12 with SMTP id u12mr7537204ybl.32.1256707252115; Tue, 
	27 Oct 2009 22:20:52 -0700 (PDT)
In-Reply-To: <AC7B0CB1-1B14-4EAE-A6B6-D0845EACE626@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131405>

On Tue, Oct 27, 2009 at 11:00 PM, Lachlan Deck <lachlan.deck@gmail.com> wrote:
> :) Sure. Essentially a project that I'm contributing to has both maven poms
> and ant/lib-based configs (with the ant ones as default for eclipse .project
> etc files). I'd like to be able to import the projects with maven into
> Eclipse to work on things but without committing back changes to eclipse
> .project/.classpath/.settings/*.
>
> So I'm hoping for a fairly transparent process.

So which are the files you don't want to import from trunk?  It
doesn't sound like there are any... so it's getting simpler already.

Also, can you just simply not commit any changes to the other files?
That would be the easiest way to deal with committing back.  The other
option (slightly messier) is to change them in a single commit, and
use git rebase to move that commit out of the way when you're about to
push your changes back into svn.

Have fun,

Avery
