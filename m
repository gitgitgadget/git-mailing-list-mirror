From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: help with git usage
Date: Fri, 9 May 2008 01:07:10 +0200
Message-ID: <200805090107.11838.jnareb@gmail.com>
References: <200804291738.m3THc2hC030601@rs40.luxsci.com> <m3tzhjokox.fsf@localhost.localdomain> <200805072242.m47Mg1o0015578@rs40.luxsci.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Daniel Quinlan <danq@brtt.com>
X-From: git-owner@vger.kernel.org Fri May 09 01:08:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuFDh-0000hV-20
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 01:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbYEHXHY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 May 2008 19:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbYEHXHX
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 19:07:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:35403 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbYEHXHW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 19:07:22 -0400
Received: by ug-out-1314.google.com with SMTP id h2so212363ugf.16
        for <git@vger.kernel.org>; Thu, 08 May 2008 16:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=QuuEWxVtjhB9jTH++mtliJNNtuYKW9Ftca/evTdvjWU=;
        b=mQ+JqCJng+D2z9Hc07H0Jep54Ot3kv6dCFgI1PNTcpC5E3uJp7aCVma/iQjMUEVvc4jb+76A2RFwRdbdkhxY+JM3zkRt7PIatOL5qjvfgjEnUyG83RQUXxWJuA+Ok99bEAKHZK91EoPg7reKCJaVDmQhoeaXQ+AUt1Y2KbjiR5U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=boew2dB5nXCGCNKfJ6zwmdo2w4S3sglH8PPehSPKvlspTbJl/8lYX1q7zYJmMlODpxtup4Mh8OLbkbjJDHMVjOAjXGJW1K4MBnBZOg6WaMFYO2sKmxletAZRobd1MNXJ9Wa6l72+x95wMLTrYF8PGMEHKLvCf5qbP9l0DhLQ3mU=
Received: by 10.67.116.7 with SMTP id t7mr146378ugm.38.1210288039864;
        Thu, 08 May 2008 16:07:19 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.232.51])
        by mx.google.com with ESMTPS id z37sm5216348ikz.6.2008.05.08.16.07.15
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 May 2008 16:07:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200805072242.m47Mg1o0015578@rs40.luxsci.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81576>

Dnia czwartek 8. maja 2008 00:41, Daniel Quinlan napisa=B3:

> I'm looking for a way to embed some identifying information about =A0
> version into compiled programs. =A0I hasten to add that I am not look=
ing
> to expand RCS-like tags. =A0Unlike CVS/RCS, git provides a single val=
ue
> that characterizes the whole distribution, at least if everything is
> committed.=20

Take a look how git, tig and Linux kernel does it with *VERSION* file=20
and Makefile (you can take a look at Makefile and GIT-VERSION-GEN via=20
gitweb web interface, e.g. at http://git.kernel.org or=20
http://repo.or.cz).

In short: use git-describe output.
--=20
Jakub Narebski
Poland
