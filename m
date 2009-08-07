From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH v2] Re: mailinfo: allow individual e-mail files as input
Date: Fri, 7 Aug 2009 04:31:26 +0200
Message-ID: <20090807023126.GH12924@vidovic>
References: <COrzR9ThNBy5SQ7chsXyUB30jVGIijxZQ3LI9L_y7Ab5vWcDcy_HolvjjuHTC7DHI9ntV-eR_v0@cipher.nrlssc.navy.mil> <fmF7fF0TYh9QnFuUzmi-Zw9fKRhYn2-S-kCVb2e-d84D87BPqjfwrwFursOoLGkB99qKJmb_oRs@cipher.nrlssc.navy.mil> <20090807015238.GF12924@vidovic> <20090807015628.GG12924@vidovic> <4Frzb2o8m7o4sjOhlZiN-mXQHUAsXYeImlNxZ8ANJZ5I3_S_JjSsoA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, gitster@pobox.com,
	giuseppe.bilotta@gmail.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Aug 07 04:31:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZFF4-0000i3-91
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 04:31:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756484AbZHGCbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 22:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755639AbZHGCbb
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 22:31:31 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:56742 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbZHGCba (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 22:31:30 -0400
Received: by ewy10 with SMTP id 10so1257685ewy.37
        for <git@vger.kernel.org>; Thu, 06 Aug 2009 19:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=Wklea+T3Y7aCsUaNrs4EGK1BGHc3ZsotChqyaTT8wck=;
        b=tn4z3fCAUK9d0rEo/Xtey24ye3bFFo/krtBsgUa9+mLQq7BFgk9nnGVK/Jkwz5GN2d
         nv3z3K2ZB7X+omb8/B/LDgWBmopcKTy0uSNWeU3NLYMtNsVuU5hMMAFghqObhgy8c55H
         v+SMowdDxXmGU2VRnBXmHz8LeUhJrOq1V0tZA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=p0lFtVRNtFDkxtKKSNo3N/3+8XYXvU0FAnWdsBQoH9BmlniPwYpbOJAGTobm4DqqS7
         0Ho+k7bNWAhhQPhjVlgLohOdX7ZJ3uHE6lf0LFYoG0L5v5MyXvgvnw+AlLTTKwzWLzrr
         d8qM5S/7kwoJsOspBDpB1lRQ/6l3HZtKFIJ4s=
Received: by 10.210.10.11 with SMTP id 11mr709662ebj.37.1249612289795;
        Thu, 06 Aug 2009 19:31:29 -0700 (PDT)
Received: from @ (91-164-149-117.rev.libertysurf.net [91.164.149.117])
        by mx.google.com with ESMTPS id 7sm1466912eyg.45.2009.08.06.19.31.28
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Aug 2009 19:31:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4Frzb2o8m7o4sjOhlZiN-mXQHUAsXYeImlNxZ8ANJZ5I3_S_JjSsoA@cipher.nrlssc.navy.mil>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125164>

The 06/08/09, Brandon Casey wrote:

> Whoops, I missed that "$1" argument to sed.  That means the v2 followup
> patch is unnecessary since the sed is operating on a file argument
> and _not_ stdin.

Yes.

>                   I think it's a little strange like that though...
> 
>    {
>       sed "$1"
>    } < "$1"

I'm not sure why this comment. The former

  sed "$1"

whithout anything else is enough.

-- 
Nicolas Sebrecht
