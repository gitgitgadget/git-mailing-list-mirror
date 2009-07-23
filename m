From: Tim Harper <timcharper@gmail.com>
Subject: Re: Newbie: Branch management
Date: Wed, 22 Jul 2009 23:39:06 -0600
Message-ID: <e1a5e9a00907222239o1d75c163ia007a3cc370e31a3@mail.gmail.com>
References: <446739.83600.qm@web53410.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: "Dr. Jennifer Nussbaum" <bg271828@yahoo.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 07:39:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTr1i-00034l-S7
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 07:39:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210AbZGWFj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 01:39:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbZGWFj0
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 01:39:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:43618 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbZGWFjZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Jul 2009 01:39:25 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1391929rvb.5
        for <git@vger.kernel.org>; Wed, 22 Jul 2009 22:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Va4QN9jgE627G3AcYakl6ywHmtVsqwtl7C7G1wkrVGA=;
        b=Iptpg9+0heoINiMaRyP0lS/8OANBXAqZH9yOmMAqPi0PKuVDXf9UpU2IE9CVulXSFl
         etG7wwgWuonAuPRZE5wEr5LOlFJrxkM81EFmhto8V4+k8r30BSAqA8CwRa6Y0wRI4SSh
         M/EiUFYx57Lzd9Q9jThUsPWZSINMO+UVk4rTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Rmi6tSrgcEldN3QU/rmP+qis9OWdA8cQsnw7s5Ti9y1wuDPT3iwqER7UyYykgXKkn+
         swij0htG5UcqyEr/R0No13lkZFtcU+nmBL0Hn59GPPuXQr3P6NrtlezsMY/zHgrflfZK
         pW2znLSNxCSOHqsUmuF3TJ67/JrCzN36X8ibc=
Received: by 10.140.127.20 with SMTP id z20mr1170901rvc.186.1248327566049; 
	Wed, 22 Jul 2009 22:39:26 -0700 (PDT)
In-Reply-To: <446739.83600.qm@web53410.mail.re2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123844>

On Wed, Jul 22, 2009 at 2:41 PM, Dr. Jennifer
Nussbaum<bg271828@yahoo.com> wrote:
>
> Hi,
>
> I hope its OK to ask basic questions on this list.
>
> Im a recent convert to git and having trouble with branches. I mostly work on projects by myself, and what I want is that all branches of everything Im doing are in sync everywhere.
>
> I have a remote repository on my production server that serves as the "main" repository. Then i work on projects on a number of different computers--my main home computer, my main work machine, several non-main computers :-) ...
>
> I've found it very confusing dealing with branches in this environment. If I have my "master" branch, and decide that i want a "refactoring-templates" branch, what Id *like* to do is create that branch, work on it, commit it, and when I say "git push" I want everything that's new on that computer to be synced to the "main" repository. And then when I get to the next computer, I want to be able to say "git pull" and have everything on that computer by synced *from* the "main" repository.
>
> Instead I get confused by having to push branches separately, and it's confusing that when I do a pull it doesnt necessarily get other branches unless I specify them directly, and so on.
>
> I've looked at the docs on branches and there's something i guess Im missing because this still seems very difficult. Can someone giving me advice on the best way to keep this kind of thing organized?
>
> Thanks!
>
> Jen

I was turned off about this at first when I used git - I was in SVN
mode still and wanted all my local branches to be synchronized with
the remote repository.  A year and a half later, I'm glad that the
minds behind git didn't set out to make git like SVN!  I really think
this was the right decision.  For instance... if you pulled ALL of
your branches in one command... what if there were conflicts?  I doubt
you'd want to resolve them right then and there.

Anyways... 'git fetch' will download all the changes from the remote
repository.  From there, you can simply merge any remote branch
locally (ie, 'git merge origin/master' while in the master branch).

Enjoy the journey!

Tim
