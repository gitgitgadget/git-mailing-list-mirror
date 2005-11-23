From: Junio C Hamano <junkio@cox.net>
Subject: Re: Why not clone to a remote directory over SSH
Date: Wed, 23 Nov 2005 15:26:58 -0800
Message-ID: <7vd5kr3pz1.fsf@assigned-by-dhcp.cox.net>
References: <20051123211601.GA2260@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 24 00:28:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ef41I-0005VM-4U
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 00:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVKWX1J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Nov 2005 18:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVKWX1J
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Nov 2005 18:27:09 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:31707 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751294AbVKWX07 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2005 18:26:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051123232546.CFPA17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Nov 2005 18:25:46 -0500
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20051123211601.GA2260@hpsvcnb.fc.hp.com> (Carl Baldwin's message
	of "Wed, 23 Nov 2005 14:16:01 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12659>

Carl Baldwin <cnb@fc.hp.com> writes:

> It might be cool to enable cloning to a remote over ssh if the remote
> doesn't yet exist.
>
> % git clone . machine:/path/to/new/repository

I wonder if that is:

	$ ssh machine 'git clone '`hostname`:`pwd`' /path/to/new/repository'

Obviously you need a working git setup on the other end and
probably need to be much more careful shell-quoting if your
hostname and pwd has metacharacters, but...
