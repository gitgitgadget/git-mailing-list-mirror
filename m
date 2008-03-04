From: "Steve French" <smfrench@gmail.com>
Subject: Re: kernel.org git tree corrupt?
Date: Mon, 3 Mar 2008 22:42:34 -0600
Message-ID: <524f69650803032042rab309f3nd5c2d52d312fb3c5@mail.gmail.com>
References: <524f69650803020749o469f2e48l125a55267b0b5d13@mail.gmail.com>
	 <alpine.LFD.1.00.0803021302070.17889@woody.linux-foundation.org>
	 <524f69650803021943i33ce6ddbo309f118cd0a77ac9@mail.gmail.com>
	 <alpine.LFD.1.00.0803030800460.17889@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Tue Mar 04 05:44:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWP0n-0001K2-Us
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 05:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760668AbYCDEnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 23:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760240AbYCDEnQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 23:43:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:25686 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbYCDEmj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 23:42:39 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2457346ugc.16
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 20:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=6s0uEo1sXTVSarZm/UhWgAvSVIP8iLQqJO/37dzj2YY=;
        b=Ayg+6I1ifDkwe0OLylFIafoqA11bOpn63qJ2y/bch09sPNLNUINLya+kRl9Pa31oCJqvXoc67HzxtivUnxOmVVMoQMXrIpRrOtw9Gyv1PqYgoENLbPs8yr+yKCOhD97muJcVj4W+ykDleZr5MTPGBSmfjwl8ZzRJQeZLwew4Qxg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eX7W+lmntOSLqQS5vLTE2UtEAocqQbe0q7+ZqIaC4oMwwOIAmcY+jJzUHbhsC7TX28ZxgpAFxChtjTmPisCnzGyELBAasi6G5fnKsA1eQ5J/HBnnPepzsLLBYN+GHs0ga48zd5Wx7ePfeHitCvoHUgjPofu2tc5Tfl4VGObZID4=
Received: by 10.78.131.8 with SMTP id e8mr1774026hud.35.1204605754864;
        Mon, 03 Mar 2008 20:42:34 -0800 (PST)
Received: by 10.78.172.19 with HTTP; Mon, 3 Mar 2008 20:42:34 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0803030800460.17889@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76031>

On Mon, Mar 3, 2008 at 10:21 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  On Sun, 2 Mar 2008, Steve French wrote:
>  > Now "git branch -a" shows
>  > * master
>  >   origin/master
>  >
>  > It is missing "origin/HEAD"
>
>  Ahh, yeah, my bad. The origin/HEAD thing will be created if you use either
>  clone or "git remote add -m master" to create the remote. But when I asked
>  you to do it by just editing the config file, you now have to create that
>  HEAD pointer manually too.
>
>  You can do
>
>         git symbolic-ref refs/remotes/origin/HEAD refs/remotes/origin/master
>
>  to create the thing (it just creates a symbolic ref from the origin/HEAD
Worked.

Shaggy pointed me to the git-request-pull script which is
easier than the previous scripts I used and now works fine on
the cifs-2.6.git tree so will send merge request.


-- 
Thanks,

Steve
