From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Thu, 22 Jun 2006 11:01:04 +0200
Organization: At home
Message-ID: <e7dm8g$mc9$1@sea.gmane.org>
References: <e79921$u0e$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Thu Jun 22 11:01:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtL43-0005Bd-9I
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 11:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbWFVJBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 05:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWFVJBY
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 05:01:24 -0400
Received: from main.gmane.org ([80.91.229.2]:27603 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932481AbWFVJBX (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 05:01:23 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FtL3r-00059a-5U
	for git@vger.kernel.org; Thu, 22 Jun 2006 11:01:15 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 11:01:15 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 22 Jun 2006 11:01:15 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22313>

Jakub Narebski wrote:

> I am planning on copying features from xmms2's gitweb version 
> to git's gitweb, and introducing new ones.

> * Refactor generation of navigation bar. There are at least two
>   implementations of that. With hash dispatch it would be easy to
>   list all possibilities.

Actually I think that whole gitweb.cgi needs refactoring, badly. Generation
of navigation bar is only one, admittedly worst, example of code
duplication.


Another gitweb feature I can think of:

* Add information about from which repository and which branch in the
  remote repository given branch (head) came from. Should support both
  $GIT_DIR/branches and $GIT_DIR/remotes format, and be easy extendable
  to support branch/repo/remotes configuration in config.

  I think it would be best to show this info (as it is variable long length,
  and optional) as the last column of heads listing. Or would be better to
  just add link with the remote name as text?

  Is git://host.xz/path/to/repo.git#branch correct branch URI?

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
