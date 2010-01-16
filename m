From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Stamp Git commit id into file during build process
Date: Sat, 16 Jan 2010 20:17:07 +0100
Message-ID: <fabb9a1e1001161117t6d572024yc5598be1b32ffcde@mail.gmail.com>
References: <a1138db31001161050i73eade1bif968ca1256dcef2c@mail.gmail.com> 
	<40aa078e1001161114w5a65bebbhaf43317634899925@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Richards <paul.richards@gmail.com>, git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sat Jan 16 20:22:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NWEEG-0006H1-3E
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 20:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756384Ab0APTWc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jan 2010 14:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756330Ab0APTWb
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jan 2010 14:22:31 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:43870 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756194Ab0APTWb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jan 2010 14:22:31 -0500
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Jan 2010 14:22:31 EST
Received: by pzk28 with SMTP id 28so766831pzk.4
        for <git@vger.kernel.org>; Sat, 16 Jan 2010 11:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=o7EOoRt8rGP8wZHfc5mP1Kz1lW4hUuONhIVN6Z00HFo=;
        b=XzrWp9BgEUrBzmrBTdEvwcDUMYgMnCnTpuqt8jMk7dxweK3E0sMNtyN+8PLyUsOQ53
         ezVzok2FcxX8EjCeyo0xrZa8fLvoubVVNKYCQlA7Ahs7Shzea2hMEcQ0oKnCpOCrvohr
         9noHetGkGYQ4s10eJ/Ia5JM5lTLFVeI2hSCr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ONEfqhH6aB2uBrdnWHvJL+AyohGMuio65FFwghaElBLYvoW4+PsaWHOTRmGe9NTKUu
         QpEojyYiGAi7VJQSqzIXldXRreJnHn9NfZLJN6heOXU+zXWJgkA2ig02eDs8VeoAbzLN
         XJ5u47hzK32IcZRUKKl2tRjMzUnAKeeIu5O6c=
Received: by 10.142.8.40 with SMTP id 40mr307046wfh.247.1263669447136; Sat, 16 
	Jan 2010 11:17:27 -0800 (PST)
In-Reply-To: <40aa078e1001161114w5a65bebbhaf43317634899925@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137253>

Heya,

On Sat, Jan 16, 2010 at 20:14, Erik Faye-Lund <kusmabite@googlemail.com> wrote:
> I think you are looking for "git rev-parse HEAD". This outputs the
> hash of HEAD as a single line on stdout. Or even better, you can use
> the "git describe"-tool, which gives a nice and short description of
> the commit relative to the most recent commit.

It would be better to have a look at gitattributes [0] instead.

[0] http://www.kernel.org/pub/software/scm/git/docs/gitattributes.html#_tt_ident_tt

-- 
Cheers,

Sverre Rabbelier
