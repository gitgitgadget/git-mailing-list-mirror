From: "Torgil Svensson" <torgil.svensson@gmail.com>
Subject: Re: file disappears after git rebase (missing one commit)
Date: Sat, 18 Aug 2007 23:11:36 +0200
Message-ID: <e7bda7770708181411v67730b57ibcd8df44695e036f@mail.gmail.com>
References: <e7bda7770708181237u34253bf1h7c3fe0987d13d3b3@mail.gmail.com>
	 <alpine.LFD.0.999.0708181247330.30176@woody.linux-foundation.org>
	 <e7bda7770708181329i7a64e613y88187a608c323a07@mail.gmail.com>
	 <alpine.LFD.0.999.0708181334200.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 18 23:11:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMVaB-0007z0-G4
	for gcvg-git@gmane.org; Sat, 18 Aug 2007 23:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754576AbXHRVLj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Aug 2007 17:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754309AbXHRVLj
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Aug 2007 17:11:39 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:21610 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbXHRVLh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2007 17:11:37 -0400
Received: by wa-out-1112.google.com with SMTP id j4so309832wah
        for <git@vger.kernel.org>; Sat, 18 Aug 2007 14:11:37 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QAruPA9r8vulqucX5PMhEmj+mJcn/hEGB5XQmXGe7nxHVa77NB2jEXD4novlY12PR77VoypQ4Z0e5DSI62cPRPM7ywddcsred6QjSU6t2COQgEaQq/r+yP8auuOa/tPppVKoG63rTZGHDBo92a9GkiHxpZV/Wx4xEOJ3/CcQcvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gBQXanBFXfeGyzpKNz94WHr+2U4Twa9nlp80JdIKnFEy5mgFV5aNJzfow0GOJaP2E+HevvFToPxbrksX4PfO1nsENY/0hpi2AypaBMUS7TKKYah/5mThbuQPbMD54cgXZqzpdfv+wBqvOpg1nZ+Fadnsi6ZJfXA8c6JL/fAPFBo=
Received: by 10.114.153.18 with SMTP id a18mr4599116wae.1187471497014;
        Sat, 18 Aug 2007 14:11:37 -0700 (PDT)
Received: by 10.114.180.20 with HTTP; Sat, 18 Aug 2007 14:11:36 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0708181334200.30176@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56113>

On 8/18/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Yeah, I was thinking about the external "git-patch-id" program, which
> actually takes the diff and looks at it from there. But
> "--ignore-if-in-upstream" does its own binary file testing, and doesn't
> use the generic diff code at all.
>
> So the following patch is likely much better..

This patch made the difference and solved the issue for me. Thanks

//Torgil
