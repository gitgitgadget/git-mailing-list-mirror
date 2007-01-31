From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Wed, 31 Jan 2007 20:27:52 +0100
Message-ID: <8aa486160701311127v686929c8vb9b5771031776ed8@mail.gmail.com>
References: <87odognuhl.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Carl Worth" <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 20:28:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCL7f-00057g-4G
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 20:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030560AbXAaT1z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 14:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030563AbXAaT1z
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 14:27:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:8492 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030560AbXAaT1y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 14:27:54 -0500
Received: by ug-out-1314.google.com with SMTP id 44so263127uga
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 11:27:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W2YK9su+qCwMRMXDpFUPIrsrvswN9n9IvkrLzYuOuDzxxXfU3ekUbI7VLRQ4yhO+NWKq2Xa2XJ9Q1Gq1p+4r1heq1/Q39FaBAHtvt0scmamelhoi6a9Lyhf//R2N1/Y/haP7Ia8v6Qb6GWsl51juRwxV29qbhZi3Cw6ID+OaKDA=
Received: by 10.78.185.7 with SMTP id i7mr245694huf.1170271672241;
        Wed, 31 Jan 2007 11:27:52 -0800 (PST)
Received: by 10.78.68.8 with HTTP; Wed, 31 Jan 2007 11:27:52 -0800 (PST)
In-Reply-To: <87odognuhl.wl%cworth@cworth.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38286>

On 1/30/07, Carl Worth <cworth@cworth.org> wrote:
> So here's a scenario I'm in right now. A user of my software reported a
> bug. I put together some patches to fix the bug and pushed them out as
> a new branch "proposed-fix" that I'd like the user to test.

Actually it is the same "problem" as when you want to work on the
non-HEAD remote branch.

Currently I do (with current git):

git clone git://...
git checkout -b ${branch} origin/${branch}
git config branch.${branch}.merge refs/heads/${branch}

then they could update this with just:

git pull

It would be nice if:

git clone -b ${branch} git://...

would be equivalent of the above three commands.

Santi
