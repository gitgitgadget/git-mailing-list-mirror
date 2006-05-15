From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] send-email: allow sendmail binary to be used instead of SMTP
Date: Mon, 15 May 2006 17:01:21 -0400
Message-ID: <20060515210110.GR32076@h4x0r5.com>
References: <1147660345772-git-send-email-normalperson@yhbt.net> <7vpsifx2b7.fsf@assigned-by-dhcp.cox.net> <20060515092704.GB6855@localdomain> <7vmzdjtya4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 23:02:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfkCZ-0002lU-UU
	for gcvg-git@gmane.org; Mon, 15 May 2006 23:02:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965220AbWEOVB6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 17:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbWEOVB6
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 17:01:58 -0400
Received: from h4x0r5.com ([70.85.31.202]:3086 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S965220AbWEOVB5 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 17:01:57 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1FfkC3-0007sa-Ub; Mon, 15 May 2006 17:01:32 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmzdjtya4.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20084>

On Mon, May 15, 2006 at 02:47:31AM -0700, Junio C Hamano wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > I believe this is what Martin wanted.  I think it's a good idea since
> > sendmail binaries tend to be more flexible, but I'm ok with it either
> > way.
> 
> I am not opposed to have an option to run a local submission
> agent binary (I said I like that if(){}else{} there, didn't I?).
> The ability to do so is a good thing.  I am not however sure
> about changing the default when no option is specified on the
> command line.

I think, in practice, that /usr/lib/sendmail will exist anywhere you hve
something running on port 25, at least on unixy machines.  In my
searches at an old job, that appeared to be the canonical place to call
sendmail from, and every MTA appears to provide an appropriate binary
there.

So, I'm not overly worried about it.
