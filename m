From: "Roger C. Soares" <rogersoares@intelinet.com.br>
Subject: Re: [ANNOUNCE] GIT 1.5.4-rc3
Date: Sat, 12 Jan 2008 12:24:44 -0200
Message-ID: <4788CDAC.5030409@intelinet.com.br>
References: <7vsl13wmas.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 15:25:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDhIF-0006m5-IK
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 15:25:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759043AbYALOY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 09:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756920AbYALOY2
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 09:24:28 -0500
Received: from cvxbsd.convex.com.br ([200.152.177.10]:1295 "HELO
	cvxbsd.convex.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751942AbYALOY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 09:24:27 -0500
Received: (qmail 89152 invoked by uid 0); 12 Jan 2008 12:26:32 -0200
Received: from rogersoares@intelinet.com.br by cvxbsd.convex.com.br by uid 82 with qmail-scanner-1.20rc3 
 (uvscan: v4.3.20/v4817.  Clear:RC:1:. 
 Processed in 0.407586 secs); 12 Jan 2008 14:26:32 -0000
Received: from unknown (HELO ?200.152.180.33?) (200.152.180.33)
  by cvxbsd.convex.com.br with SMTP; 12 Jan 2008 14:26:31 -0000
User-Agent: Thunderbird 1.5.0.12 (X11/20071129)
In-Reply-To: <7vsl13wmas.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70318>


Junio C Hamano escreveu:
> The third rc for the next feature release GIT 1.5.4 is available
> at the usual places:
>
>   http://www.kernel.org/pub/software/scm/git/
>
>   git-1.5.4.rc3.tar.{gz,bz2}			(tarball)
>   git-htmldocs-1.5.4.rc3.tar.{gz,bz2}		(preformatted docs)
>   git-manpages-1.5.4.rc3.tar.{gz,bz2}		(preformatted docs)
>   testing/git-*-1.5.4.rc3-1.$arch.rpm	(RPM)
>   
Don't know if you already have some recomendation for RHEL5 users, so 
just reporting what I had to do to install the rpms.

To start, I already had git installed from EPEL.
Downloaded perl-Error from 
http://dag.wieers.com/rpm/packages/perl-Error/ to satisfy dependencies. 
There was another dependacy for git-arch I think, but as I don't need it 
I just deleted this one.
When trying to install perl-Error it conflicted with perl-Git from EPEL. 
I think they included perl-Error files inside their perl-Git rpm.
So, after uninstalling all git rpms from EPEL, installing perl-Error 
from dag.wieers, the rc3 git rpms installed successfully.

[]s,
Roger.
