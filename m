From: "Christian MICHON" <christian.michon@gmail.com>
Subject: Re: MinGW port - initial work uploaded
Date: Mon, 22 Jan 2007 14:06:48 +0100
Message-ID: <46d6db660701220506t20214d3bi4d0e1e93abd01aad@mail.gmail.com>
References: <200701192148.20206.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 14:07:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8yt1-0004PB-JB
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 14:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbXAVNGv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 08:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbXAVNGv
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 08:06:51 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:55770 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbXAVNGu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 08:06:50 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1046159uga
        for <git@vger.kernel.org>; Mon, 22 Jan 2007 05:06:49 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FztpiUUwU3H7by2MVjRnmJoPjgXSotLSDawyTxpnRWaM+JX4tyTee5i6Z+kzbmxDmpThn88W8Vly5RzwuiCCRv3nsLZ7nUglI40rncwYzRwM8t6UF2rJWFLnLUACMrYiEXRnP3NS3NG3PIiWVZHFvks8of5gPbLJY4QMgPrWErs=
Received: by 10.82.136.4 with SMTP id j4mr4902995bud.1169471208719;
        Mon, 22 Jan 2007 05:06:48 -0800 (PST)
Received: by 10.78.183.8 with HTTP; Mon, 22 Jan 2007 05:06:48 -0800 (PST)
To: "Johannes Sixt" <johannes.sixt@telecom.at>
In-Reply-To: <200701192148.20206.johannes.sixt@telecom.at>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37408>

ok,

I upgraded some msys and mingw components, and took today's
snapshot of mingw.git.

I can now do many local tasks :)

One problem I haven't found a solution for though: the date
of commit is wrong, always back to epoch (1970???).

See attached:

$ git init-db
Initialized empty Git repository in .git/
$ git add .
$ git commit -a -m ok
Created initial commit d52832ca5120626bfcc35360d7fd3914ccb6d11f
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 a
$ git log
commit d52832ca5120626bfcc35360d7fd3914ccb6d11f
Author: Christian MICHON <christian.michon@gmail.com>
Date:   Thu Jan 1 00:00:00 1970 +0000

    ok

--
Christian
