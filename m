From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: [PATCH] update-hook: remove all functionality that should be in hooks/post-receive
Date: Sun, 25 Mar 2007 16:04:24 +0200
Message-ID: <38b2ab8a0703250704y54a93b0bpd109de9d6f7d809b@mail.gmail.com>
References: <200703231022.00189.andyparkins@gmail.com>
	 <200703241548.13775.andyparkins@gmail.com>
	 <38b2ab8a0703241115q39dc298clb15357268288b49e@mail.gmail.com>
	 <200703251011.53712.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 16:04:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVTKt-0004Xl-QP
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 16:04:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbXCYOE1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 10:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbXCYOE1
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 10:04:27 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:61184 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbXCYOE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 10:04:26 -0400
Received: by wr-out-0506.google.com with SMTP id 76so1243631wra
        for <git@vger.kernel.org>; Sun, 25 Mar 2007 07:04:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PmuiB6obGJGVyjYgGt32ORiKhbmP1PdWBakuE21TfrjTGqBR9T0bEM3JCmBd0+CIyGD1oBstwWeQ7EuDFDlN2PpTmIzfOGmiWZ4Py4IuB3QI+LdHHAkAAslaD6PVD7zyYPKPlzzCl0l30iINMkXC/PQs7mKTjJvpjxIUxQTRhw8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WmVEYaoyJvQ8xVUk6dU4OAGCl/v+Ys4gN3/L+pcLqK0CFdUY7kJvvgjzDtb1DVM7ENvFwLKSN+nVk9a8c794oTo+YhVB7WTpPqbVStbtjZWqgL23HlnkZ2Qv6578svapp12kI1PbrcA4hQh/JV8LrF8AMMB/Qj5bgeHI5d5DW0U=
Received: by 10.115.89.1 with SMTP id r1mr2162255wal.1174831464978;
        Sun, 25 Mar 2007 07:04:24 -0700 (PDT)
Received: by 10.114.38.12 with HTTP; Sun, 25 Mar 2007 07:04:24 -0700 (PDT)
In-Reply-To: <200703251011.53712.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43056>

On 3/25/07, Andy Parkins <andyparkins@gmail.com> wrote:
> Again; it's not hard to do, and I don't mind adding it, but I don't want
> to set off Junio's bloat detector.  Bear in mind also that in the
> example you ask for every repo user would need write access
> to "/var/www"; because the hook script runs as the user performing the
> push.
>

yes it should be fairly easy. But the point is that trivial feature
should not imply any modifications IMHO or at least the simplest one:
"FILE=<path>".

>From an external point of view, sending the announcement by email is
an extension of generating a message for each update.
-- 
Francis
