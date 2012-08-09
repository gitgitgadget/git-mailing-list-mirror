From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2 resend] gitk: Use an external icon file on Windows
Date: Thu, 9 Aug 2012 08:54:29 +0200
Message-ID: <CAHGBnuOKsPJoRADfukCJ8abSVVKUy5vbuh18S7UD8rLScVq=GQ@mail.gmail.com>
References: <500CEF06.2030501@gmail.com>
	<5022CDFC.4090900@gmail.com>
	<7v628trsry.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 08:54:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzMdf-0006vH-UV
	for gcvg-git-2@plane.gmane.org; Thu, 09 Aug 2012 08:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753293Ab2HIGyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 02:54:31 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:58447 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470Ab2HIGya (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 02:54:30 -0400
Received: by ggdk6 with SMTP id k6so98435ggd.19
        for <git@vger.kernel.org>; Wed, 08 Aug 2012 23:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WwwyRaeoVWDhfZqEsi0lGCQJUcVNd9VDjdiddTeaEfY=;
        b=fWcB1qOUakwLjcwtMZ05v3d1A6DMIJWsc71FOK45UMZTHibtV7rNWTQz+F7rZCQpSI
         0ApNHt4cNF7XPM/Syq8Io1uQ0UP2wR+6X01rXXah8pJVad/blftH0zt70kWeyk892Psb
         Qyn/LEEkj99+YIhSLbDFRTpBklVhKmzTc60ODu1ZBk4ibVqRjuutMZivr+KyMTPiV3J2
         iyiiGysiSV+PF4FKXV3KYrxXdFRg87pToVtamu6iW2lr/qinVMXXeji7sJBJLFsOU2Dk
         TG+Ie+QAmfXpypvG99pSd2aI4cbepjN1zraozX9qml2q7QJ8pgzNMcWGE9SaSU4HRcAA
         ZoIw==
Received: by 10.50.182.232 with SMTP id eh8mr17387igc.48.1344495269527; Wed,
 08 Aug 2012 23:54:29 -0700 (PDT)
Received: by 10.64.137.97 with HTTP; Wed, 8 Aug 2012 23:54:29 -0700 (PDT)
In-Reply-To: <7v628trsry.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203151>

On Wed, Aug 8, 2012 at 11:13 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Forwarding a misdirected patch to the maintainer who is free to pick
> or ignore.

How am I supposed to know if a patch has been ignored as an oversight
(in which case I would resend), or because the maintainer decided not
to include it (in which case I would not resend in order to not annoy
the maintainer)?

> Personally I am negative on it (nobody on the list asked for the
> "new" Git icon as far as I recall), but my voice on this counts just
> as little as others.

I guess most patches on the list come in unasked, so I cannot follow
your negative attitude because of this. Also, the patch does not
enforce the new icon on any platform. From a user's perspective, [1]
as mentioned on [2] is the official Git homepage, thus the icon used
on the homepage can be regarded as the official Git icon. In Git for
Windows, we try to have a consistent user experience, and we had a
report about gitk still using the "old" icon [3]. This patch fixes
that, and I'm sending it upstream in an effort to not let msysgit's
fork of git diverge too much from upstream.

[1] http://git-scm.com/
[2] http://en.wikipedia.org/wiki/Git_%28software%29#External_links
[3] https://github.com/msysgit/msysgit/issues/44

-- 
Sebastian Schuberth
