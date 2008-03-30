From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Sun, 30 Mar 2008 19:03:27 -0400
Message-ID: <32541b130803301603u65d1b6b6ladac0f6200433e5f@mail.gmail.com>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com>
	 <47EECF1F.60908@vilain.net>
	 <D0F821FA-AF53-4F1F-B9CC-58346828FA15@orakel.ntnu.no>
	 <47EFD253.6020105@vilain.net>
	 <C38585A9-F09C-4A5B-8E72-6F3127DB2BB9@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <sam@vilain.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Eyvind Bernhardsen" <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Mon Mar 31 01:04:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg6ZQ-0002tb-AI
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 01:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbYC3XDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 19:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbYC3XDa
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 19:03:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:22469 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbYC3XD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 19:03:29 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1552667fgb.17
        for <git@vger.kernel.org>; Sun, 30 Mar 2008 16:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=o4MtOI96LjMkHK5C58u4vPVIAMKsDS06UzgA4DJfyrI=;
        b=sO6k1ZIBJLc9IWhKlXE6LTYj0Tdp8yWTL0sBBec0Z2h7YCyUArOYadO1mChWwIK4+oncrI5TQ4uMcEHZB+ZmxjMbEUf+vkooNCoR3btClIvM7qovpBqqaEz4+MzYJWEVfmHcP0sCyeXmpC8F5yYdZxlwo+HPYRFcbKIgPdwr4j4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=s8hDZhvWIh0lHcEsQdCSoFlcIegS1dZjYt8+RG8AVZBZkJIGM7y3EAbcFLd6aIRkC36N+5SHgylWpC5/Sj1HMhOt+jCBSIemMeG7i8IzMW0FhFvn/V/AqAXhpBYXqMSVmJhoF7qIEPNsGXJaG45McFHs4o6CdV14ZJAs1/NX+QE=
Received: by 10.82.135.7 with SMTP id i7mr13684283bud.29.1206918207935;
        Sun, 30 Mar 2008 16:03:27 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Sun, 30 Mar 2008 16:03:27 -0700 (PDT)
In-Reply-To: <C38585A9-F09C-4A5B-8E72-6F3127DB2BB9@orakel.ntnu.no>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78522>

On Sun, Mar 30, 2008 at 3:50 PM, Eyvind Bernhardsen
<eyvind-git@orakel.ntnu.no> wrote:
>  Pushing to a branch works except that I couldn't figure out what to do
>  if the push doesn't succeed, ie, the branch has advanced on the remote
>  end.  That's a problem if more than one module references the
>  submodule or there are multiple branches in the main module.

That's easy: just error out in that case.  If the current system would
just error out when I screwed up, I'd at least be able to deal with
it.  Right now I silently create un-check-outable parent repositories
because I failed silently to upload my latest checkins to the child
repository.

>  True :)  I still have no idea how to figure out which submodules are
>  dirty, though.  Solving that will enable a safe "submodule update",
>  which I think is more important than "submodule push".

What is unsafe about "submodule update"?

Thanks,

Avery
