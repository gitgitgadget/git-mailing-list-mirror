From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb: charset problem
Date: Tue, 25 Oct 2005 10:31:43 -0700
Message-ID: <7vu0f5fqps.fsf@assigned-by-dhcp.cox.net>
References: <200510241356.j9ODuAHn005060@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.64.0510241743280.25300@iabervon.org>
	<7vwtk2k08z.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0510251138290.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 19:35:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUSeK-0007Dw-GR
	for gcvg-git@gmane.org; Tue, 25 Oct 2005 19:31:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVJYRbp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Oct 2005 13:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVJYRbp
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Oct 2005 13:31:45 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:55486 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932226AbVJYRbp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2005 13:31:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051025173114.JJNM29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 25 Oct 2005 13:31:14 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0510251138290.25300@iabervon.org> (Daniel
	Barkalow's message of "Tue, 25 Oct 2005 12:01:15 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10601>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Consider if you started a project in EUC-JP, and then decided to switch to 
> UTF-8 later (when your environment handled it cleanly, perhaps). You could 
> convert...

I am not saying that using UTF-8 is impossible in some
situations.  I am saying that if all involved parties agree to
use something else in a private project, that is their choice
and there is no reason to forbid it.  They may be shooting in
the foot in the long run, they may be not.

For the internal project I was using as an example, I do not
forsee anybody who does not do Japanese ever touching it, nor it
needs to record any other language in the future (this comes
from the nature of the project -- keeping track of some
documents that are written in Japanese and we are not in
translation business).  Log and contents being encoded in EUC-JP
is perfectly valid right now and in the future in that project.
In such an application there is nothing gained by using UTF-8,
and it will only inconvenience the users if we insisted on
UTF-8.
