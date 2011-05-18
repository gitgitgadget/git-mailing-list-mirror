From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] add -i: ignore terminal escape sequences
Date: Tue, 17 May 2011 21:37:50 -0700
Message-ID: <BANLkTinSKFVP=VYw4PoLP=-AUbLKeGX+gQ@mail.gmail.com>
References: <05ce7ccdb3f4e07724d430f6ea2a8c9730971c9d.1305645331.git.trast@student.ethz.ch>
 <7vipt8fyxj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: trast@student.ethz.ch, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 18 06:38:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMYWq-0006I2-QY
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 06:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865Ab1EREib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 00:38:31 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52912 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751814Ab1EREib (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 00:38:31 -0400
Received: by qyk7 with SMTP id 7so2487467qyk.19
        for <git@vger.kernel.org>; Tue, 17 May 2011 21:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Aw0zM3A4tO9sKb8ahDoW2azyJBbJI5H4IQrf+tuNBi8=;
        b=J9HQC2ndEAnHeAxARmRnJab08+7lYapv+MuG1BLxmfZrzL3AHmpG2AXx1s0Y2Uh2GO
         ZcseL1+zAtpWFquL5CgsGf36Rq6gAGpaXmmlAPFJcO6ywoyT4JzLhIAHtWSJgY2ugmb+
         aKCtolRJ9eafp3uv2lYljYYQ9lUqvMVOb7P0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=dcaCmd917KBJn7MJTG6OSXdKXhnjLbb1fLhbYkQtxwpKC403whg7Lf8TzjWIQY/OVd
         lZ2Li97LgpGUD39iuKFZ6o/1NCWXl4G6th1L2tcmTncdaymtYpREVYoUvjfvsGxH3TaQ
         xyUSw+NvSdDF2Z5/uRRzp73nn1XHe3bVFf++A=
Received: by 10.229.43.142 with SMTP id w14mr1100945qce.27.1305693510260; Tue,
 17 May 2011 21:38:30 -0700 (PDT)
Received: by 10.229.229.5 with HTTP; Tue, 17 May 2011 21:37:50 -0700 (PDT)
In-Reply-To: <7vipt8fyxj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173843>

Heya,

On Tue, May 17, 2011 at 20:52, Junio C Hamano <gitster@pobox.com> wrote:
> Jokes aside, it may make sense to offer an extra confirmation for "a" and
> possibly "s" in single-key mode. Unlike others, they are destructive when
> the changes you are splitting from the working tree is large-ish.

I don't understand why/how 's' is destructive? Doesn't it just ask you
again for each of the split hunks?

-- 
Cheers,

Sverre Rabbelier
