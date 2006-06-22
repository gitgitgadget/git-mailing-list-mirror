From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] gitweb wishlist and TODO list
Date: Thu, 22 Jun 2006 02:14:33 -0700
Message-ID: <7vu06dsgau.fsf@assigned-by-dhcp.cox.net>
References: <e79921$u0e$1@sea.gmane.org> <e7dm8g$mc9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 11:14:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtLGp-00079x-JV
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 11:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161018AbWFVJOg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 05:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWFVJOg
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 05:14:36 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:26327 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751772AbWFVJOf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 05:14:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622091435.NTEP19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 05:14:35 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e7dm8g$mc9$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	22 Jun 2006 11:01:04 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22316>

Jakub Narebski <jnareb@gmail.com> writes:

> Jakub Narebski wrote:
>
>> I am planning on copying features from xmms2's gitweb version 
>> to git's gitweb, and introducing new ones.
>
>> * Refactor generation of navigation bar. There are at least two
>>   implementations of that. With hash dispatch it would be easy to
>>   list all possibilities.
>
> Actually I think that whole gitweb.cgi needs refactoring, badly. Generation
> of navigation bar is only one, admittedly worst, example of code
> duplication.

Yes.  I liked what xmms2 folks did to the navbar exactly for
that reason.  We would be better off to first clean up what we
currently have before starting to build too much on it.
