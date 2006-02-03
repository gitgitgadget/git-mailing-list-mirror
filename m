From: Marco Costalba <mcostalba@gmail.com>
Subject: Re: [Attn - repository browser authors] diff-tree combined format.
Date: Fri, 3 Feb 2006 13:17:50 +0100
Message-ID: <e5bfff550602030417w290c12b6yc4406f890acadc73@mail.gmail.com>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	 <7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0602012334360.21884@g5.osdl.org>
	 <Pine.LNX.4.64.0602012353130.21884@g5.osdl.org>
	 <Pine.LNX.4.64.0602020002110.21884@g5.osdl.org>
	 <7voe1qtbr5.fsf_-_@assigned-by-dhcp.cox.net>
	 <7vvevyrtn9.fsf_-_@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0602021454060.21884@g5.osdl.org>
	 <7v64nxmhqn.fsf@assigned-by-dhcp.cox.net>
	 <7v1wylkn54.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Paul Mackerras <paulus@samba.org>,
	Marco Costalba <mcostalba@yahoo.it>,
	Aneesh Kumar <aneesh.kumar@gmail.com>,
	Kay Sievers <kay.sievers@suse.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 13:18:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4zsy-0000vU-8j
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 13:17:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWBCMRx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 07:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWBCMRx
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 07:17:53 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:26591 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750723AbWBCMRw convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Feb 2006 07:17:52 -0500
Received: by zproxy.gmail.com with SMTP id l8so628526nzf
        for <git@vger.kernel.org>; Fri, 03 Feb 2006 04:17:52 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rgRvSLdQCXpqP7hpd+KH891hjBxXGeQp8k9G7nFsQn4ejr4Z5mJDSIwCQE1EEu3abIkZAP9yhQgfYhbV3SEFKJ9PcDyYmNELTC1rHv9jk0Uqw/2tK1JgkucSbyqIMDn7nY1O0pmm2C425ksa/+xBXuJol1cGhgMoJYiSAwn7eXc=
Received: by 10.65.180.18 with SMTP id h18mr1161878qbp;
        Fri, 03 Feb 2006 04:17:50 -0800 (PST)
Received: by 10.64.131.15 with HTTP; Fri, 3 Feb 2006 04:17:50 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wylkn54.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15538>

On 2/3/06, Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
>

>
>     (2) match line numbers in the hunk header to normal diff's
>         order:
>
>         @@@ -1,87 -1,3 +1,93 @@@
>
>         That is, counts for parents prefixed with '-', and
>         the count for result prefixed with '+'.
>

It's OK for me. Just one (documentation) note. I found, by means of a
past qgit annotate bug ;-)  in case of small files (1 line files as
VERSION files) the diff header format is slightly different.

Sorry, I am not able to post now the diff output but I think should be
not a problem to reproduce.

This is just, as said above, a note to avoid someone else falls in the
same bug assuming

@ -1,87 -1,3 +1,93 @

is the only possible header format.


Regarding the rest is all OK for me. I choose to do not alter/coloring
the patch as gitk does, but to always use red for removed lines and
green for added and to keep the patch output _as is_ . I found this
more simple and clear, at least for me.

Marco
