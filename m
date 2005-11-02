From: Junio C Hamano <junkio@cox.net>
Subject: Re: git 0.99.9: Subversion importer breaks RPM generation (rpmbuild bug)
Date: Tue, 01 Nov 2005 19:36:50 -0800
Message-ID: <7vwtjr3elp.fsf@assigned-by-dhcp.cox.net>
References: <junkio@cox.net> <200511012315.jA1NFHbH003838@inti.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 04:38:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX9Qq-0008K8-Q5
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 04:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbVKBDgw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 22:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbVKBDgw
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 22:36:52 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:6064 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932259AbVKBDgv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 22:36:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051102033613.RBDL29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 1 Nov 2005 22:36:13 -0500
To: Horst von Brand <vonbrand@inf.utfsm.cl>
In-Reply-To: <200511012315.jA1NFHbH003838@inti.inf.utfsm.cl> (Horst von
	Brand's message of "Tue, 01 Nov 2005 20:15:17 -0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10997>

Horst von Brand <vonbrand@inf.utfsm.cl> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>
>> One thing we could do without breaking much of the current
>> arrangement is to have a team of people to help porting for
>> major packaging formats (RPMs and Debs mostly but I know we have
>> OpenBSD and Darwin people here too), and ask them to feed me the
>> updates to rpm/deb/whatever target in the Makefile as needed.
>> Especially before a major release I could ask them to test
>> things out and generate binary packages, perhaps taken out of
>> the tip of the master branch, or even another "for-porters"
>> branch for this purpose.
>
> Good idea. Will build RPMs regularly then.

Can I take that to mean you are volunteering?
