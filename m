From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Fix compat/regex ANSIfication on MinGW
Date: Thu, 26 Aug 2010 20:34:06 +0000
Message-ID: <AANLkTinkeJa5fR9KR6ce3keGk4YXqEsYtuGQhXDNUd65@mail.gmail.com>
References: <201008191805.o7JI5Aw0002340@localhost.localdomain>
	<1282242601-2630-1-git-send-email-avarab@gmail.com>
	<7vtymq74mp.fsf@alter.siamese.dyndns.org>
	<AANLkTikod-o3GHqyFSu7yKJZMc1pgZUQm+pEb-ErAYDB@mail.gmail.com>
	<7vlj8271mm.fsf@alter.siamese.dyndns.org>
	<7v39uadxx3.fsf_-_@alter.siamese.dyndns.org>
	<loom.20100825T200539-742@post.gmane.org>
	<4C761EA2.2060904@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karsten Blees <blees@dcon.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 26 22:34:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ooj9K-0007BQ-T8
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 22:34:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754021Ab0HZUeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 16:34:08 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:44181 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753879Ab0HZUeH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 16:34:07 -0400
Received: by gyd8 with SMTP id 8so838002gyd.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 13:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Kv+Xx7RhgCqdf7SYIWBvk6+eCRZ7G054YF/P+8HIaLs=;
        b=hNHpfW6Rrzk3LWpmkt2qIf9KJSjz/pkcoQa6MxJdHMAtMVIylmLkmFBjSuQN8uVrLZ
         xWE4MnOXYYTAUSrySOiHq8GhQlNjB/AIUAimjKAqZ2rldX0du73eb3y1M2UnxCeId0uU
         oO1Y+0rxXSXTplPR+mpSzAkZmh4PttzT+U2eU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=EfKg7giSP12N+2tu05JYzIM8Spxz0FNblidog0VrOtIHGpDzUp67zK4jy21nM9oFCQ
         2oFXFJ+QqrjRqOGGXZaxnJ2ERCtuzlIZvnQe4mcMGkTTo4Zh7MVGK18guEnGiodYq8tv
         48AJjfu8zEU3pywSwN1EEPVEJDqjj9V0iSSkA=
Received: by 10.150.68.9 with SMTP id q9mr799029yba.208.1282854846795; Thu, 26
 Aug 2010 13:34:06 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 26 Aug 2010 13:34:06 -0700 (PDT)
In-Reply-To: <4C761EA2.2060904@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154560>

On Thu, Aug 26, 2010 at 07:58, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Here's a fix.

This looks good. But it would be great if we could keep upstream (gawk
& glibc) in the loop here.

When I added the gawk compat regex engine we had 2 diverging lines
from upstream, now we have a lot more. Not having to manually merge
these when we update the engine again sometime in the future would be
preferrable.

I'm not internet connected enough at the moment to track down the
right people to add to the CC list here.
