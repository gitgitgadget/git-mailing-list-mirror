From: Junio C Hamano <junkio@cox.net>
Subject: Re: 2 build issues
Date: Mon, 14 Aug 2006 16:12:20 -0700
Message-ID: <7vfyfydi97.fsf@assigned-by-dhcp.cox.net>
References: <20060814121156.84bc6e34.rdunlap@xenotime.net>
	<7vd5b3dl4c.fsf@assigned-by-dhcp.cox.net>
	<20060814152923.bc295ef3.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 01:12:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GClbd-0000zf-FV
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 01:12:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbWHNXMW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 19:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWHNXMW
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 19:12:22 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:31872 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S965046AbWHNXMW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 19:12:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060814231221.CXS6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Aug 2006 19:12:21 -0400
To: "Randy.Dunlap" <rdunlap@xenotime.net>
In-Reply-To: <20060814152923.bc295ef3.rdunlap@xenotime.net> (Randy Dunlap's
	message of "Mon, 14 Aug 2006 15:29:23 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25422>

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

> On Mon, 14 Aug 2006 15:10:27 -0700 Junio C Hamano wrote:
>
>> I see many documents floating on the web that call CDPATH "an
>> environment variable".  It is a disease X-<.
>
> What is CDPATH then?  (other than trouble/disease)
> I find it useful (usually :).

What I mean is that it belongs to the "set" command output but
should not be in "printenv" command output.

It is a useful shell variable to help interactive use, but it
causes trouble without benefit when exported to the environment
(breaks scripts you invoke without you knowing).  Calling such
a shell variable "an environment variable" is spreading trouble.
