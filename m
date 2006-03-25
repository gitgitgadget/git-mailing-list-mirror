From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: Use a *real* built-in diff generator
Date: Sat, 25 Mar 2006 08:44:50 -0500
Message-ID: <118833cc0603250544h289f385fo683ec7b40cdb0ed@mail.gmail.com>
References: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Davide Libenzi" <davidel@xmailserver.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 14:44:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN94Z-0000HU-1M
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 14:44:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWCYNow (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 08:44:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWCYNow
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 08:44:52 -0500
Received: from wproxy.gmail.com ([64.233.184.237]:30031 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751397AbWCYNov convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 08:44:51 -0500
Received: by wproxy.gmail.com with SMTP id i5so1142597wra
        for <git@vger.kernel.org>; Sat, 25 Mar 2006 05:44:50 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cKbPO/CJe0oeTq5kUBLdY7ba3Nt9u3sXS7DFfZRrx4nNT2gr+abBZ6Q1UeoHsDXmrJJPmR1jkGgasCxG43gca2EgvV2dgLY8OKB3QCldGrJ2u5WXSl07A5sVudvZ5Iif23LjuLXccPtSbuVxnNsewiguHJ3RHkeqDKxZ6pHiSmU=
Received: by 10.35.99.14 with SMTP id b14mr416519pym;
        Sat, 25 Mar 2006 05:44:50 -0800 (PST)
Received: by 10.35.39.13 with HTTP; Sat, 25 Mar 2006 05:44:50 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603241938510.15714@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17984>

The primary correctness concern is that patch understands
the output, ie., the libxdiff + patch brings out right back.

It ought to be fairly easy to script checking every file change
that ever went into a git repository.  You won't cover evil
cases that way, but it should provide some assurances that
nothing is too wrong.

M.
