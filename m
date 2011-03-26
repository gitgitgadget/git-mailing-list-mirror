From: Scott Chacon <schacon@gmail.com>
Subject: Re: Listing top tracked files and directories only
Date: Sat, 26 Mar 2011 09:24:45 -0700
Message-ID: <AANLkTi=0oWTtUbLFjQsh5-Koghz3UwmaPcrFiR2W-hdS@mail.gmail.com>
References: <AANLkTi=OMXTJm=mvr70KudS+S9c857z7Kv1qVE1FFdD_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 17:24:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3WIG-0008RI-2O
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 17:24:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808Ab1CZQYr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Mar 2011 12:24:47 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55490 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676Ab1CZQYq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Mar 2011 12:24:46 -0400
Received: by ewy4 with SMTP id 4so790748ewy.19
        for <git@vger.kernel.org>; Sat, 26 Mar 2011 09:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QCuMxdXsB1u3FU3VqHxcq9ZajQF5Varkixv+FvdFhlQ=;
        b=dijfgDwrUMaT7uw6z0YZto+n3HSvAd5RnrfDPbyqFLqKY9UO7hKwe6jvllBnjDGTKB
         rAEwk63YIL/pdSUlYAAyJJxSnPzbrtUR+fD9dGkuVFyP9jP+2P5uQ+Vwonk4/M4Y8e+x
         hYRfkVkrj9NVZ700PnWtH3uhHwsPRUg/rmLR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UgmXZ3WeGkTMAHtHtqAskT3nAChdyV5gegAsdMhoadMH7zLT//BiG3tpi6B4qjTMai
         elrgQ8qrRWMfPRa4p78+Inns239HWJYngMqXq4JCrcYDDpcCtVp73wK3mOqeiIFd2a1s
         cL80NUQ7HutK+OqLzjdKavC2BvmiQ7wWD97b8=
Received: by 10.14.126.211 with SMTP id b59mr943091eei.246.1301156685173; Sat,
 26 Mar 2011 09:24:45 -0700 (PDT)
Received: by 10.14.37.78 with HTTP; Sat, 26 Mar 2011 09:24:45 -0700 (PDT)
In-Reply-To: <AANLkTi=OMXTJm=mvr70KudS+S9c857z7Kv1qVE1FFdD_@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170057>

Hey,

On Sat, Mar 26, 2011 at 9:18 AM, Francis Moreau <francis.moro@gmail.com=
> wrote:
> Hello,
>
> I'd like to find a way to list files and directories tracked by git
> but which are only in the top directory of the tracked project.
>
> For example, in a kernel repository:
>
> =C2=A0$ git-magic-command --magic-options
> =C2=A0.gitignore
> =C2=A0.mailmap
> =C2=A0 COPYING

$ git ls-tree --name-only [branch]

Scott
