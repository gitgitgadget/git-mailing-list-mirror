From: "Yakov Lerner" <iler.ml@gmail.com>
Subject: git todo-list ?
Date: Tue, 24 Apr 2007 01:44:08 +0300
Message-ID: <f36b08ee0704231544r53d1bfbej7ddee0c66d894f3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <junkio@cox.net>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 00:44:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg7Gk-0006vp-0b
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 00:44:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbXDWWoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 18:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754430AbXDWWoN
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 18:44:13 -0400
Received: from wx-out-0506.google.com ([66.249.82.231]:25823 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754431AbXDWWoM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 18:44:12 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1965798wxd
        for <git@vger.kernel.org>; Mon, 23 Apr 2007 15:44:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tpixEDp9D1pGPy4CBw04kxB6qcIuW8b39PRWAHVNEhGkVblxRzHZN51yim/wBiJ6mqgDba3aK75EVC5znJ5NPqT6nX5DlveVrfWMZIz7X8b7MuoM+pvj7ry9BQDZf05XC8pnT7LfU+oYMV+8FXB0uq9M3m7gacA9JKlOnhcom1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EhTvzYqLKIpmkwtNo1GTGghn1A2NYkxL6BJ9mYmrXLWMCX8FfDCY9FeERnCOzmpixEyMxJaa2/aN1tZ2mMxeDsF3tJ0zEp5gMNDVVVFAFVAsl28i9CrO8xkYYBTjCyM9rMh4/vgOttjgLYekrvqzijQtnfwE3wBwRESrIcxRrOI=
Received: by 10.90.118.12 with SMTP id q12mr1469776agc.1177368248647;
        Mon, 23 Apr 2007 15:44:08 -0700 (PDT)
Received: by 10.90.73.8 with HTTP; Mon, 23 Apr 2007 15:44:08 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45374>

Junio C Hamano wrote:
> In earlier days, people
> complained about lack of features and existence of misfeatures,
> and bashed the maintainer with patches.  These days, the bashing
> is done with more words and less patches.

I wonder if git has a "git-todo" page somewhere, either in its docs,
on on web somewhere.

The reason I ask about "git-todo" is becase I contributed couple of
patches to vim in the past, and that's because vim has the todo-page
(vim->:help todo).
So when I had free cycles, I looked into vim-todo, picked an item that I
could do, wrote a pacth, and sent it in. (Only the main maintainer of vim
puts things into todo list).

In the earlier days, omissions were seen on surface. Now that git
matured, things to add or fix are not obvious. The todo doc is great place
to have requested-fixes/wishes recorded. That's because those people who
hit the problems do not necessarily have time/desire to fix them, and someone
who has free cycles to write code might not hit himself the problem
that others hit.

Another usefulness [of todo doc] is that it allows to clearly label
'not implemented yet, but it is in the todo' things (for example --
ability to keep empty dirs in the tree).

The todo list works by giving directions to those who have time to
write patches.

Does git have todo-list ?

Yakov
