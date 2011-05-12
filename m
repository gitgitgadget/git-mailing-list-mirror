From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 2/3] revert: allow reverting a root commit
Date: Thu, 12 May 2011 16:53:31 +0200
Message-ID: <BANLkTimMc5LRTWpy1Ka+Gf_Cu5SAN785TQ@mail.gmail.com>
References: <20110512110855.GA5240@sigill.intra.peff.net>
	<20110512110955.GB5292@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 12 16:53:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKXGk-0008Bj-0f
	for gcvg-git-2@lo.gmane.org; Thu, 12 May 2011 16:53:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179Ab1ELOxd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2011 10:53:33 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:43707 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab1ELOxc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2011 10:53:32 -0400
Received: by qyg14 with SMTP id 14so928337qyg.19
        for <git@vger.kernel.org>; Thu, 12 May 2011 07:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=K6M/0K5Yu7qoxIRYxdHr8IzD/gtBeKbDV59fqncbZLQ=;
        b=mE6dHHZ6WF6AbIAKIDLRqo/zx9SY0KNlGgtuhEHQgGB04/ro9s1vDBUpM8+hxg+O1V
         0+9LgqQOvm9ynEjaY9E78bJz5pthoV9nSfknbxHBLUq5FTLQmWw4pZOzze7WsvL26r80
         D3LW7jxDu/gDgk8j64uLGTQetYXILNqFxw+ao=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=vD7flHDPRk/po0dqKiYXjmDpoHL/KZauYjDEsAG6v2wDniMUGLLYNo8IIWEdLr+/vZ
         onX9vZi0NENEPvbDENDtze3soxOHea7ea8lnRj5+yJAnjWBUgtBG42XVrmehzAop0YKX
         vqc1EIPq21nKlgmrhR7z7xtBDAl4MiwStHrVM=
Received: by 10.229.37.82 with SMTP id w18mr230853qcd.223.1305212011808; Thu,
 12 May 2011 07:53:31 -0700 (PDT)
Received: by 10.229.213.134 with HTTP; Thu, 12 May 2011 07:53:31 -0700 (PDT)
In-Reply-To: <20110512110955.GB5292@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173474>

On Thu, May 12, 2011 at 13:09, Jeff King <peff@peff.net> wrote:

> Although it is probably an uncommon operation, there is no
> reason to disallow it, as it works just fine. It is the
> reverse of a cherry-pick of a root commit, which is already
> allowed.
>
> We do have to tweak one check on whether we have a merge
> commit, which assumed we had at least one parent.
>
> Signed-off-by: Jeff King <peff@peff.net>

I've quickly tested this one, too, and it also seems to work nicely.
Great stuff!

-- 
Sebastian Schuberth
