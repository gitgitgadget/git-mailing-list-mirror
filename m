From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH 6/6] t9400, t9401: use "git cvsserver" without dash
Date: Wed, 10 Sep 2008 06:50:30 +0900
Message-ID: <20080910065030.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 09 23:52:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdB8E-0005aK-S5
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 23:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753494AbYIIVvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 17:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753491AbYIIVvI
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 17:51:08 -0400
Received: from karen.lavabit.com ([72.249.41.33]:34119 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753379AbYIIVvH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 17:51:07 -0400
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 365F5C7A6D;
	Tue,  9 Sep 2008 16:50:56 -0500 (CDT)
Received: from 8007.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id PUKVPWG27G1P; Tue, 09 Sep 2008 16:51:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=Ke2DlgYlxkaXZsXroKmokfhgyz1ARuQJ32iKv0Il/yZMewTrdV0YTvDG32r4ZMZtZST2Ht0XasNZmXFJ7dIDcZMGs6/6HV1WW5eKnmkD0HiY3oqW+AoPOIMI8cSchVf56OdPl42hDwmLT2pZQEh64kcmLsKqun7N8gc78F0kDcc=;
  h=From:To:Cc:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Quoting Junio C Hamano <gitster@pobox.com>;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95446>

Quoting Junio C Hamano <gitster@pobox.com>:

> Nanako Shiraishi <nanako3@lavabit.com> writes:
>
>> The environment variable CVS_SERVER is still set to "git-cvsserver",
>> because tests fail with CVS_SERVER='git cvsserver' (or double quotes).
>
> My eyes are getting dry after looking at these s/git-/git / patches, so
> please do not get offended if I leave these in my Inbox unread for a few
> days.

No problem.

> So why don't we do this (not just for test but for documentation as well)?
>
>  * We do not use "git foo" form when refering to the "server side
>    programs".  Make it official;
>
>  * We move "server side programs" in git(7) documentation into its
>    separate subsection; and
>
>  * We always install "server side programs" in $(bindir).
>
> I think git-cvsserver is the last one we missed from the set of server
> side programs (git-cvsserver, git-daemon, git-receive-pack,
> git-upload-archive, git-upload-pack).

Thanks for your comments; it makes sense to me.  I have to leave for work now, so please expect no progress nor response from me until evening.


-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
