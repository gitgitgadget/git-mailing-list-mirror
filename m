From: Junio C Hamano <junkio@cox.net>
Subject: Re: Re : 2 questions on git-send-email usage
Date: Tue, 11 Jul 2006 12:22:47 -0700
Message-ID: <7vd5cc3q0o.fsf@assigned-by-dhcp.cox.net>
References: <20060711084635.81393.qmail@web25809.mail.ukl.yahoo.com>
	<44B37893.5090501@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 21:23:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0Noq-0000kP-FJ
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 21:22:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751191AbWGKTWt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 15:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWGKTWt
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 15:22:49 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:31184 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751191AbWGKTWt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 15:22:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060711192248.JMLI12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 11 Jul 2006 15:22:48 -0400
To: Franck <vagabon.xyz@gmail.com>
In-Reply-To: <44B37893.5090501@innova-card.com> (Franck Bui-Huu's message of
	"Tue, 11 Jul 2006 12:08:19 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23729>

Franck Bui-Huu <vagabon.xyz@gmail.com> writes:

> Maybe that patch does what you want.
>
> -- >8 --
>
> Subject: [PATCH] Add a newline before appending "Signed-off-by:"
>
> It looks nicer.
>
> Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>

Haven't checked the code around the patch yet, but does it work
when the original commit log message ends with a blank line and
existing signed-off-by lines by other people?  You do not want
an extra blank lines there.
