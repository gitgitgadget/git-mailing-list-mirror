From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: Rename/copy detection - options/display improvement proposition
Date: Thu, 3 Mar 2011 16:54:23 +0100
Message-ID: <AANLkTin0BJFc1a9SHbou1b=aZA+ta50MAFbFZWYTc8ka@mail.gmail.com>
References: <AANLkTimbvWLCxf6HM-f_z30uUE-Nbpf-tcNzd8GbgK2C@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 03 16:54:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvArT-0007oo-VR
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 16:54:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758381Ab1CCPy2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2011 10:54:28 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62732 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758220Ab1CCPyY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Mar 2011 10:54:24 -0500
Received: by vxi39 with SMTP id 39so1107386vxi.19
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 07:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type:content-transfer-encoding;
        bh=uMaOPdCSwCT4bEd8gG6U3MhykgEB87XhzS8yJWUE9gE=;
        b=mChyWuuG2IABC5QcOFdZdRBUbqULi+NyE4/JkyV/P5elkoVJQjfo7Yy7UYFN5lzo6S
         qyDe6F1f0c3RdKbWVxF7dFLxCk40EnAUu2MDi2zEYlGi7U1FpDvmvwNEZ3O3TlfMdLyk
         uNXHazsq7JtQpND42TmR157HZ0HqeMDP1OUS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=uDg9DdSBEHUFWQzOtRBBWiXnmIaUIPfTAgFGsgsp2wYg/l/+H46Amu9vSYmEW2/uDt
         Yn5Ql66PEcWJ7u9dpHoZMr52ubfEBEe630wIuu/9dtPK8Dk3Rnxbc+IfmHZPwa7ZvwcG
         sWfHvwNHCeKNTVxPH+AhTziKeDDx5doC2/A4Q=
Received: by 10.220.182.70 with SMTP id cb6mr359543vcb.69.1299167663998; Thu,
 03 Mar 2011 07:54:23 -0800 (PST)
Received: by 10.220.61.140 with HTTP; Thu, 3 Mar 2011 07:54:23 -0800 (PST)
In-Reply-To: <AANLkTimbvWLCxf6HM-f_z30uUE-Nbpf-tcNzd8GbgK2C@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168399>

On Thu, Mar 3, 2011 at 4:49 PM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> Hi,
>
> I think that:
>
> =A0 1. git-status should accept -M<n> -C<n>, same as git-diff
> =A0 2. git-diff should have an option to omit diff for deleted files
>
>
> 1. git-status incorrectly recognizes some changes as copied, e.g.:
>
> # Changes to be committed:
> # =A0 =A0 =A0 copied: =A0 =A0 SimpleMatcher.h -> BSlashMatcher.h
> # =A0 =A0 =A0 copied: =A0 =A0 SimpleMatcher.h -> StringMatcher.h
> # =A0 =A0 =A0 renamed: =A0SimpleMatcher.h -> TabMatcher.h
>
> (generally SimpleMatcher.h is recognized as being copied into many
> different headers)
>
> git-diff shows similarity index 50-60%.
> git-diff -M80 -C80 correctly stops recognizing this as copies/renames=
=2E
>
> I think git-status also should learn -M and -C, as it works the same
> way as git-diff with defaults.
>
>
> 2. git-diff does not show diff for copied files. But when a files is
> removed, the diff is shown.
>
> I think seeing what was deleted is sometimes useful, but sometimes it
> is not and just clutters the
> diff.

I have committed the changes and git-commit, git-log--stat output also
shows the renames - so I suppose this is a global issue

--=20
Piotrek
