From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: gitweb, missing project list
Date: Tue, 2 Sep 2008 21:14:27 -0400
Message-ID: <9e4733910809021814t6d869ae8hc60d649e7889369e@mail.gmail.com>
References: <9e4733910809021729g2ccb062oc8818a69c20f857e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 03:20:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kah2x-0003yS-MV
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 03:20:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754158AbYICBOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 21:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754106AbYICBOa
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 21:14:30 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:47109 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbYICBO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 21:14:29 -0400
Received: by py-out-1112.google.com with SMTP id p76so1406150pyb.10
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 18:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=U6WFagjeNAdNJ8Ar6GYT4LKixUGAK+XdgqLsd4uzmnM=;
        b=t+9tprb2fTCdLobA8PH0+IFD0OrriUSOytu4Zei8AIjlcnxtGlnUGo2S+bOtGCrq0+
         x+6Ft8ktXlrqJKWI4rk48eQSR6BLUfIhC6J3aSi4PHmofd8Nez7hBjR24BOZbG+xJnLT
         9Jn+HWt4t36jb7SkLBq+COtd3Jz0UPW9k6+LI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Zr5/+OnCjQ3ygAPmK35BXzDeOKGQO/t3pOFR0BHdKycwUgsbE9US8uiT2ouortlvQv
         IzEZIyrXOoBsGjSFFlcNarnFGNc+CUs+X10KhB86Pe8ik+RT5AvgmItIMJaiDn7ZRMAp
         H/CrPRKxxtnjjEJpLanNyt+/8mVOzu0NN39NA=
Received: by 10.64.196.9 with SMTP id t9mr16823690qbf.72.1220404467281;
        Tue, 02 Sep 2008 18:14:27 -0700 (PDT)
Received: by 10.64.178.13 with HTTP; Tue, 2 Sep 2008 18:14:27 -0700 (PDT)
In-Reply-To: <9e4733910809021729g2ccb062oc8818a69c20f857e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94754>

On 9/2/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> I can see my project list when I do:
>
>  ./cgi-bin/gitweb.cgi

I finally figured it out. There was interaction between my local copy
of git and the system one that was making git commands fail when run
by the web server.

>
>  But it does not show on my website
>  git.digispeaker.com
>
>  Rewrite rules:
>
>  Options FollowSymLinks ExecCGI Indexes
>  RewriteEngine on
>  RewriteRule ^$ /cgi-bin/gitweb.cgi%{REQUEST_URI} [L,PT]
>  RewriteRule ^[a-zA-Z0-9_\-]+\.git/?(\?.*)?$
>  /cgi-bin/gitweb.cgi%{REQUEST_URI} [L,PT]
>
>  gitweb version:
>  our $version = "1.5.3.5.605.g79fa-dirty";
>
>  This used to work so something has changed at my host.
>  How can I debug this?
>
>
>
>  --
>  Jon Smirl
>  jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com
