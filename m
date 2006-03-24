From: "Morten Welinder" <mwelinder@gmail.com>
Subject: Re: Cloning from sites with 404 overridden
Date: Fri, 24 Mar 2006 13:16:19 -0500
Message-ID: <118833cc0603241016h46124f8cr9634ee9f121f2f15@mail.gmail.com>
References: <20060322025921.1722.qmail@science.horizon.com>
	 <442152E0.4020604@op5.se>
	 <slrne28b3a.cp6.mdw@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 19:17:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMqqx-0001BF-Sn
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 19:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWCXSQZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 13:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbWCXSQX
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 13:16:23 -0500
Received: from pproxy.gmail.com ([64.233.166.182]:38175 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751433AbWCXSQU convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 13:16:20 -0500
Received: by pproxy.gmail.com with SMTP id b36so790992pyb
        for <git@vger.kernel.org>; Fri, 24 Mar 2006 10:16:19 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ixMtKfDkRxv6Yo28dflXCTysHJgtki7uv2/ALPr3+1fHIr4v6ajOK5GtAYljTkjR0OCLhslQR6paseRntGhYTdqp86JOmXcoyuepEj4dOIfpGC3EzFgRXaRNLf4moOPpD7ASxOijf/cMcLW43IHocOUIyh8ecT01v3KXRLsQwr8=
Received: by 10.35.78.9 with SMTP id f9mr1470433pyl;
        Fri, 24 Mar 2006 10:16:19 -0800 (PST)
Received: by 10.35.39.13 with HTTP; Fri, 24 Mar 2006 10:16:19 -0800 (PST)
To: "Mark Wooding" <mdw@distorted.org.uk>
In-Reply-To: <slrne28b3a.cp6.mdw@metalzone.distorted.org.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17932>

> (Aside: `C-u 38 0' doesn't work because Emacs hears `C-u 380' and waits
> for a key.  `M-: (insert-char ?0 38) RET' does the right thing, but is
> ugly.  Any better suggestions?)

There's a million ways to skin that cat.

ESC 38 C-q 60 RET

[Octal 060 == '0']

M.
