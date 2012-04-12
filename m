From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: prevent push of irrelevant tags
Date: Thu, 12 Apr 2012 22:34:12 +0200
Message-ID: <m2bomwy9iz.fsf@igel.home>
References: <4F873153.9060004@rolf.leggewie.biz>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Rolf Leggewie <foss@rolf.leggewie.biz>
X-From: git-owner@vger.kernel.org Thu Apr 12 22:34:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIQin-0005HN-KR
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 22:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965990Ab2DLUeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 16:34:20 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:46594 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934668Ab2DLUeT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 16:34:19 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3VTDP16Mykz4Kn9f;
	Thu, 12 Apr 2012 22:34:13 +0200 (CEST)
Received: from igel.home (ppp-88-217-109-29.dynamic.mnet-online.de [88.217.109.29])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3VTDP119hcz4KK5x;
	Thu, 12 Apr 2012 22:34:13 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id BFE09CA2A0; Thu, 12 Apr 2012 22:34:12 +0200 (CEST)
X-Yow: I'm not available for comment..
In-Reply-To: <4F873153.9060004@rolf.leggewie.biz> (Rolf Leggewie's message of
	"Fri, 13 Apr 2012 03:47:31 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195364>

Rolf Leggewie <foss@rolf.leggewie.biz> writes:

> I just ran into the situation that "git push --tags" pushed tags to the
> remote repo that point to commits that do not exist there.  How can this
> happen?

A tag is just a ref like any other.

> Git has the information to know that tag X will be useless in repo Y
> because the commit Z it points to does not exist in Y.

It is not useless.  After you pushed the tag the commit Z it points to
exists now in Y as well.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
