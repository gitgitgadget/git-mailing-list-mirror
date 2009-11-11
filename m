From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] gitk: Add ability to define an alternate temporary directory
Date: Wed, 11 Nov 2009 16:59:11 +1300
Message-ID: <4AFA368F.207@vilain.net>
References: <1257904149-44381-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: paulus@samba.org, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 04:59:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N84Md-0004Te-La
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 04:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbZKKD7K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 22:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752050AbZKKD7J
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 22:59:09 -0500
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:34301 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914AbZKKD7I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 22:59:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 9DB3332324;
	Wed, 11 Nov 2009 16:59:12 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F9-FUdZJwbtL; Wed, 11 Nov 2009 16:59:11 +1300 (NZDT)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id DF1B432336;
	Wed, 11 Nov 2009 16:59:11 +1300 (NZDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <1257904149-44381-1-git-send-email-davvid@gmail.com>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132611>

David Aguilar wrote:
> gitk fails to show diffs when browsing a repository for which
> we have read-only access.  This is due to gitk's assumption
> that the current directory is always writable.
>
> This teaches gitk to honor the GITK_TMPDIR environment
> variable.  This allows users to override the default location
> used for writing temporary files.
>   

Is there a good reason not to use the common TMPDIR or TMP environment
variables for this?

Sam
