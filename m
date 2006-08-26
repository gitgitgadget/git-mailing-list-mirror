From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 16/19] gitweb: Use git-diff-tree or git-diff patch output for blobdiff
Date: Sat, 26 Aug 2006 03:14:03 -0700
Message-ID: <7vpsen3itw.fsf@assigned-by-dhcp.cox.net>
References: <200608240015.15071.jnareb@gmail.com>
	<200608252113.34731.jnareb@gmail.com> <ecp3uq$k1f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 26 12:13:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGvAj-0000Ix-8C
	for gcvg-git@gmane.org; Sat, 26 Aug 2006 12:13:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWHZKNq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Aug 2006 06:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWHZKNq
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Aug 2006 06:13:46 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:16775 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751049AbWHZKNp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Aug 2006 06:13:45 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060826101344.ZJFQ554.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Sat, 26 Aug 2006 06:13:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id EaDj1V00y4Noztg0000000
	Sat, 26 Aug 2006 06:13:43 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ecp3uq$k1f$1@sea.gmane.org> (Jakub Narebski's message of "Sat,
	26 Aug 2006 11:23:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26043>

Jakub Narebski <jnareb@gmail.com> writes:

> Jakub Narebski wrote:
>
>> ATTENTION: The order of arguments (operands) to git-diff is reversed
>> (sic!) to have correct diff in the legacy (no hash_parent_base) case.
>> $hash_parent, $hash ordering is commented out, as it gives reversed
>> patch (at least for git version 1.4.1.1) as compared to output in new
>> scheme and output of older gitweb version.
>
> By the way, wa it corrected later? git version 1.4.1.1

I think you were involved in the thread that resulted in the 
fix...

53dd8a9 Show both blob names from "git diff blob1 blob2"
f82cd3c Fix "git diff blob1 blob2" showing the diff in reverse.
