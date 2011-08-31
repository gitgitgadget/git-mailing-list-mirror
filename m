From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git-svn and mergeinfo
Date: Wed, 31 Aug 2011 19:01:41 +0200
Message-ID: <CAGdFq_gG6NGCzsURg7ERZ8XgV1bP5=vwg8dii7itmnakPzt4VA@mail.gmail.com>
References: <20110829132052.0ad7a088@robyn.woti.com> <CAGdFq_h+KjWQUwwLdaqA-0j0p1zQznZkNNEVgfS46_o-Zfr3oQ@mail.gmail.com>
 <20110831125557.56ccffe2@robyn.woti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Bryan Jacobs <bjacobs@woti.com>
X-From: git-owner@vger.kernel.org Wed Aug 31 19:02:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyoBH-0001NU-7M
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 19:02:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152Ab1HaRCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 13:02:22 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:34316 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932117Ab1HaRCV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 13:02:21 -0400
Received: by vxi9 with SMTP id 9so587318vxi.19
        for <git@vger.kernel.org>; Wed, 31 Aug 2011 10:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=9d1O2AkpT/ZRCKY8i6DAQlBUlALGgWzOryNLeqAlcF4=;
        b=dho8z7Xkxpib6i3zCAto1NQW6pNrbSK1btuHexKcKu1D2sfOIjfMHuT/HkyLjPMa0P
         Qob6C07ije0GQjcK9vxwPfTlVJTOGXSjfYR4JeNcgXSczicBCRn0Ce/Tscrp5Z013jFt
         58BM3SLMYw0GBwMe03UE4fQ/2XVHyfmP/o8Iw=
Received: by 10.52.20.148 with SMTP id n20mr622261vde.368.1314810141266; Wed,
 31 Aug 2011 10:02:21 -0700 (PDT)
Received: by 10.52.161.201 with HTTP; Wed, 31 Aug 2011 10:01:41 -0700 (PDT)
In-Reply-To: <20110831125557.56ccffe2@robyn.woti.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180492>

Heya,

On Wed, Aug 31, 2011 at 18:55, Bryan Jacobs <bjacobs@woti.com> wrote:
> Finally, I am uncertain why the git-svn-info lines are
> stored in commit bodies instead of as notes

Hysterical raisins mostly. I think git-notes predates git-svn by
several years :). I suspect that if someone would wade through the
mess that is git-svn.perl and tought it to (optionally) use git-notes
instead of commit messages that would be highly welcome.

-- 
Cheers,

Sverre Rabbelier
