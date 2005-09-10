From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE qgit-0.94]
Date: Sat, 10 Sep 2005 11:59:14 -0700
Message-ID: <7vmzmkhhq5.fsf@assigned-by-dhcp.cox.net>
References: <20050910171633.1179.qmail@web26303.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 10 21:00:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEAZm-0005Mu-H9
	for gcvg-git@gmane.org; Sat, 10 Sep 2005 20:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbVIJS7T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Sep 2005 14:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbVIJS7T
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Sep 2005 14:59:19 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:44236 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932214AbVIJS7T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2005 14:59:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050910185916.ZOIN18319.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Sep 2005 14:59:16 -0400
To: Marco Costalba <mcostalba@yahoo.it>
In-Reply-To: <20050910171633.1179.qmail@web26303.mail.ukl.yahoo.com> (Marco
	Costalba's message of "Sat, 10 Sep 2005 10:16:33 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8259>

Marco Costalba <mcostalba@yahoo.it> writes:

> But now there is also a git archive: 
> http://digilander.libero.it/mcostalba/qgit.git

You do not seem to have the following files there:

    ~mcostalba/qgit.git/info/refs
    ~mcostalba/qgit.git/objects/info/packs 

which explains why git-fetch and git-clone do not slurp from
there (they think the repository is broken).

These files are necessary if you publish your repository over
http for any serious use (i.e. other than only letting people
slurp from HEAD, known branches and/or tags, without allowing
discovery).  Especially on a site like digilander.libero.it/
which does not give directory index, peek into what branches
you have by looking in ~mcostalba/qgit.git/refs/ hierarchy would
not even work, and that is the reason why you need to have these
files to help the downloaders.
