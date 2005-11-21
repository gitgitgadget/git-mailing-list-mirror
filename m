From: Luben Tuikov <ltuikov@yahoo.com>
Subject: [RFC] git-format-patch options
Date: Mon, 21 Nov 2005 08:25:40 -0800 (PST)
Message-ID: <20051121162540.4722.qmail@web31812.mail.mud.yahoo.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Mon Nov 21 17:32:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeEUC-0002M1-OP
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 17:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVKUQZn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 11:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVKUQZn
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 11:25:43 -0500
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:35212 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932382AbVKUQZm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 11:25:42 -0500
Received: (qmail 4724 invoked by uid 60001); 21 Nov 2005 16:25:40 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=b9YvPkrBEUt0NMzsEr8HXlXv4hEXWPjw6v/tRJ3yIKU6Bwn/M8pWkCdWoCHIqEC1Wk6UV2RFjRA+jrjvfNvEd9kyA5NK696FU39OvjhzUl2eQNGCONmeON3js+dGMN8y4tLGJvdkhONfy0hGtL+DPxkV4i9ZgiECepFyeeGHIYY=  ;
Received: from [68.221.112.229] by web31812.mail.mud.yahoo.com via HTTP; Mon, 21 Nov 2005 08:25:40 PST
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12454>

It is often the case that "since <mine> head forked from
<his> head" (quoting the manual page of git-format-patch),
for various projects, some patches have been accepted and
some have not.

I was wondering about the value of

  git-format-patch <commit-ish>

to output/prepare a diff patch between the indicated commit
and its parent.  As opposed to the current behaviour giving
all changes between the indicated commit and HEAD.

So in effect the form above would become the trivial:

  git-format-patch <commit-ish>..HEAD

and

  git-format-patch <commit-ish>

would give the diff patch between the indicated commit and
its parent.

?

    Luben
