From: Deon George <deon.george@gmail.com>
Subject: Re: Feature Enhancement Idea.
Date: Wed, 23 Sep 2009 21:12:47 +1000
Message-ID: <5b5e291e0909230412r3ce143abgd990c36e27736bae@mail.gmail.com>
References: <5b5e291e0909222317q47ae36d4la470f17ec3902124@mail.gmail.com>
	 <200909231106.03305.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Sep 23 13:13:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqPmR-0006p0-6I
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 13:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbZIWLMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 07:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbZIWLMo
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 07:12:44 -0400
Received: from mail-px0-f194.google.com ([209.85.216.194]:43954 "EHLO
	mail-px0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbZIWLMn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 07:12:43 -0400
Received: by pxi32 with SMTP id 32so520297pxi.4
        for <git@vger.kernel.org>; Wed, 23 Sep 2009 04:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=YPSIt1DhfHWwsff6BjBZYAwQOrhiPXhybBgEycH9lEE=;
        b=VhaiTw7kM40g12ohL4YwxuLnh2qMSfHvrhCpnsFPB8K/xXFw7C9BqVFFA1BvasG1AZ
         Omsilc4wLCN0ZWxSz53cCha1s1IN81fuebdHySFOWyVwzmAdeVbJm+IfQkV6nWdZHqM0
         MMqSHuUXWK735ZZSYnvEDis0U8ZdnnvfQvh7E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Pv0w3x7gRgC7u+vRMOT0Xrg5ccvRVo+X6vBsVdo98Hs8ihAlUprbYzLME15EP5XrmP
         DPGL2G9kUhRT1p33GsN9+4e5Zlm46zWTLUOHMdvmUhjVEagIoQL50rmBQA91kfl4MEPz
         xSEJQq6RnAaOGMujFdEoVIlJzouMCnksnRXWU=
Received: by 10.140.141.16 with SMTP id o16mr115907rvd.277.1253704367025; Wed, 
	23 Sep 2009 04:12:47 -0700 (PDT)
In-Reply-To: <200909231106.03305.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128979>

2009/9/23 Johan Herland <johan@herland.net>:
> Have a look at git submodules ('git help submodule'), or the git-subtree
> script that has been discussed on this list a couple of times [1].

git submodule looks like it will do a little of what I want - I'll do
some more reading on it to see exactly how it works. Thanks for the
tip.

My initial look at it seems to miss an important feature that my layer
idea would provide. It looks like git submodule assumes that
everything in a subdirectory belongs to a repository - with my layer
idea, I would want any layer to share the same directory structure and
files (or content) belonging to a distinct layer's repository.

IE:
the base might provide
plugins
plugins/README
modules
modules/README
lib/common.php

and a layer might provide
plugins/a.php
modules/a.php
lib/a.php

another layer might provide
plugins/b.php
modules/b.php
lib/b.php

If I was a C developer, I'd have a go at creating it - but I'm just a
php developer :)
...deon
