From: Andrew Ruder <andy@aeruder.net>
Subject: Re: Cloning into an existing directory
Date: Mon, 16 Feb 2009 09:48:08 -0700
Message-ID: <a030d93b0902160848x1c0521c3jb5ed2f1bf865a097@mail.gmail.com>
References: <e38bce640902152310x195a14e5p445817bdfc6e319f@mail.gmail.com>
	 <c1b8b6670902152331p9bbdb8fo7bf7048039b5301c@mail.gmail.com>
	 <e38bce640902160813u2771d55co3eb583a0922c09c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Brent Goodrick <bgoodr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 17:49:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ6f4-0005w7-U5
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 17:49:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbZBPQsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 11:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbZBPQsL
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 11:48:11 -0500
Received: from mail-gx0-f222.google.com ([209.85.217.222]:36169 "EHLO
	mail-gx0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbZBPQsK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 11:48:10 -0500
Received: by gxk22 with SMTP id 22so3173560gxk.13
        for <git@vger.kernel.org>; Mon, 16 Feb 2009 08:48:09 -0800 (PST)
Received: by 10.90.93.17 with SMTP id q17mr1331695agb.59.1234802888845; Mon, 
	16 Feb 2009 08:48:08 -0800 (PST)
In-Reply-To: <e38bce640902160813u2771d55co3eb583a0922c09c5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110209>

On Mon, Feb 16, 2009 at 9:13 AM, Brent Goodrick <bgoodr@gmail.com> wrote:
> 1. Move aside each file it complains about
> 2. Run the git-checkout command again
> 3. Move each file back to their original names, thus creating a local
> edit w.r.t. git

Actually, on my git (1.6.0.4) this just magically works due to the
fact that 'git init' sets up the repository with HEAD pointing to
refs/heads/master (which doesn't exist yet) and you go ahead and
create the master branch with the 'git branch' command.

In other words, in this particular situation the 'git checkout'
command is completely unnecessary and if you just run a 'git status'
you should already see that git sees all the differences already as
local edits (assuming you didn't call you branch in the 'git branch'
step something other than master).

-- 
Andrew Ruder <andy@aeruder.net>
http://www.aeruder.net
