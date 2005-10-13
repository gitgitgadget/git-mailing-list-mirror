From: Morten Welinder <mwelinder@gmail.com>
Subject: Re: diff_tree_stdin
Date: Thu, 13 Oct 2005 11:01:12 -0400
Message-ID: <118833cc0510130801w2e900d9cr79c9666d536ef5b7@mail.gmail.com>
References: <118833cc0510111846q42c5d7e5j162bdacd49dfebbc@mail.gmail.com>
	 <7vu0fl51tg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 17:07:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQ4aF-0000K7-Fy
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 17:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750994AbVJMPBQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Oct 2005 11:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751559AbVJMPBQ
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 11:01:16 -0400
Received: from qproxy.gmail.com ([72.14.204.199]:9546 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750994AbVJMPBP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 11:01:15 -0400
Received: by qproxy.gmail.com with SMTP id p32so123322qba
        for <git@vger.kernel.org>; Thu, 13 Oct 2005 08:01:12 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UpeE1PJdUQL3KTYsAV6iqrtWqILDKrHsZijhi0xO/BBneX5Ewl4pmsvh5Tts3ACixNmA48/1vaR7XPNfaHnNhzq6SHPVsakwCa6z0d86PxoVsmlCB8dxf0/Q7znWyoambRT6bT3Nu4MlYWZbaFhQbnRhADOPBd50g3hlenfyomE=
Received: by 10.65.113.16 with SMTP id q16mr1073995qbm;
        Thu, 13 Oct 2005 08:01:12 -0700 (PDT)
Received: by 10.65.107.8 with HTTP; Thu, 13 Oct 2005 08:01:12 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0fl51tg.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10074>

> I presume you are talking about "line", not this_header[], since
> you are talking about something whose length is already
> calculated.

I was talking about this_header.  It gets slightly more than the length
of "line" which is whatever came in from stdin, subject to a 1000 char
limit.

Morten
