From: David Aguilar <davvid@gmail.com>
Subject: Re: What's cooking in git.git (May 2011, #11; Tue, 24)
Date: Wed, 25 May 2011 20:28:33 -0700
Message-ID: <20110526032831.GA28327@gmail.com>
References: <7vboyr7oxh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 05:28:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPRFY-0000g8-PM
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 05:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755011Ab1EZD2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 23:28:34 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49816 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754835Ab1EZD2d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 23:28:33 -0400
Received: by pvg12 with SMTP id 12so126701pvg.19
        for <git@vger.kernel.org>; Wed, 25 May 2011 20:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=YMw1ia++L+FVXdRRJZDGh1deYlsUn2wLqjHU3geGpXg=;
        b=ilpZfTmiVnmDJBzjyv+m8r/AlrQCBLeo9zf0MXMIiwk6lRCQg7wFAV328o8oZJxMRZ
         3+TzGhn49Yj+GZjpdIezPchvu6ZQjM7JWb3pPLPp6WbkoWEeVwqGRBRiyfKOf5xIM8BD
         bi5pWSdsIE/IM0paey5la8GRSHNFZquqLRRgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=w2+hTXFzIoJvk140FNM7UGAGnvgbYiPZu4+xK/AnntgZekECt3eGGw74k7LHuY+A7N
         R8MLb/aejPPesJPUnY9Hh0UXjltTz/DsyakdgwwGUL2/ugxeVbSxJZt6kcBrkJoHjQJk
         riegf0cH8bXvjpMVGGoDWzM37Mw6vfSuH+A2w=
Received: by 10.68.14.4 with SMTP id l4mr120940pbc.236.1306380513250;
        Wed, 25 May 2011 20:28:33 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id y3sm568929pbg.40.2011.05.25.20.28.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 20:28:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vboyr7oxh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174488>

On Tue, May 24, 2011 at 02:45:46PM -0700, Junio C Hamano wrote:
> [Cooking]
> 
> * da/git-prefix-everywhere (2011-05-23) 3 commits
>  - git-mergetool--lib: Make vimdiff retain the current directory
>  - git: Remove handling for GIT_PREFIX
>  - setup: Provide GIT_PREFIX to built-ins
> 
> Is everybody happy with this?
> Will merge to "next".

I have v2 of these patches that I'm about to send out.
The three changes were from the original series:

When setup_git_directory_gently() return NULL
set GIT_PREFIX to an empty string.

Avoid #!/bin/sh calling printf with \n in the test.

Resolve GIT_PREFIX unconditionally in mergetool--lib.


I'll be sending the updated patches in a few minutes.
-- 
					David
