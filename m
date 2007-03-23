From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: emacs and git...
Date: Fri, 23 Mar 2007 08:29:17 +0100
Message-ID: <38b2ab8a0703230029h7f3faa95u1e2ccb6a9ee4be5e@mail.gmail.com>
References: <38b2ab8a0703220753s67809e87l76ffc57adb725898@mail.gmail.com>
	 <86lkhpmftt.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Fri Mar 23 08:29:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUeDJ-0000n1-Le
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 08:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934037AbXCWH3U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 03:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934257AbXCWH3U
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 03:29:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:6414 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934272AbXCWH3S (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 03:29:18 -0400
Received: by wr-out-0506.google.com with SMTP id 41so989821wry
        for <git@vger.kernel.org>; Fri, 23 Mar 2007 00:29:17 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fJOJUL5Aa4KWGQIwVNdqSM2y3EiDqtE+OHx8bk5lzrizP5VkTL3yvFcWHQi21nYYWLmhUoVROgwDwWNIrqwjHqMOgOGfKCmjGBWcBZFT5j86aVDwMruyNQ/Xwpk9nDZmn0t0e92TgsDU9y7LoN6ypRWi1MGzswV3BC49vCghtM4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mxP1jAj4w1tHABbvUPHdUTMbRKNfVa/tmsZUGmODPAjtPXVaIITKF+zOQVhmhNuz94V8YFGrtA5NEIYCLtT659thACmGN8M1B9d2c9ZhiBQu1UbgT2n5cGL+pB28ZQbeCMcCytZLjA9M3GU+JpEJfjLRnMpYl5ULKyTbsf1IFfw=
Received: by 10.114.155.1 with SMTP id c1mr1055647wae.1174634957098;
        Fri, 23 Mar 2007 00:29:17 -0700 (PDT)
Received: by 10.114.38.12 with HTTP; Fri, 23 Mar 2007 00:29:17 -0700 (PDT)
In-Reply-To: <86lkhpmftt.fsf@blue.stonehenge.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42906>

On 3/22/07, Randal L. Schwartz <merlyn@stonehenge.com> wrote:
>
> I use M-x shell on a regular basis, and have learned to add the following
> three items to my .emacs wherever I'm at:
>
>   (setenv "PAGER" "/bin/cat")
>   (setenv "EDITOR" "/opt/emacs/bin/emacsclient") ; `which emacsclient`
>   (server-start)
>
> Unless you do the first line, programs that like to push things through "less"
> or "more" do some pretty nasty things.

the funny thing is that the following command in emacs' shell actually
do nothing.

$ PAGE=cat git diff HEAD^
$

>  And those last two are nice, because
> you can use "git-commit" directly in the shell window, and it'll pop up an
> emacs buffer.  Read up on emacs-server mode or you won't know how to get out
> of it though. :)
>

yep I already do that.

-- 
Francis
