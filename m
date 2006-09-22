From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: git commands that only work correctly at top directory
Date: Fri, 22 Sep 2006 13:26:15 +0200
Message-ID: <20060922112615.GB10124@moooo.ath.cx>
References: <fcaeb9bf0609220221w3a65af24u9db1da4e1be0d1eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 22 13:26:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQjAz-0003vk-Ob
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 13:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWIVL0S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 07:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbWIVL0S
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 07:26:18 -0400
Received: from moooo.ath.cx ([85.116.203.178]:59816 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750932AbWIVL0R (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Sep 2006 07:26:17 -0400
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0609220221w3a65af24u9db1da4e1be0d1eb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27527>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Here is the list (checks are done in with 1.4.2.rc4):
> count-objects (always 0 objects, 0 kilobytes)
> bisect (fatal: Not a git repository: '.git'. Bad HEAD - I need a symbolic 
> ref)
> describe (fatal: Not a valid object name HEAD)
> repack (line 42: cd: .git/objects/pack: No such file or directory. And
> it creates a new .git directory in current directory)
count-objects and describe work in the current master.
repack/bisect/reset and some other commands make only sense from the
toplevel directory but anyway I would allow them to be run in a
subdirectory and change up to the topdirectory (like git checkout for
branch switching).  Is there any good reason not to do this?  I found
it often annoying to go down to the toplevel directory/get a new shell
just to reset to HEAD~1.
