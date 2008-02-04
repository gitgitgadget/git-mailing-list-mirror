From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH] Fast forward strategies only, common, fork and path
Date: Sun, 3 Feb 2008 23:13:50 -0800
Message-ID: <402c10cd0802032313la7d3a8cqa4ec34e100385fb4@mail.gmail.com>
References: <402c10cd0802031654r3e0275a8s1d2163af9525e7d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 08:14:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLvXG-0004Sm-Ew
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 08:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752852AbYBDHNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 02:13:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752827AbYBDHNx
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 02:13:53 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:31067 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751178AbYBDHNw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 02:13:52 -0500
Received: by fg-out-1718.google.com with SMTP id e21so1911889fga.17
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 23:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=b1rlYw6uaytDIbYGNwlmI4D+uwaPvCzPV8eW6b077XQ=;
        b=nwj/y3z5EFrDKHB2iuZARtXKPQbTP2vruuLVTfkdTPiivj+0I13nNwnzgW6/VXf3wTYgEC0BQ8Xk7M2z7rvc7O1/jNHHGXrP2tGq4X0qTDOkft0Ry9Bg/RCFZl38zqyE7UhqUgfcaT+rjtq1LjFTsmtu4LxxWxroDVsNPSAwkE0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AO6QzOEbsRYypZbG5vALhIuxSFJHgxoKd9wpGnIt4SMaTll88WTeWnSu61I1ET0b5vZ8kfY+j+PO5E6CXq3vmxj/qy0LjZORtmw7+YnobBvplex7ZxfnOqLQyCNYxuKVfDWGOwEJKFEuSNDwUwxUMWOOrTwVp/XYMo44uhmsPnY=
Received: by 10.82.145.7 with SMTP id s7mr12489200bud.7.1202109230604;
        Sun, 03 Feb 2008 23:13:50 -0800 (PST)
Received: by 10.82.156.13 with HTTP; Sun, 3 Feb 2008 23:13:50 -0800 (PST)
In-Reply-To: <402c10cd0802031654r3e0275a8s1d2163af9525e7d2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72467>

git-pull only accepts one repository.  With this patch it makes sense
to accept more than one repository.  I would like to rewrite git-pull
to accept more than one repository.  This might break compatibility
with existing git-pull.  One solution could be to introduce a new
command that does the same as git-pull and more.  What about naming
such a command git-update and deprecate git-pull.

I believe such an command should not specify the repository and the
refspec but should instead specify the remote tracking branch or a
local branch if descired.  I believe this would be more natural to use
and just as easier to implement.

-- 
Sverre Hvammen Johansen
