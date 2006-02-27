From: Aubrey <aubreylee@gmail.com>
Subject: Re: Quick question: how to generate a patch?
Date: Tue, 28 Feb 2006 00:18:57 +0800
Message-ID: <6d6a94c50602270818k5f82bb8ft68a19899db3db636@mail.gmail.com>
References: <6d6a94c50602270657m453cc581p6ec290c20879de25@mail.gmail.com>
	 <Pine.LNX.4.64.0602270801280.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 17:21:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDl5W-00077a-0z
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 17:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWB0QS7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 11:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWB0QS7
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 11:18:59 -0500
Received: from pproxy.gmail.com ([64.233.166.183]:16832 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751481AbWB0QS6 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 11:18:58 -0500
Received: by pproxy.gmail.com with SMTP id o67so758839pye
        for <git@vger.kernel.org>; Mon, 27 Feb 2006 08:18:57 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WLhHdxrkGGhKzZLkSME99Gek7I+ay0/4PuipXPF3dWPC3FR0H6qt6MN+Swy5ArXEb3Ekaigo8mK8QVT/XGMOerDjVWOys8LZRu62WfaK493IwhQUcx0gLhr35CrsSTf0sArFzIRdED4cxAMLheZqa7dlpCR15SZ/VUJg7Osqj7A=
Received: by 10.65.160.20 with SMTP id m20mr584389qbo;
        Mon, 27 Feb 2006 08:18:57 -0800 (PST)
Received: by 10.65.185.6 with HTTP; Mon, 27 Feb 2006 08:18:57 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602270801280.22647@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16857>

> > The file my.patch is generated. But the unchanged files information is
> > also included in the patch file. It should be quiet.
>
> It sounds like your index is not synchronized with your file contents.
> Have you done "touch" on files? Or edited them, and then edited them back?
>
> If so, "git-update-index --refresh" will re-synchronize your index with
> whatever file contents you have.
>
No, what I did was just "git clone" one repository to my local directory.
And entered the local directory to modify one file I wanted.
Then I run "git diff > my.patch". The "my.patch" was supposed to
contain one file diff information. But it contained the all the files,
including which were not changed.

Thanks to reply. I''ll try to Andreas's suggestion.

Regards,
-Aubrey
