From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Remove bashism from t3210-pack-refs.sh
Date: Fri, 06 Oct 2006 17:05:04 +0200
Organization: At home
Message-ID: <eg5r9k$58c$1@sea.gmane.org>
References: <20061006091054.15209.35068.stgit@leonov.stosberg.net> <81b0412b0610060635n51482e71wab02f9a11be4e619@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Oct 06 17:05:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVrFw-00042Q-2X
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 17:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWJFPEw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 11:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWJFPEw
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 11:04:52 -0400
Received: from main.gmane.org ([80.91.229.2]:36779 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932422AbWJFPEw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 11:04:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GVrFb-0003yX-NF
	for git@vger.kernel.org; Fri, 06 Oct 2006 17:04:35 +0200
Received: from host-81-190-18-48.torun.mm.pl ([81.190.18.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 17:04:35 +0200
Received: from jnareb by host-81-190-18-48.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 17:04:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-48.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28405>

Alex Riesen wrote:

> On 10/6/06, Dennis Stosberg <dennis@stosberg.net> wrote:
>> -     SHA1=$(< .git/refs/heads/a) &&
>> +     SHA1=`cat .git/refs/heads/a` &&
> 
> Only "<" (the redirection part) is bashism. The "$()" is POSIX.

BTW. it is not packed-refs safe.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
