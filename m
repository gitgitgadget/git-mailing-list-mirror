From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: Pulling from refs/remotes/ ?
Date: Sat, 26 May 2007 16:47:56 -0300
Message-ID: <46588EEC.4080101@xs4all.nl>
References: <f35d9n$21e$1@sea.gmane.org>	<7v7iqxvgx8.fsf@assigned-by-dhcp.cox.net> <46563D55.3070607@xs4all.nl>	<7v3b1lvfc5.fsf@assigned-by-dhcp.cox.net> <465648EA.8070608@xs4all.nl> <7vwsyxsit8.fsf@assigned-by-dhcp.cox.net>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 26 21:50:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs2HI-0006nb-MJ
	for gcvg-git@gmane.org; Sat, 26 May 2007 21:50:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758200AbXEZTuA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 15:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758498AbXEZTt7
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 15:49:59 -0400
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:3371 "EHLO
	smtp-vbr14.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753760AbXEZTt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 15:49:59 -0400
Received: from [192.168.1.102] (c911deb6.bhz.virtua.com.br [201.17.222.182])
	(authenticated bits=0)
	by smtp-vbr14.xs4all.nl (8.13.8/8.13.8) with ESMTP id l4QJnpG6019763
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 26 May 2007 21:49:53 +0200 (CEST)
	(envelope-from hanwen@xs4all.nl)
User-Agent: Thunderbird 1.5.0.10 (X11/20070302)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7vwsyxsit8.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48489>

Junio C Hamano escreveu:
> And the reason it is "insane" is the same as why we currently do
> not interpret "git pull $repo origin/master" as a request to
> pull from remotes/origin/master.  It really is none of your
> business what kind of remote branches the other end is
> interacting with.

fair enough; my remaining gripe is that the error message is broken.
My suggestion is to have  

  git fetch . XXX

(and by extension: pull) print something like

  Will not fetch from self. 
  Do you mean "git merge XXX" or "git update-ref XXX" ? 

It may be an artificial restriction when compared to "git pull $dir XXX" 
but I think it helps the user better than "Fetch failure".

-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
