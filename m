From: knittl <knittl89@googlemail.com>
Subject: Re: Git reset -p on working tree
Date: Tue, 23 Nov 2010 10:20:31 +0100
Message-ID: <AANLkTimP9zr=wQDYeBxtvYCE1mZ1aHXQ_nLOxGFfR9YD@mail.gmail.com>
References: <AANLkTimc=Dt9YSu=J=7C-f1hZ9UODU7VHu6oD8dmFX3N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeenu V <jeenuv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 10:21:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKp3c-0002jI-2W
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 10:21:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555Ab0KWJUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 04:20:53 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:38400 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab0KWJUw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 04:20:52 -0500
Received: by qyk12 with SMTP id 12so1809898qyk.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 01:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=3mFnrc4H6hB6GeZR7VWI3WyLHn2VPRtOWQ+/IZvq58E=;
        b=qL7QswgUKmApskxg7Gcq8U7pmkrBQfSs7RxBYPljGLRlyxsCUCcPAhweeIrCynA8Iq
         shKOfeMfiSP4C3bjoTutaxbl01rFZUYFPIly2LC6BKYiiRcHjJYQd0hWRzsX7RUEnaCB
         i0GlEBYjwrPxslzRA0qAyClyfReGyZF8UmBnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XTN5N7JyFhvPctbDw6sqA8CyQiiKi7OdQYNyr12jvNBCKYBNdY3iMO7Rvz75usMpxq
         YMJIAaQeeAogWyM2HnSfz097IjQ0KlVeqYWqPYTEuwNGP9ysoaDUeznsFq/WeB+luL7X
         bqGy1QINwkcya3B9YnSUnqQE6fvA2ulRYebO0=
Received: by 10.229.215.8 with SMTP id hc8mr6063590qcb.23.1290504051362; Tue,
 23 Nov 2010 01:20:51 -0800 (PST)
Received: by 10.229.36.135 with HTTP; Tue, 23 Nov 2010 01:20:31 -0800 (PST)
In-Reply-To: <AANLkTimc=Dt9YSu=J=7C-f1hZ9UODU7VHu6oD8dmFX3N@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161935>

On Tue, Nov 23, 2010 at 10:11 AM, Jeenu V <jeenuv@gmail.com> wrote:
> Often I find it useful to selectively undo the modifications that I
> did to my working tree. The -p option to 'reset' that selectively
> resets changes back to a given commit. Unfortunately the option
> reports itself to be incompatible with --{hard,soft,mixed} and thus
> can't be applied to working tree.
>
> Right now I do this with vimdiff, by applying 'git diff' in reverse.
> Wish reset supports -p on working tree operations as well because the
> -p framework (of add, and reset) feels good to use.


there's `git checkout -p` to selectively remove changes from your working tree.
(also `git stash -p` to selectively stash changes temporarily)

`git reset -p` will only undo staged changes from your index

-- 
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
