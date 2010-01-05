From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: edit Author/Date metadata as part of 'git commit' $EDITOR  invocation?
Date: Wed, 06 Jan 2010 07:38:06 +0900
Message-ID: <20100106073806.6117@nanako3.lavabit.com>
References: <xuu2fx6m4vdi.fsf@nowhere.com> <fabb9a1e1001041232h4e5827d1pb5c648b33ecfb5ce@mail.gmail.com> <xuu2zl4tfuij.fsf@nowhere.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Adam Megacz <adam@megacz.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 23:38:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSI2e-0004Ey-0x
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 23:38:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699Ab0AEWiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 17:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754406Ab0AEWiM
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 17:38:12 -0500
Received: from karen.lavabit.com ([72.249.41.33]:50418 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754477Ab0AEWiJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 17:38:09 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 3B7A915F50E;
	Tue,  5 Jan 2010 16:38:09 -0600 (CST)
Received: from 6529.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id ODV4P3RRB5HD; Tue, 05 Jan 2010 16:38:09 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=pm7fVI69J77jKLLyKznKxVpZm18Lokb4PkDc8ZB1KWrKekvL95FubUWTGBPXS1mnhq37gjcq0OWKGK257JgdWhV9eSNKhWgfrR1R6ZWFFhpp2MTqmZ8BGTZdxu7pjrlvURzXRVrf+npZNmy37Fn8bwXYYqFgot09skJB6KGcSQI=;
  h=From:To:Cc:Subject:X-Draft-From:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-Id;
X-Draft-From: ("nntp+news.gmane.org:gmane.comp.version-control.git" 136143)
In-Reply-To: <xuu2zl4tfuij.fsf@nowhere.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136213>

Quoting Adam Megacz <adam@megacz.com>

> Perhaps a preference (off by default) demanding that they be set
> explicitly when "git commit -m" is used?

Sverre pointed out why this won't work.

> Some people care more than others about the metadata; this is for the
> folks to whom it matters a lot.

So the only workable solution is to check your commits with "git show -s" until you become confident that you configured your new box correctly. Some people unfortunately don't care enough to do so, but it is for the people to whom it matters.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
