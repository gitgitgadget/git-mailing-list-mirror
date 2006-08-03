From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb testing with non-apache web server
Date: Thu, 03 Aug 2006 12:41:20 -0700
Message-ID: <7virl9ppy7.fsf@assigned-by-dhcp.cox.net>
References: <20060803075403.GA5238@buici.com> <easbev$act$1@sea.gmane.org>
	<20060803153403.GA30729@buici.com> <eat5qp$3sr$1@sea.gmane.org>
	<7vfygdr888.fsf@assigned-by-dhcp.cox.net> <eatfog$8er$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 03 21:42:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8j4d-0003WC-EO
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 21:41:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWHCTlW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 15:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWHCTlW
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 15:41:22 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:49629 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030217AbWHCTlV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Aug 2006 15:41:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060803194120.FCXD18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Aug 2006 15:41:20 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <eatfog$8er$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	03 Aug 2006 20:37:39 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24751>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Well, more importantly, why would we do something like this in the first 
>> place?
>> 
>> Wouldn't it be a lot better to just rip out PATH_INFO stuff,
>> especially since all pages the script generates use ?p=$project 
>> to pass that information around and never uses PATH_INFO?
>
> The PATH_INFO is here because it is easier to edit parameters by hand when
> the most important one, the project to examine, can be passed as PATH_INFO.

Huh?  I do not get that.

Suppose I am looking at my repository.  I visit there from my
Firefox and see this in the location bar:

	http://www.kernel.org/git/?p=git/git.git;a=summary

Now I would want to check if there are updates to gitk.  So I
click on the location bar, and edit it to:

	http://www.kernel.org/git/?p=gitk/gitk.git;a=summary

(that's two insertions of 'k').

Now with PATH_INFO, how exactly is this easier?
