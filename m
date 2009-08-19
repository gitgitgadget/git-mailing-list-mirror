From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH][resend 3] git-svn: Use GIT_SSH setting if SVN_SSH is
	not set
Date: Tue, 18 Aug 2009 20:58:27 -0700
Message-ID: <20090819035827.GA1454@dcvr.yhbt.net>
References: <4A8B3F40.10803@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Karthik R <karthikr@fastmail.fm>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 06:02:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdcNK-0007ZK-LO
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 06:02:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbZHSD63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 23:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbZHSD63
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 23:58:29 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42972 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932AbZHSD62 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 23:58:28 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 38B771F4E5;
	Wed, 19 Aug 2009 03:58:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <4A8B3F40.10803@fastmail.fm>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126502>

Karthik R <karthikr@fastmail.fm> wrote:
> If SVN_SSH is defined, it will be used. Else value in
> GIT_SSH is copied to SVN_SSH & then, only on Windows,
> the \s are escaped.
> 
> On Windows, the shell-variables must be set as follows
>     GIT_SSH="C:\Program Files\PuTTY\plink.exe"
>     SVN_SSH="C:\\Program Files\\PuTTY\\plink.exe"
> 
> See http://code.google.com/p/msysgit/issues/detail?id=305
> 
> Signed-off-by: Karthik Rajagopalan <karthikr@fastmail.fm>

Thanks Karthik,

Acked and pushed out along with a few others I hadn't pushed
to git://yhbt.net/git-svn

Eric Wong (1):
      svn: assume URLs from the command-line are URI-encoded

Karthik R (1):
      git-svn: Use GIT_SSH setting if SVN_SSH is not set

Tuomas Suutari (1):
      git-svn.txt: Fix location of parent argument

-- 
Eric Wong
