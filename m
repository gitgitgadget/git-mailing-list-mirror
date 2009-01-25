From: public_vi <public_vi@tut.by>
Subject: Re: [PATCH] git-svn: add --ignore-paths option for fetching
Date: Sun, 25 Jan 2009 18:29:08 +0200
Message-ID: <497C9354.5050902@tut.by>
References: <1232864842-8841-1-git-send-email-public_vi@tut.by> <200901251521.15591.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, normalperson@yhbt.net
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 25 17:31:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LR7t3-0003Sr-Iq
	for gcvg-git-2@gmane.org; Sun, 25 Jan 2009 17:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855AbZAYQ3l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 11:29:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753061AbZAYQ3l
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 11:29:41 -0500
Received: from mail.tut.by ([195.137.160.40]:41087 "EHLO speedy.tutby.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbZAYQ3k (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 11:29:40 -0500
Received: from [93.125.18.207] (account public_vi@tut.by HELO [93.125.18.207])
  by speedy.tutby.com (CommuniGate Pro SMTP 5.1.12)
  with ESMTPSA id 136460167; Sun, 25 Jan 2009 18:29:33 +0200
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <200901251521.15591.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107066>

It is useful for me, but I think I can be useful for others too.
May be it's better to make in inclusive, i.e. "--only-matching=<regex>"?
> This would be a good place to explain why this is useful, and (if
> applicable) why you chose to implement it the way you did.
>   

OK, fixing them.
> You put the --ignore-paths explanation in the middle of the
> --localtime documentation (the last paragraph quoted still talks about
> --localtime).
>   
> This is the first function in git-svn.perl using camelCase.  Consider
> sticking to the current style and spelling it is_path_ignored().
>
> You broke the symmetry here, while all other hunks just add an
> equivalent check to the existing in_dot_git().
>
> However, the latter makes me wonder if it would be cleaner to move the
> in_dot_git() test to isPathIgnored (er, is_path_ignored) too?
>   
