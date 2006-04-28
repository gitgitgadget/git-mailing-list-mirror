From: Peter Hagervall <hager@cs.umu.se>
Subject: Re: [PATCH] C version of git-count-objects
Date: Fri, 28 Apr 2006 02:10:50 +0200
Message-ID: <20060428001049.GA28347@brainysmurf.cs.umu.se>
References: <20060427101254.GA22769@peppar.cs.umu.se> <Pine.LNX.4.64.0604270914570.18816@localhost.localdomain> <7vhd4ekfu1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604271535460.18816@localhost.localdomain> <20060427194559.GA26386@brainysmurf.cs.umu.se> <Pine.LNX.4.64.0604271257010.3701@g5.osdl.org> <20060427205155.GA26856@brainysmurf.cs.umu.se> <7vaca6k6za.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 28 02:11:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FZGZZ-0001aA-TG
	for gcvg-git@gmane.org; Fri, 28 Apr 2006 02:11:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbWD1AK7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Apr 2006 20:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbWD1AK7
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Apr 2006 20:10:59 -0400
Received: from mail.cs.umu.se ([130.239.40.25]:55531 "EHLO mail.cs.umu.se")
	by vger.kernel.org with ESMTP id S1751701AbWD1AK6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Apr 2006 20:10:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id BB6DD2BD7;
	Fri, 28 Apr 2006 02:10:57 +0200 (MEST)
Received: from mail.cs.umu.se ([127.0.0.1])
 by localhost (mimmi.cs.umu.se [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 18652-04-9; Fri, 28 Apr 2006 02:10:50 +0200 (MEST)
Received: from brainysmurf.cs.umu.se (brainysmurf.cs.umu.se [130.239.89.21])
	by mail.cs.umu.se (Postfix) with ESMTP id A0FFA2BB7;
	Fri, 28 Apr 2006 02:10:50 +0200 (MEST)
Received: by brainysmurf.cs.umu.se (Postfix, from userid 12006)
	id 56FFC73C; Fri, 28 Apr 2006 02:10:50 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vaca6k6za.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: amavisd-new at cs.umu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19256>

On Thu, Apr 27, 2006 at 03:07:37PM -0700, Junio C Hamano wrote:

...

> +int cmd_count_objects(int ac, const char **av, char *ep)
                                                       ^
...

> +extern int cmd_count_objects(int argc, const char **argv, char **envp);
                                                                  ^^
Looks like we have a type mismatch here, no?

	Peter
