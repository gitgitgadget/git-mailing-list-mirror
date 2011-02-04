From: Thomas Berg <merlin66b@gmail.com>
Subject: Re: [PATCH] git-p4: Corrected typo.
Date: Fri, 4 Feb 2011 09:59:07 +0100
Message-ID: <AANLkTinO02E1GrMjb1J5gQTOhGYf8QsnABU_1ehQonDX@mail.gmail.com>
References: <1290130693-30855-2-git-send-email-vitor.hda@gmail.com>
	<1290648419-6107-1-git-send-email-vitor.hda@gmail.com>
	<AANLkTimQhFzEXr=T9F8TJzTeWwKroTt_BG87RtQCLivv@mail.gmail.com>
	<AANLkTikeB724f_vE6qvu1h1o5JG150mcmaHVBjLkOEWP@mail.gmail.com>
	<AANLkTimLQxiB=dnd6=iB5uEpzOSfqks=FDJ=xORehuw8@mail.gmail.com>
	<AANLkTi=PPN69uuJmUBDHKtmn59DzUbdk=Qu4Ug-kok89@mail.gmail.com>
	<AANLkTi=kmcWn9WWbhA4bMZ5bEo1imacEugT0BcOU9jry@mail.gmail.com>
	<AANLkTinCL6+oTAbh4WpsWHx8cZ8cxZvQxSO9EX_xsHh0@mail.gmail.com>
	<AANLkTinrALdy9w7K50r=k-oMV9V5+7+LKvui_DSmJ6nK@mail.gmail.com>
	<AANLkTinKQRfwaMpGQiDCkh1RerQ_MrakwvNLAqgmbF9A@mail.gmail.com>
	<AANLkTin5yR84x=3Qb3W9bZYhUHwbcrhf60Z1CwHyYHOL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 09:59:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlHVb-0005NI-Fg
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 09:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356Ab1BDI7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 03:59:11 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44407 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751703Ab1BDI7I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 03:59:08 -0500
Received: by qyk12 with SMTP id 12so1770821qyk.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 00:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ioLtJkQ7W63/7kg1pgh4S5WFQz+lCzyNtcqQyNMmk0E=;
        b=vj9+DziYP3kF4h4ozcs3/xAXx9EA6eb9kHPcShdmV9SAN5dENznacWpw16swmzRS8s
         adwsbX2FJPFX11810tgSWQQRaK/P/u2cfzDrc0DthYkhvOXLLIyKftqJLPcrbDaPWe3O
         ZPaEHWLhhmG0SVQ96A9Q/Jip3jD1tCeqZLaVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Qw5NKXdiLXPn19D46UVZMngdGmbW7u4ci9HB7NP2JBenIFNpwbss0zYsW/SeooHJqV
         bCfoaiN7gP8uREJJTZQaYoKVflyXaC/okNRWEYV9yKvnKJ65d/CWTYdPMe2NwcWfz2od
         qqbNx1OzQiR0W7/QRQD/5m3jyLpmr8AsUQLlk=
Received: by 10.229.88.82 with SMTP id z18mr8219617qcl.221.1296809947845; Fri,
 04 Feb 2011 00:59:07 -0800 (PST)
Received: by 10.229.223.131 with HTTP; Fri, 4 Feb 2011 00:59:07 -0800 (PST)
In-Reply-To: <AANLkTin5yR84x=3Qb3W9bZYhUHwbcrhf60Z1CwHyYHOL@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166028>

On Mon, Jan 31, 2011 at 4:54 PM, Vitor Antunes <vitor.hda@gmail.com> wrote:
> Hi Thomas,
>
>> On Mon, Jan 31, 2011 at 12:51 PM, Thomas Berg <merlin66b@gmail.com> wrote:
>>> I also discovered bugs in git-p4: in some cases, if the first submit
>>> to a new branch in Perforce is not identical to the branch it derives
>>> from, the import was not correct.
>
> I forgot to answer this specific topic. I also noticed this bug.
> Basically, git-p4 choses the first commit from the origin branch to
> start the branch from. My idea was to walk through the commit tree in
> the original branch until I find a commit in which the diff is null.
> Unfortunately, I don't know what is the best approach to achieve this
> in git. Do you have any ideas?

The thing is that the diff doesn't have to be null either, if an
"evil" branching has happened  - the submit that creates the new
branch contains a different tree than the source branch. It would
probably work well in most cases though, you could just fall back to
the current behaviour if no zero-diff parent is found. I'm sure it's
easy with some git plumbing commands, but I'm of little help there.

I haven't had time to test your patches yet, hope to get some time soon...

Cheers,
Thomas
