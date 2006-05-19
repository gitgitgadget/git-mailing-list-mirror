From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] Implement git-quiltimport (take 2)
Date: Fri, 19 May 2006 03:55:49 -0600
Message-ID: <m164k21gpm.fsf@ebiederm.dsl.xmission.com>
References: <m1k68l6hga.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605161001190.3866@g5.osdl.org>
	<m1bqtx6el6.fsf@ebiederm.dsl.xmission.com>
	<7vbqtxaj5k.fsf@assigned-by-dhcp.cox.net>
	<m13bf95ixo.fsf@ebiederm.dsl.xmission.com>
	<7v1wut2p5z.fsf@assigned-by-dhcp.cox.net>
	<m1bqtw4hk7.fsf_-_@ebiederm.dsl.xmission.com>
	<7vsln8cwn6.fsf@assigned-by-dhcp.cox.net>
	<m1zmhg31cm.fsf@ebiederm.dsl.xmission.com>
	<7vy7x09qet.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 19 11:56:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fh1iq-0007FP-PX
	for gcvg-git@gmane.org; Fri, 19 May 2006 11:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWESJ4c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 05:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWESJ4c
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 05:56:32 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38568 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751331AbWESJ4b (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 May 2006 05:56:31 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4J9torV004728;
	Fri, 19 May 2006 03:55:50 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4J9toiZ004727;
	Fri, 19 May 2006 03:55:50 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7x09qet.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Wed, 17 May 2006 16:34:34 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20344>

Junio C Hamano <junkio@cox.net> writes:

>> For Andrews tree before I play anymore with technical solutions I
>> need to talk to Andrew and see if we can improve the situation
>> upstream.  Possibly with a quilt-audit script that finds problem
>> patches.
>
> Yes, that sounds very sensible.

Anyway I had a first pass conversation with Andrew and it looks like
he will start addressing the problem patches there.  So things
should be resolvable.

The final piece on my agenda for getting the proper authors from
the -mm tree is coping with Andrew's git patches.  They have enough
information to determine the Author but they are really several
different patches.  Ideally I will be able recognize they are
performing a pull from a git repository and get the same results.

Otherwise some other trick will be necessary.

Eric
