From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Documentation/fetch-options.txt: order options alphabetically
Date: Thu, 22 Oct 2009 19:21:52 +0900
Message-ID: <20091022192152.6117@nanako3.lavabit.com>
References: <87eiow1pey.fsf@jondo.cante.net>
	<7vpr8g32ht.fsf@alter.siamese.dyndns.org>
	<7vhbts3285.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jari Aalto <jari.aalto@cante.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 12:21:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0unu-0006yV-CE
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 12:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753260AbZJVKVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 06:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbZJVKVt
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 06:21:49 -0400
Received: from karen.lavabit.com ([72.249.41.33]:60667 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753176AbZJVKVr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 06:21:47 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id D547D11B9D0;
	Thu, 22 Oct 2009 05:21:52 -0500 (CDT)
Received: from 5391.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id W100RBQ2G2LD; Thu, 22 Oct 2009 05:21:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=YLHJv5t3c/MEI0v4HOYAXBXfyRlJ+XkjEeJezpy3l1aPmhhztB368PkJT1EpnBIsga2I9F990RudF4wX8YXDt1ZT2cpBFUdovM0NPh2MI3ajWg6F7qmapXErjXDsKcPlotmqE8/UVQaSkm6mXJhDOaE/tQo2lmI/hHQYc60p5hg=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vhbts3285.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131017>

Quoting Junio C Hamano <gitster@pobox.com>

> Ah, in your defense ;-) I think you looked only at git-fetch.txt without
> checking where else this file is included.  Then the patch certainly is
> understandable.  It would probably make git-fetch.{1,html} easier to scan,
> while making things not worse for git-pull.{1,html}

Can't we introduce subsections in the OPTIONS section to 
group them together, like this (sorry, not a patch)?

OPTIONS
-------

Options related to merging  <---- added
~~~~~~~~~~~~~~~~~~~~~~~~~~  <---- added
include::merge-options.txt[]

:git-pull: 1

--rebase::
	Instead of a merge, perform a rebase after fetching.  If
	there is a remote ref for the upstream branch, and this branch
	was rebased since last fetched, the rebase uses that information
	to avoid rebasing non-local changes. To make this the default
	for branch `<name>`, set configuration `branch.<name>.rebase`
	to `true`.
+
[NOTE]
This is a potentially _dangerous_ mode of operation.
It rewrites history, which does not bode well when you
published that history already.  Do *not* use this option
unless you have read linkgit:git-rebase[1] carefully.

--no-rebase::
	Override earlier --rebase.

Options related to fetching  <---- added
~~~~~~~~~~~~~~~~~~~~~~~~~~~  <---- added
include::fetch-options.txt[]

include::pull-fetch-param.txt[]

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
