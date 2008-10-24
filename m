From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2008, #05; Wed, 22)
Date: Fri, 24 Oct 2008 15:45:11 +0200
Organization: At home
Message-ID: <gdsjb1$eob$1@ger.gmane.org>
References: <7v8wsf50ne.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 15:43:36 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtMwn-0008Ef-Hh
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 15:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbYJXNmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 09:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752559AbYJXNmG
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 09:42:06 -0400
Received: from main.gmane.org ([80.91.229.2]:34651 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159AbYJXNmE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 09:42:04 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KtMvR-0001MK-Vn
	for git@vger.kernel.org; Fri, 24 Oct 2008 13:42:01 +0000
Received: from abwm208.neoplus.adsl.tpnet.pl ([83.8.236.208])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 13:42:01 +0000
Received: from jnareb by abwm208.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 24 Oct 2008 13:42:01 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abwm208.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99035>

Junio C Hamano wrote:

> * gb/gitweb-pathinfo (Tue Oct 21 21:34:54 2008 +0200) 5 commits
>  - gitweb: generate parent..current URLs
>  - gitweb: parse parent..current syntax from PATH_INFO
>  - gitweb: use_pathinfo filenames start with /
>  - gitweb: generate project/action/hash URLs
>  - gitweb: parse project/action/hash_base:filename PATH_INFO
> 
> Seventh iteration; hopefully the usual gitweb gangs will give quick
> comments and ack to push this out to 'next' soon.

If I remember correctly v7 is mainly cosmetic changes, and I have
acked all or almost all of the equivalent patches from v6.
 
> * gb/refactor-pathinfo (Fri Oct 10 20:42:26 2008 +0200) 1 commit
>  + gitweb: refactor input parameters parse/validation
> 
> A major cleanup on the way gitweb parses its input arguments.
> Future gitweb patches to add more arguments into the PATH_INFO
> depend upon this initial cleanup work.

Nice.

> * jn/gitweb-customlinks (Sun Oct 12 00:02:32 2008 +0200) 1 commit
>  - gitweb: Better processing format string in custom links in navbar
> 
> Waiting for some sort of response from Pasky.
> 
> * jc/gitweb-fix-cloud-tag (Tue Oct 14 21:27:12 2008 -0700) 1 commit
>  + Fix reading of cloud tags
> 
> Request-for-review-and-ack sent; waiting for response.

It would be nice to have those two...

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
