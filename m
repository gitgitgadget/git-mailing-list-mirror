From: Sergei Organov <osv@javad.com>
Subject: Re: Plumbing to rename a ref?
Date: Fri, 23 May 2014 15:35:54 +0400
Message-ID: <87k39ck9r9.fsf@osv.gnss.ru>
References: <87ha4golck.fsf@osv.gnss.ru> <20140523105047.GA2249@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri May 23 13:36:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wnnla-0008Lo-5i
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 13:36:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752302AbaEWLf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 07:35:58 -0400
Received: from mail.javad.com ([54.86.164.124]:55700 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752073AbaEWLf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 07:35:57 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 3F899617FB;
	Fri, 23 May 2014 11:35:56 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <s.organov@javad.com>)
	id 1WnnlS-0007PK-J6; Fri, 23 May 2014 15:35:54 +0400
In-Reply-To: <20140523105047.GA2249@serenity.lan> (John Keeping's message of
	"Fri, 23 May 2014 11:50:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249986>

John Keeping <john@keeping.me.uk> writes:
> On Fri, May 23, 2014 at 02:11:55PM +0400, Sergei Organov wrote:
>> Hello,
>> 
>> After convertion of a project from CVS to git, I'd like to rename some
>> references in the created git repository (before it's published, so no
>> problems here). Is there a plumbing that would do:
>> 
>> git rename-ref <old_name> <new_name>
>> 
>> for me?
>
> I think the best you can get is two invocations of `git update-ref`:
>
> 	git update-ref <new_name> <old_name> &&
> 	git update-ref -d <old_name>

This should be good enough. Thanks a lot!

-- Sergey.
