From: =?UTF-8?B?IlBldGVyIFZhbGRlbWFyIE3DuHJjaCAoTGlzdHMpIg==?= 
	<4ux6as402@sneakemail.com>
Subject: Re: git log -Sfoo ignores indentation (whitespace?) changes...
Date: Tue, 03 Mar 2009 16:48:52 +0100
Message-ID: <49AD5164.8090507@sneakemail.com>
References: <49AD3E78.1050706@sneakemail.com> <20090303152333.GB24593@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 16:51:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeWtm-0006gi-Gl
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 16:51:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757304AbZCCPtB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Mar 2009 10:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755438AbZCCPtA
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 10:49:00 -0500
Received: from fep50.mail.dk ([80.160.77.103]:58483 "EHLO fep50.mail.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757302AbZCCPtA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 10:49:00 -0500
Received: from fep45.mail.dk ([195.41.46.228]) by fep50.mail.dk
          (InterMail vM.7.09.02.00 201-2219-117-20090203) with ESMTP
          id <20090303154857.XZHM9250.fep50.mail.dk@fep45.mail.dk>
          for <git@vger.kernel.org>; Tue, 3 Mar 2009 16:48:57 +0100
Received: from [172.22.216.222] (really [77.233.248.193]) by fep45.mail.dk
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20090303154856.BWDY25489.fep45.mail.dk@[172.22.216.222]>
          for <git@vger.kernel.org>; Tue, 3 Mar 2009 16:48:56 +0100
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <20090303152333.GB24593@coredump.intra.peff.net>
X-Authentication-Info: Submitted using SMTP AUTH at fep45.mail.dk from [77.233.248.193] at Tue, 3 Mar 2009 16:48:55 +0100
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112093>

How sad... From "git log -Sfoo" looking like a really cool feature, it=20
now for me goes into the "must be plumbing because I have no use for it=
"=20
bin, as I can't rely on it:

If a commit removes mention of foo one place and just accidentally=20
happens to add foo somewhere completely unrelated then it wouldn't show=
=20
up in the output.

Would be neat with a feature that does what I thought -S did tho...

Thanks, Jeff, for both the answer and the documentation patch.

Peter
--=20
Peter Valdemar M=C3=B8rch
http://www.morch.com
