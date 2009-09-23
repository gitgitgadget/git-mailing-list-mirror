From: "Ciprian Dorin, Craciun" <ciprian.craciun@gmail.com>
Subject: Re: Feature Enhancement Idea.
Date: Wed, 23 Sep 2009 21:17:28 +0300
Message-ID: <8e04b5820909231117k401e7500h822a61cb41db5c0@mail.gmail.com>
References: <5b5e291e0909222317q47ae36d4la470f17ec3902124@mail.gmail.com>
	 <200909231106.03305.johan@herland.net>
	 <5b5e291e0909230412r3ce143abgd990c36e27736bae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Deon George <deon.george@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 23 20:17:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqWPI-000135-BI
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 20:17:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753215AbZIWSR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 14:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbZIWSR0
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 14:17:26 -0400
Received: from mail-ew0-f211.google.com ([209.85.219.211]:62961 "EHLO
	mail-ew0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210AbZIWSR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 14:17:26 -0400
Received: by ewy7 with SMTP id 7so962186ewy.17
        for <git@vger.kernel.org>; Wed, 23 Sep 2009 11:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Gl2vnOe8AVnIz8THG7t+/41hr/qiIKm/ibOGeubqFOs=;
        b=NKNuitx1sKotFwyMXUh7hKvNocYqruSY7gHlf+zpoHwQxmnQ7GWbtSLltg8604k9Ew
         6QD3I1hpkkYFmpbfYudRn/eOlOQrFUozR0IEowIXaEBlUdgTZG9+ntF/WE7jbKGG+ZPq
         TAHTpLCnMo5e0HUbbawh0fejhQWuxaYPDaRS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=oabFPTTvTqqEJYUM0FxADdbYsT7rWiowabJ43WKILSiJlVIyYaO1Gj23Q4v9Xo+Tul
         TliWJMJXsDNPC4aczCwydawlLCXd66NCgGUNkXSy3vr6cyFdpOPMHkDQJpoir6sigCbN
         I4gZZtgHKLfZ96vXCcQSyA6HSguc700Fv0fl8=
Received: by 10.210.9.13 with SMTP id 13mr3001869ebi.7.1253729848877; Wed, 23 
	Sep 2009 11:17:28 -0700 (PDT)
In-Reply-To: <5b5e291e0909230412r3ce143abgd990c36e27736bae@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128987>

On Wed, Sep 23, 2009 at 2:12 PM, Deon George <deon.george@gmail.com> wrote:
> 2009/9/23 Johan Herland <johan@herland.net>:
>> Have a look at git submodules ('git help submodule'), or the git-subtree
>> script that has been discussed on this list a couple of times [1].
>
> git submodule looks like it will do a little of what I want - I'll do
> some more reading on it to see exactly how it works. Thanks for the
> tip.
>
> My initial look at it seems to miss an important feature that my layer
> idea would provide. It looks like git submodule assumes that
> everything in a subdirectory belongs to a repository - with my layer
> idea, I would want any layer to share the same directory structure and
> files (or content) belonging to a distinct layer's repository.
>
> IE:
> the base might provide
> plugins
> plugins/README
> modules
> modules/README
> lib/common.php
>
> and a layer might provide
> plugins/a.php
> modules/a.php
> lib/a.php
>
> another layer might provide
> plugins/b.php
> modules/b.php
> lib/b.php
>
> If I was a C developer, I'd have a go at creating it - but I'm just a
> php developer :)
> ...deon


    Practically you want something like unionfs [1] but for git. Right?

    But probably you could settle for something like Hg Queues [2]. Is
there similar for Git?

    Ciprian Craciun.

    [1] http://en.wikipedia.org/wiki/UnionFS
    [2] http://mercurial.selenic.com/wiki/MqExtension
