From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-hg: fix commit messages
Date: Thu, 18 Apr 2013 01:15:15 -0500
Message-ID: <CAMP44s1MRYnJ8cQGk03Y8qg-7yMZcC=umetv=RaEDE+i=g0ZEA@mail.gmail.com>
References: <1366265191-20815-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Simon Ruderich <simon@ruderich.org>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 08:15:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USi88-0002Vg-My
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 08:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240Ab3DRGPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 02:15:18 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:43758 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413Ab3DRGPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 02:15:16 -0400
Received: by mail-lb0-f175.google.com with SMTP id o10so2312191lbi.6
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 23:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=6o1vKWa7avCI96Tg8Vki6gEkSx1odzenskKEa3or7l0=;
        b=vwhzNRvenytXkdr6fBYd8LnkA0nWjOSoa3CZaqYxnSavPiE1gm1C3Ag/jvr7SGkLeE
         mmVVoVxBPTPF4dmOl2I4GcuMfrxpEGF+qVs6tOyGLOXr/5KRwJu079U9Nv7XHx+3nThD
         qyUTEffWvRNkyTmGSyoC2eEA6HeYCkr43GvPK3tCJxRtH3eDp+X/MKLD3lpBXyCU7Jf6
         HUXAzt0vr4ppbVAb2uBeAAE2PsQFyrlGDgsvGjY4a/Enqw89IU4KTtn+v3wFWLYGjN17
         qjZijmvJCP63K43ig7dC9J8hQhpMdBC2BzujXDvoe2vOgap1PDBRXZpOFLTSsAiskqjK
         h4Mw==
X-Received: by 10.152.5.134 with SMTP id s6mr5087573las.24.1366265715104; Wed,
 17 Apr 2013 23:15:15 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Wed, 17 Apr 2013 23:15:15 -0700 (PDT)
In-Reply-To: <1366265191-20815-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221611>

On Thu, Apr 18, 2013 at 1:06 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> git fast-import expects an extra newline after the commit message data,
> but we are adding it only on hg-git compat mode, which is why the
> bidirectionality tests pass.
>
> We should add it unconditionally.

This doesn't depend on any other patches, and I think it might be
worth to put it in 'maint', it's not like a *huge* deal, but it would
be nice if a mercurial repo cloned with v1.8.2.2 and one cloned with
v1.8.3 end up with the same commit ids. It would have been nicer if
v1.8.1 had this already, but hey, it's new, and it's in contrib.

Cheers.

-- 
Felipe Contreras
