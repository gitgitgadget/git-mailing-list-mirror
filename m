From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH 4/4] Add a basic test case for git send-email, and fix some real bugs discovered.
Date: Tue, 30 May 2006 01:51:26 -0700
Message-ID: <20060530085125.GB32457@h4x0r5.com>
References: <7v8xok3vhj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <rda@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 10:51:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkzwt-0004w5-JK
	for gcvg-git@gmane.org; Tue, 30 May 2006 10:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbWE3Ivd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 04:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWE3Ivc
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 04:51:32 -0400
Received: from h4x0r5.com ([70.85.31.202]:56848 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S932186AbWE3Ivc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 May 2006 04:51:32 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1Fkzwk-0008U5-Il; Tue, 30 May 2006 01:51:26 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xok3vhj.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21024>

On Mon, May 29, 2006 at 10:57:44PM -0700, Junio C Hamano wrote:
> Ryan Anderson <rda@google.com> writes:
> 
> > Signed-off-by: Ryan Anderson <rda@google.com>
> >
> > ---
> >
> > 64ea8c0210c2e9d1711a870460eca326778a4ffc
> >  t/t9001-send-email.sh |   34 ++++++++++++++++++++++++++++++++++
> >  1 files changed, 34 insertions(+), 0 deletions(-)
> >  create mode 100755 t/t9001-send-email.sh
> 
> Adds test, alright, but I do not see the fix.  Is this a thinko?

I apparently screwed this patch up (and I think I lost it, in the
process.)

Let me reconstruct, I fixed the problems in a different way (I reworked
unique_email_address(@) into  unique_email_address($@), to pass a flag
stating whether to returned the cleaned email address or not, that
should come in a few minutes.)
