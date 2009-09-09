From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [BUG] 'add -u' doesn't work from untracked subdir
Date: Thu, 10 Sep 2009 08:46:53 +0900
Message-ID: <20090910084653.6117@nanako3.lavabit.com>
References: <20090902080305.GA11549@neumann>
	<20090902081917.GA5447@coredump.intra.peff.net>
	<20090904070216.GA3996@darc.dnsalias.org>
	<20090905061804.GB29863@coredump.intra.peff.net>
	<7v8wgt98ms.fsf@alter.siamese.dyndns.org>
	<20090905072017.GA5152@coredump.intra.peff.net>
	<7v3a717rgl.fsf@alter.siamese.dyndns.org>
	<20090905080249.GA8801@coredump.intra.peff.net>
	<7vy6ot4x61.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>, Clemens Buchacher <drizzd@aon.at>,
	SZEDER Gbor <szeder@ira.uka.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 01:49:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlWuU-000732-Ag
	for gcvg-git-2@lo.gmane.org; Thu, 10 Sep 2009 01:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754727AbZIIXsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2009 19:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754726AbZIIXsz
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Sep 2009 19:48:55 -0400
Received: from karen.lavabit.com ([72.249.41.33]:53136 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754593AbZIIXsz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2009 19:48:55 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 4A73F11B863;
	Wed,  9 Sep 2009 18:48:58 -0500 (CDT)
Received: from 3364.lavabit.com (212.116.219.112)
	by lavabit.com with ESMTP id 7PCZS3B97S2Z; Wed, 09 Sep 2009 18:48:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=JS5obH9RAekc+WYFE0cDGFEe2QETweWjq5/oeRI/hbjmTOPrUMbMydnb4KcMWnIbrdY/E3XbSo4L504jFBa3PFU5Y0VXP6UVMx06RG7tz//xE4sUfgY2ZxS92tW1AzDnCkC/hWfoWXFldrH16h/jNl1QWAYilnsOIafJUESYlNI=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <7vy6ot4x61.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128091>

Quoting Junio C Hamano <gitster@pobox.com>

> We could probably declare "In 1.X.0 everything will be relative to the
> root and you have to give an explicit '.' if you mean the cwd".
>
> Three questions:
>
>  #1 What are the commands that will be affected, other than "add -u" and
>     "grep"?  Are there others?
>
>  #2 Do all the commands in the answer to #1 currently behave exactly the
>     same when run without any path parameter and when run with a single
>     '.'?

'git-archive' behaves relative to your current directory.

  http://thread.gmane.org/gmane.comp.version-control.git/41300/focus=44125

You can limit it to the current directory with a dot.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
