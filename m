From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Fri, 3 Sep 2010 12:04:52 +0100
Message-ID: <AANLkTim4tkrshTOw8-hg8J8Tq6vb2xCzJfN4XrUyE7XD@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<alpine.LFD.2.00.1009021249510.19366@xanadu.home>
	<AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
	<alpine.LFD.2.00.1009021624170.19366@xanadu.home>
	<B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@fluxnic.net>, git <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 03 13:05:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrU4r-0004nQ-10
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 13:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756865Ab0ICLEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 07:04:54 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61198 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756416Ab0ICLEx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 07:04:53 -0400
Received: by gwj17 with SMTP id 17so592363gwj.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 04:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=fTWBmtJeoko7CWaYpwi3CSfxXRu5k7lNFxsdZINEipQ=;
        b=BgMLwQJ+hChY1cUDKOKir6zGXlsm+6Sc3YQcNTGqeZWKB7xTZAvS05vEcurACfXMyI
         TAfIRpTIyyFvfIXOHc9xjfDt7yNHzljtcC4hDv4yN+jcfPmhA8Tqqz58SYVP7n0Se67p
         jJkrYK7W/Am5mSzTLMEP+EdY1UYt2Mra8ESZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nyeLgybMLXFe+BGFIbEHBSZvvhvIKlHu9OcbtcJp36c4Q4tbS8aLgn0qpbFwD27UL4
         3MMei2w+yxdbKKAOSnVBv2vB8IYVmb03Gnhf6tKajAmeYYqdDuHePtrbSz8f57cjWbVB
         mUCQxCP48PQGyCMeN8A5qbmIbkfmb5xfnb2JQ=
Received: by 10.100.251.20 with SMTP id y20mr719259anh.78.1283511892465; Fri,
 03 Sep 2010 04:04:52 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Fri, 3 Sep 2010 04:04:52 -0700 (PDT)
In-Reply-To: <B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155244>

On Fri, Sep 3, 2010 at 11:37 AM, Theodore Tso <tytso@mit.edu> wrote:

> So people who are willing to participate as part of the peer2peer
> network can download the instructions for how to make the
> canonical pack once a month, and use it to create the canonical pack.

 yes.

also it's already becoming clear that people mayy need to run a
"front" copy of the peertopeer git repository, to which they locally
perform "git push", for various reasons including not wishing to
expose "random experimentation commits" out onto the wider internet
until they're actually ready to do so.  i realise that merging can get
round this (flattening many patches into one big commit) but there is
also the issue of having to run a daemon on the peertopeer repo - you
miiight not want to interfere with that.

so, yes, running a "special" git repo is probably a good idea.

 thanks theo.

l.
