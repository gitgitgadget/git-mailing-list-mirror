From: Steven Penny <svnpenn@gmail.com>
Subject: Re: Git commit path vs rebase path
Date: Thu, 10 May 2012 23:35:48 -0500
Message-ID: <CAAXzdLXbYp5YW9cZXxmRJk0MP=6PU897f4nuTe4ipLqk+EH9PQ@mail.gmail.com>
References: <CAAXzdLU6bQ7ta4_-WfGJVaJgt1R5tX=4PW2sq3SdjAB+F72w+Q@mail.gmail.com>
	<7vaa1j7vg1.fsf@alter.siamese.dyndns.org>
	<4FA8BBB0.1080406@viscovery.net>
	<CAAXzdLVaDAQkd_9qjnmTRoy8ccpyrZvwvBJQAfkp7LkYa7Li2A@mail.gmail.com>
	<4FA8C5DB.5060002@viscovery.net>
	<CAAXzdLW9_O+feVpBhDSXQH_SFRdrct1tjadpFoJ5d7-Qd1LWEg@mail.gmail.com>
	<7vhavqwqpz.fsf@alter.siamese.dyndns.org>
	<7v1umuwpo9.fsf@alter.siamese.dyndns.org>
	<CAAXzdLVj0szCgpdOSdhnLdkBKAM+e6vrQpvrsz4HeUo+Nh1K6A@mail.gmail.com>
	<4FAC047A.4010001@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri May 11 06:36:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SShai-0004hZ-0e
	for gcvg-git-2@plane.gmane.org; Fri, 11 May 2012 06:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752316Ab2EKEgL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 May 2012 00:36:11 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60358 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274Ab2EKEfu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2012 00:35:50 -0400
Received: by yhmm54 with SMTP id m54so2225416yhm.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 21:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=5vCobo33tZ8A2Zce6Nhy8I3Fs3VIRBE8oi69zL4GFyM=;
        b=RjP0QC7Ob3Q1Ml7T/NKkG40Ob4rFdKEC2pd4HZ0G4fc7lo/7deLO0b9ofowvJEInjs
         gknKhKu3TV1xGwKQOPXCeqg6TxuDpwSt+iigju+7MN5ueROphj+1wAG84fXt3IqpvlHR
         UFm7UXSZckJuc1+QCy/aO5LxzCUzKvyLJoIjUPv3+RQQtu+JbFQXxmpi2YvEiBd0O/1D
         eGGUGw2qjJupOtuzzNj483yOL8ZSXnMuCuUGm7emPw5DvNSgjlD6teUA9O3qWr9x4w+s
         qIs8b5KY8rL0vOwqGmxCRRcFEbd9L5L0aNbRUDSFQ5qBGm9uL4AeRljUljdzkwUraHv1
         5XtA==
Received: by 10.50.207.38 with SMTP id lt6mr784269igc.55.1336710948945; Thu,
 10 May 2012 21:35:48 -0700 (PDT)
Received: by 10.231.80.147 with HTTP; Thu, 10 May 2012 21:35:48 -0700 (PDT)
In-Reply-To: <4FAC047A.4010001@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197655>

Ramsay Jones wrote:
> I would rather define a script; it can then be used independently of git.

So your suggestion is to have git-sh-setup.sh account for MinGW, which is its
current state, but not account for Cygwin?

> Personally, I don't have this specific problem because I use (the cygwin
> version of) vim. (does anybody actually use notepad?)

If you had read carefully, you would have noticed that I mentioned more than
notepad. As well Notepad2, and Notepad++, etc.


> I mostly, but not exclusively, use cygwin tools on cygwin. For example I
> use win32 versions of doxygen, ghostscript, tex (MikTex 2.7), graphviz etc.
> However, the makefiles which drive those tools use relative paths ...

This convo is not about what tools _you_ use, but about the current
incompatibility with several native windows text editors.
