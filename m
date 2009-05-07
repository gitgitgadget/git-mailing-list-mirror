From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH/RFC] daemon.c: replace inet_ntop with getnameinfo
Date: Thu, 07 May 2009 22:51:27 +0900
Message-ID: <87tz3x9g2o.fsf@catnip.gol.com>
References: <4A02D288.6040804@googlemail.com> <4A02D70B.6090305@op5.se>
	<EC96A79E-4D4E-467A-A10F-D905FE02E508@gmail.com>
	<m3tz3xm3zt.fsf@localhost.localdomain>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benjamin Kramer <benny.kra@googlemail.com>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, jdl@jdl.com
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 15:53:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M242A-0002e4-0Z
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 15:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759896AbZEGNvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 09:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759749AbZEGNvp
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 09:51:45 -0400
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:49348 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760114AbZEGNvo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 09:51:44 -0400
Received: from 218.231.212.123.eo.eaccess.ne.jp ([218.231.212.123] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1M240V-0001Sa-WF; Thu, 07 May 2009 22:51:28 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 59F3BDFA9; Thu,  7 May 2009 22:51:27 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <m3tz3xm3zt.fsf@localhost.localdomain> (Jakub Narebski's message
	of "Thu, 07 May 2009 06:34:10 -0700 (PDT)")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118479>

Jakub Narebski <jnareb@gmail.com> writes:
> BTW. this is not only MS Windows that have problems with ':' in paths
> (because of it being drive letter separator), but also IIRC MacOS X,
> where ':' and not '/' is directory separator.
>
> The fact that ':' is separator of paths in $PATH environmental variable
> is a bit complication, but you can always escape ':' in $PATH.

No, that was in "classic mac os"; osx uses "/".

-Miles

-- 
Politics, n. A strife of interests masquerading as a contest of
principles. The conduct of public affairs for private advantage.
