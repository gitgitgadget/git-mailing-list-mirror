From: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [ANNOUNCE] GIT 1.4.3
Date: Sat, 21 Oct 2006 06:40:50 +0100
Message-ID: <20061021054050.GB29920@ftp.linux.org.uk>
References: <7vejt5xjt9.fsf@assigned-by-dhcp.cox.net> <7v4ptylfvw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610201709430.3962@g5.osdl.org> <20061021021235.GA29920@ftp.linux.org.uk> <7vbqo6i6da.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 07:40:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb9bL-0008Ea-Br
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 07:40:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992829AbWJUFkv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 01:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932246AbWJUFkv
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 01:40:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:24220 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932222AbWJUFkv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 01:40:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.52 #1 (Red Hat Linux))
	id 1Gb9bG-0006cb-C8; Sat, 21 Oct 2006 06:40:50 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vbqo6i6da.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29584>

On Fri, Oct 20, 2006 at 10:29:37PM -0700, Junio C Hamano wrote:
> Al Viro <viro@ftp.linux.org.uk> writes:
> 
> > Speaking of irritations...  There is a major (and AFAICS fixable)
> > suckitude in git-cherry.  Basically, what it does is...
> 
> Yeah, that sucks big time.  I never realized there are people
> who still are using it, though. git-format-patch used to use it,
> but the version was retired exactly five months ago, and there
> is no in-tree users anymore.

Huh?  If you have a saner way to do reordering/changeset-by-changeset
rebasing of branches...  git-cherry followed by selective cherry-pick
works and is much more convenient than messing with implementing what
I need via git-am and shitloads of editing...
