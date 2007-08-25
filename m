From: "Wink Saville" <wink@saville.com>
Subject: Re: How-to setup an empty remote repository?
Date: Sat, 25 Aug 2007 15:45:44 -0700
Message-ID: <d4cf37a60708251545m7911e346m18fc183da48b4e63@mail.gmail.com>
References: <d4cf37a60708251400t17b0a097t91f77cbb4e996810@mail.gmail.com>
	 <20070825220629.GC1219@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Aug 26 00:46:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IP4OT-0006uL-Jr
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 00:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759736AbXHYWpv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 18:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759728AbXHYWpv
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 18:45:51 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:6438 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756263AbXHYWpv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 18:45:51 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1499995wah
        for <git@vger.kernel.org>; Sat, 25 Aug 2007 15:45:50 -0700 (PDT)
Received: by 10.114.106.1 with SMTP id e1mr1288371wac.1188081949437;
        Sat, 25 Aug 2007 15:45:49 -0700 (PDT)
Received: by 10.114.149.15 with HTTP; Sat, 25 Aug 2007 15:45:44 -0700 (PDT)
In-Reply-To: <20070825220629.GC1219@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56661>

On 8/25/07, Petr Baudis <pasky@suse.cz> wrote:
> On Sat, Aug 25, 2007 at 11:00:33PM CEST, Wink Saville wrote:
> > In the instructions I followed for setting up a remote repository,
> > http://www.kernel.org/pub/software/scm/git/docs/cvs-migration.html,
> > it uses an existing repository. So is it true you can't clone an
> > empty remote repository, or did I do something wrong?
>
> It is true that you can't clone it. "Cloning remote repository" means
> just "get all the remote branches and set them up locally". In empty
> repository there are no branches yet, so there's nothing to clone.
>
> I guess this should be covered in the FAQ (if it isn't already), it is
> one of the top questions repo.or.cz users have and I think I see it
> frequently on IRC as well.
>
> --

I didn't see it here, http://git.or.cz/gitwiki/GitFaq.

I would have expected it to setup an empty repository and then
populate it with 0 remote branches. Obviously, its a corner case
and maybe doesn't need addressing but if it is asked a lot then
maybe it should work that way.

Thanks,

Wink
