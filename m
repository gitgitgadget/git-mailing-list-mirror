From: Sam Vilain <sam@vilain.net>
Subject: Re: [spf:guess] Re: git-svn not fetching all revisions
Date: Fri, 20 Nov 2009 17:12:10 +1300
Message-ID: <4B06171A.10801@vilain.net>
References: <4AF9AC1A.5000100@better.se> <4AFA36F0.6070501@vilain.net> <4B0534FF.5040001@better.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marcus Better <marcus@better.se>
X-From: git-owner@vger.kernel.org Fri Nov 20 05:12:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBKrM-00054v-Vt
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 05:12:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758274AbZKTEMX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 23:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758262AbZKTEMX
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 23:12:23 -0500
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:43278 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756718AbZKTEMW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 23:12:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id D080C3255E;
	Fri, 20 Nov 2009 17:12:11 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9H8ZqHegjrZn; Fri, 20 Nov 2009 17:12:11 +1300 (NZDT)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 4EAED323E7;
	Fri, 20 Nov 2009 17:12:11 +1300 (NZDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <4B0534FF.5040001@better.se>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133304>

Marcus Better wrote:
> Ok, that works, but how can I now sync with the svn repository with git
> svn rebase/dcommit? I think the filter-branch rewriting confuses git-svn.
>

A quick hint: git-svn only relies on the last piece of metadata it can
see in 'git log'; so make sure that one looks right and you should be
fine...

Sam
