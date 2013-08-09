From: Damien Robert <damien.olivier.robert+gmane@gmail.com>
Subject: Re: Remove old forgotten command: whatchanged
Date: Fri, 9 Aug 2013 00:04:09 +0000 (UTC)
Message-ID: <ku1blo$5so$1@ger.gmane.org>
References: <CALkWK0=zZKTwn7cdrJXsVXH-rF=xWMeD_z2XAOCnuaf2bK_h8Q@mail.gmail.com> <7v61vg9eht.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 09 02:04:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7aC3-0000Jt-1p
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 02:04:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966789Ab3HIAEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 20:04:31 -0400
Received: from plane.gmane.org ([80.91.229.3]:52792 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966505Ab3HIAEa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 20:04:30 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1V7aBw-0000FK-7v
	for git@vger.kernel.org; Fri, 09 Aug 2013 02:04:28 +0200
Received: from phare.normalesup.org ([129.199.129.80])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 02:04:28 +0200
Received: from damien.olivier.robert+gmane by phare.normalesup.org with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 09 Aug 2013 02:04:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: phare.normalesup.org
X-Newsreader: Flrn (0.9.20070704)
X-Start-date: Fri, 09 Aug 2013 01:55:07 +0200 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231952>

Junio C Hamano  wrote in message
<7v61vg9eht.fsf@alter.siamese.dyndns.org>:
> The "tutorial" was written in fairly early days of Git's history, in
> order to primarily help those who want to use the plumbing command
> to script their own Porcelain commands.  As it says at the very
> beginning, the end-user tutorial to use Git's Porcelain is
> gittutorial.txt and the user manual, not this document.

Yes, and even if it's old, it is a really well done tutorial to understand the
internals of git. I read it after gittutorial and gittutorial-2. It's just
that I was surprised to learn about this command, "much more powerful" than
git-log. To me it looked a lot like git log --raw, and I found git log -p
more useful, so I was wondering what I was missing until I read the source
to see that nowadays the two commands were mostly the same.

> The above section primarily explains the use of diff-tree and it was
> appropriate back when git-whatchanged was a script.  The intent of
> the whole document, not just this section, was to tickle the
> curiousity of the users and encourage them to see how the above
> "much more powerful" whatchanged was implemented by going to the
> source.

Well in this case you can say that the intent was successful since it made
me read the source code ;)
