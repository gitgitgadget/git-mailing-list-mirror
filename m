From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: How do I get a list of all unmerged files?
Date: Tue, 26 Oct 2010 11:31:33 -0400
Message-ID: <AANLkTi=JipA6P72hY5_FSvohCruf8hqsJc8Rh53FzAzT@mail.gmail.com>
References: <20101026143245.11433.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: George Spelvin <linux@horizon.com>
X-From: git-owner@vger.kernel.org Tue Oct 26 17:32:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAlVW-0007s8-Ul
	for gcvg-git-2@lo.gmane.org; Tue, 26 Oct 2010 17:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759928Ab0JZPcH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Oct 2010 11:32:07 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34186 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab0JZPcF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Oct 2010 11:32:05 -0400
Received: by iwn10 with SMTP id 10so2314240iwn.19
        for <git@vger.kernel.org>; Tue, 26 Oct 2010 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=y6sBJZG28z/YGMw31HA5ULG/mFtXLTH9XwtKed6hwK0=;
        b=I5oFwm6equ8eh8gYmpFdYIq8kl43lJlPQaMo8DTNhR9UJ3qmByuzkjtR8z0tccR5wn
         kvTXuUPxF58nWgtTN3NBUKEBjRZr85+hRtBWzzlY8jQvhfeyMOH6GTFho/kByrAR2ETn
         7HXpPDdZS3SlKXyfC4gce+qf5ELBSKsBvJmvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=l7JAhricP0uq5MLQ1pbgsN7JlsPQJ/eWt817OJgL7fCrOs4GIdoSJ7IyOl9avXjfJ5
         KP0dBp0F71OfoRnYPv9wEopmuFcFQnV6cOcr5B3Ilj3hBUvoJeKrcAoA4ifkieUNbYpl
         gXmGlUZQJ2W2N0N4mDEd6OPt7Szy1MVxGQVSU=
Received: by 10.231.183.10 with SMTP id ce10mr7513973ibb.96.1288107124482;
 Tue, 26 Oct 2010 08:32:04 -0700 (PDT)
Received: by 10.231.150.201 with HTTP; Tue, 26 Oct 2010 08:31:33 -0700 (PDT)
In-Reply-To: <20101026143245.11433.qmail@science.horizon.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159995>

On Tue, Oct 26, 2010 at 10:32 AM, George Spelvin <linux@horizon.com> wr=
ote:
> After a merge with conflicts, mostly resolved by rerere, I want to pa=
ss a list of
> all unmerged files to the editor for manual review.
>
> I can see the list (wrapped in a bunch of inconvenient human-readable=
 cruft)
> in "git status". =C2=A0I can also get a list (again with a bunch of e=
xtraneous
> info) from "git ls-files -u". =C2=A0What I can't figure out is how to=
 get
> "git ls-files -u" with --stage turned *off*.
>
> I'm sure this exists somewhere, but I can't find it. =C2=A0Can someon=
e enlighten
> me?
>
> vim `git command here`

$ git help unmerged
`git unmerged' is aliased to `!git ls-files --unmerged | cut -f2 | uniq=
'

If there's a better way to do it, I don't know what it is.

j.
