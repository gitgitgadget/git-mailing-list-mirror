From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Print empty line between raw, stat, summary and patch
Date: Tue, 27 Jun 2006 11:03:24 -0700
Message-ID: <7vhd268oib.fsf@assigned-by-dhcp.cox.net>
References: <20060627150917.7eabde58.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 20:03:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvHuL-0006TQ-H1
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 20:03:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161238AbWF0SD0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 14:03:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161249AbWF0SD0
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 14:03:26 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:35467 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1161238AbWF0SD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 14:03:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060627180325.TQGB11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Jun 2006 14:03:25 -0400
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060627150917.7eabde58.tihirvon@gmail.com> (Timo Hirvonen's
	message of "Tue, 27 Jun 2006 15:09:17 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22748>

Timo Hirvonen <tihirvon@gmail.com> writes:

> Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
> ---
>
>   Should we print options->line_termination instead of \n between all
>   fields?

I personally do not think it is a big deal since combination of
stat, summary and patch are primarily for human consumption, but
somebody might want to write a frontend GUI on top of this
output and having an easy way to seperate the parts for machine
consumption might be helpful.

>   The old code didn't support as many combinations of raw,
>   stat, summary and patch so I'm not 100% sure about this.

Think of it as an opportunity to come up with the most sensible
without having to worry about backward compatibility ;-)  I'll
let you know what I think after I stare at its output for some
time.

Thanks.
