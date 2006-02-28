From: "Tony Luck" <tony.luck@gmail.com>
Subject: Re: fatal: unexpected EOF
Date: Tue, 28 Feb 2006 07:59:09 -0800
Message-ID: <12c511ca0602280759t2e584a4bkd7b6f4d97ade92f7@mail.gmail.com>
References: <440449D7.3010508@didntduck.org>
	 <Pine.LNX.4.64.0602280731210.22647@g5.osdl.org>
	 <44046F94.3070806@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Linus Torvalds" <torvalds@osdl.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 28 16:59:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE7Fr-00059A-1C
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 16:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbWB1P7L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 10:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751811AbWB1P7L
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 10:59:11 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:64340 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751622AbWB1P7K convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 10:59:10 -0500
Received: by zproxy.gmail.com with SMTP id i11so1202880nzh
        for <git@vger.kernel.org>; Tue, 28 Feb 2006 07:59:09 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rri1ckSAJ0gczi1W+tfhnDcwnaVl7d8PwSiT/9+DV7C4S8iZMY4s6/uffcMTG+wBUTSk1PcSnu6LIm09Gp4E+bwYQM2A9mUs3GYHrViyyYOtRYpiRbgdODSZMnB5hDMxr4QItnOPTZuzppo6TwXv1RGa/7mSQv6m1rRmtB3mt68=
Received: by 10.65.119.18 with SMTP id w18mr2019430qbm;
        Tue, 28 Feb 2006 07:59:09 -0800 (PST)
Received: by 10.64.27.10 with HTTP; Tue, 28 Feb 2006 07:59:09 -0800 (PST)
To: "Brian Gerst" <bgerst@didntduck.org>
In-Reply-To: <44046F94.3070806@didntduck.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16941>

> I doubt it is a problem with mirroring, since it affects all repos
> (kernel, git, cogito, etc.) at the same time.

Ditto.  Jes has been grumbling overnight that he can't get a reliable pull
from my kernel repo ... and that hasn't been updated in 10 days, so the
mirror code shouldn't be touching it.  His error was:

  fatal: read error (Connection reset by peer)
  Fetch failure: git://git.kernel.org/pub/...

He also reported that after a few retries it worked.

Does the git daemon log any errors to syslog on the server?  If so, can someone
with access go take a look.

-Tony
