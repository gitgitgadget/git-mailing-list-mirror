From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] git-submodule should obey --quiet for subcommands
Date: Thu, 24 Sep 2009 14:31:30 +0900
Message-ID: <20090924143130.6117@nanako3.lavabit.com>
References: <57518fd10909210946p425d275fy76362a4b2ccc0e05@mail.gmail.com>
	<57518fd10909231433i773aff78kae6b763d0a533279@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Thu Sep 24 07:37:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mqh0k-0000Ep-3j
	for gcvg-git-2@lo.gmane.org; Thu, 24 Sep 2009 07:36:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849AbZIXFfc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2009 01:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751457AbZIXFfb
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Sep 2009 01:35:31 -0400
Received: from karen.lavabit.com ([72.249.41.33]:56266 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750710AbZIXFfb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2009 01:35:31 -0400
Received: from h.earth.lavabit.com (h.earth.lavabit.com [192.168.111.17])
	by karen.lavabit.com (Postfix) with ESMTP id 5A98011B8C9;
	Thu, 24 Sep 2009 00:35:35 -0500 (CDT)
Received: from 4268.lavabit.com (localhost [203.160.1.71])
	by lavabit.com with ESMTP id 0FNT7RYPH3NO; Thu, 24 Sep 2009 00:35:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=R/H8S3sZ29IDbO4+Zx22MGFCtIMRZmI5+7RsHLHcG31JnqZYV/ApFtMgS5fsIY6eJ3Jo5+rylVQXvmjdZfor2z0H1RXIgspiid1PWhKAbgi3951Dbb43SID5RHGxGfctaKf/kIDBzDwQe1KnUYCdne04iQ8c7Jlde3dd/imcJQM=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <57518fd10909231433i773aff78kae6b763d0a533279@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129016>

Quoting Jonathan del Strother <maillist@steelskies.com>

> No takers?  Perhaps I should explain my interest in this patch : we
> use Capistrano to deploy our Rails app which contains a bunch of
> submodules.  It's done over ssh, so the 'git submodule update' step
> during deployment spews something along the lines of :
>
> Receiving objects: 0% (0/401), 1.55 MiB | 424 KiB/s
> Receiving objects: 1% (4/401), 2.15 MiB | 612 KiB/s
> Receiving objects: 2% (8/401), 2.90 MiB | 510 KiB/s
> ....
> ..

Does 'git clone' itself do that to you, too, or do you see these output on separate lines only when running 'git submodule clone'? I never used 'git submodule clone' but with 'git clone' these lines seem to overwrite one after another and they never bothered me. Could your terminal emulator be broken?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
