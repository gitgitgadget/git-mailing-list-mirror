From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Temporary directories getting errantly added into trees
Date: Fri, 23 Nov 2007 00:01:46 +1300
Message-ID: <46a038f90711220301o1cbb16b7g79eea541f8ca5e58@mail.gmail.com>
References: <4744FCD9.7020102@vilain.net>
	 <Pine.LNX.4.64.0711221052280.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <sam@vilain.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:02:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv9p9-0001Ow-PB
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:02:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbXKVLBt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 06:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbXKVLBs
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:01:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:27136 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004AbXKVLBr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 06:01:47 -0500
Received: by ug-out-1314.google.com with SMTP id z38so299804ugc
        for <git@vger.kernel.org>; Thu, 22 Nov 2007 03:01:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zZIajrDsokXSZgTAtDyqzmWLVIJ/yN35tjQoD+N69AY=;
        b=xL28vdPKyzdsGzphFETqw6s8GSX0uz3CTjUktm6muPM099WasmzQr4lnBuZfhw7EHie+2gA1Yqts/MELOHDwvntr/1NgBvAh/tXPmCH8DnMi6TtF1y3hDYUK+war4OoGSYiTGh6QXjt5f0o9ulj2Z8NM/FSRcgGrFoGfUUl7p1U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Iv+n3HvC1rSqx0KCbLKP6H67bE5uhaeZu4V7ms+4aJNU2NUTselyySc4EIkHtAQ5XnRVxznzWx6WNO/Yc/XKNUZPuXy/dk6QGbGKcx0WYSe0mARqrOXDUn9Vn2Pg6qIF3Qy+R+BN2YVR+ArH1lQEbhkUhlkmm7Y/b3xHEIUHzoY=
Received: by 10.67.100.12 with SMTP id c12mr727578ugm.1195729306227;
        Thu, 22 Nov 2007 03:01:46 -0800 (PST)
Received: by 10.66.252.6 with HTTP; Thu, 22 Nov 2007 03:01:46 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711221052280.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65784>

On Nov 22, 2007 11:55 PM, Johannes Schindelin > While we're at it,
could we change the name so that it is .git/rebase, and
> not .dotest or .git/.dotest-merge?

+1 on that

> ... And indeed, I see no reason why a tool should access
> .dotest, except for accessing .dotest/patch, and then it will be very
> obvious where it fails.

when it comes to .dotest/patch, it must be reasonably accessible. When
git-am refuses to apply a patch, and I am resolving things by hand, I
need it pretty handy. I also sometimes edit .dotest/msg-clean.

cheers,


m
