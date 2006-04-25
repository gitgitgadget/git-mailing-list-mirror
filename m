From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: Re: [PATCH 3/4] Deprecate usage of git-var -l for getting config vars list
Date: Tue, 25 Apr 2006 10:39:18 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060425083918.GB1663@informatik.uni-freiburg.de>
References: <20060424225925.14086.97825.stgit@machine.or.cz> <20060424225930.14086.76174.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 25 10:39:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FYJ4u-0005as-Ip
	for gcvg-git@gmane.org; Tue, 25 Apr 2006 10:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbWDYIjV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 25 Apr 2006 04:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWDYIjV
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Apr 2006 04:39:21 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:6850 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1751445AbWDYIjU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Apr 2006 04:39:20 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1FYJ4o-0001lj-TQ; Tue, 25 Apr 2006 10:39:19 +0200
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.11.7p2+Sun/8.12.11) id k3P8dId03155;
	Tue, 25 Apr 2006 10:39:18 +0200 (MEST)
To: Petr Baudis <pasky@suse.cz>
Mail-Followup-To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>,
	Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060424225930.14086.76174.stgit@machine.or.cz>
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19138>

Hello Petr,

Petr Baudis wrote:
> +    my @gitvars = `git-repo-config -l`;
>      if ($?) {
> -       print "E problems executing git-var on the server -- this is not a git repository or the PATH is not set correcly.\n";
> +       print "E problems executing git-repo-config on the server -- this is not a git repository or the PATH is not set correcly.\n";

I didn't check the patch, but you may want to s/correcly/correctly/.

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=5+choose+3
