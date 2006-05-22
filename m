From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] tutorial: expanded discussion of commit history
Date: Mon, 22 May 2006 01:45:11 -0700
Message-ID: <7vzmhacuso.fsf@assigned-by-dhcp.cox.net>
References: <1148255528.61d5d241.0@fieldses.org>
	<1148255528.61d5d241.1@fieldses.org> <e4rsef$v34$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 22 10:45:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fi62f-000780-Aw
	for gcvg-git@gmane.org; Mon, 22 May 2006 10:45:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWEVIpW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 May 2006 04:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750730AbWEVIpW
	(ORCPT <rfc822;git-outgoing>); Mon, 22 May 2006 04:45:22 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:56828 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750726AbWEVIpN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 May 2006 04:45:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060522084512.LOPT19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 May 2006 04:45:12 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20491>

Jakub Narebski <jnareb@gmail.com> writes:

> J. Bruce Fields wrote:
>
>> +Finally, most commands that take filenames will optionally allow you
>> +to precede any filename by a commit, to specify a particular version
>> +fo the file:
>> +
>> +-------------------------------------
>> +$ git diff v2.5:Makefile HEAD:Makefile.in
>> +-------------------------------------
>
> Why not mention also :<stage>:<filename>, or would <stage> be not defined in
> this place of tutorial?

I do not think being able to do diff with arbitrary stage is
often used in practice.  By definition, you would want to do
diff with a stage during a conflicted merge, and most of the
time the default combined diff without any colon form should
give you the most useful results.  Also, ":<path>" to mean the
entry in the index is often equivalent to "git diff --cached".

IOW, these are obscure special purpose notation, and I do not
think tutorial is a good place to cover them.
