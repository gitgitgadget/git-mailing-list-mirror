From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git /objects directory created 755 by default?
Date: Wed, 21 Dec 2005 18:23:57 +1300
Message-ID: <46a038f90512202123p5c7fbbe7qbf930abd8965a88c@mail.gmail.com>
References: <46a038f90512201525k5eb7cf62u65de2cd51424df37@mail.gmail.com>
	 <7vacevgwqr.fsf@assigned-by-dhcp.cox.net>
	 <7vlkyffcxp.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90512201828w618a64dexc22a64b8b6bc2b70@mail.gmail.com>
	 <7vacevdoti.fsf@assigned-by-dhcp.cox.net>
	 <46a038f90512202115o652d8e00v86182302513d1319@mail.gmail.com>
	 <7vzmmvc9l1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 06:25:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EowSJ-0005nW-UD
	for gcvg-git@gmane.org; Wed, 21 Dec 2005 06:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVLUFYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 00:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVLUFYA
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 00:24:00 -0500
Received: from wproxy.gmail.com ([64.233.184.207]:9789 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751132AbVLUFX7 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 00:23:59 -0500
Received: by wproxy.gmail.com with SMTP id 57so60402wri
        for <git@vger.kernel.org>; Tue, 20 Dec 2005 21:23:58 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=C793eqxh8DgMflmJm61iy7rAnO7u6+s/CqDmlauT9qAPWYOHjfotvVDggR+xXEuZK+ODHSAYQrnlCZtLu3VB4b8ZvdfQ+fIZBpyIH05om4jMQNcXRCszuHb6gYNBlvWufXPQ/HHN/zwFSu/C9mwoPEwjt5+hRGppj8VmG/+W1rQ=
Received: by 10.54.102.14 with SMTP id z14mr436525wrb;
        Tue, 20 Dec 2005 21:23:58 -0800 (PST)
Received: by 10.54.72.15 with HTTP; Tue, 20 Dec 2005 21:23:57 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmmvc9l1.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13868>

On 12/21/05, Junio C Hamano <junkio@cox.net> wrote:
> Martin Langhoff <martin.langhoff@gmail.com> writes:
>
> > Could git-shell also be used by a SourceForge-like project, offering
> > per-developer git repositories? If they are using the (BSDish?)
> > convention of not having a group per user this could backfire.
>
> Fair enough.  And I realize that the initial umask should be
> configurable by the administrator who prepares ssh accounts
> somehow (I do not know exactly how though).

Something like rssh, which supports rsync, cvs and sftp (and should
support git!), can set the umask based on a config. I think
/etc/bashrc would work too. In Eduforge, I think we have /etc/skel
with a group-friendly umask.

cheers,


martin
