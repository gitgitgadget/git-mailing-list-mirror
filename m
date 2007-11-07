From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in git, help users out.
Date: Wed, 07 Nov 2007 10:03:36 +0100
Message-ID: <868x5afmvr.fsf@lola.quinscape.zz>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org> <200711062106.57083.robin.rosenberg.lists@dewire.com> <20071106201324.GA30262@glandium.org> <200711062221.58475.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.64.0711062225090.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 07 10:04:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipgpr-0003bE-21
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 10:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756928AbXKGJD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 04:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756447AbXKGJD5
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 04:03:57 -0500
Received: from main.gmane.org ([80.91.229.2]:56729 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756695AbXKGJDz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 04:03:55 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ipgp7-0006Wy-RI
	for git@vger.kernel.org; Wed, 07 Nov 2007 09:03:45 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 09:03:45 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 Nov 2007 09:03:45 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:jxnv1lwhOGCnepTCYKTK6ZJHr/g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63791>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 6 Nov 2007, Robin Rosenberg wrote:
>
>> tisdag 06 november 2007 skrev Mike Hommey:
>> > Maybe the documentation could emphasise on how to undo things when the
>> > user makes mistakes.
>> > Sometimes, saving your repo can be as simple as git reset --hard HEAD@{1}.
>> > This is not, unfortunately, a works-for-all-cases command.
>> 
>> Yea, git-undo(7). 
>
> In related news, I know a few users who need an un-rm-rf.  Anyone?

Most file systems don't have a reflog or other ways to recover from
shooting yourself in the foot.  git has, and for good reason.

There is no sense in hiding that facility away because of feeling
macho.  Since git already keeps the file space around needed for
recovery (and you really have to exert yourself to make it let go for
good), there is no point in not making it as convenient as feasible to
recover.

-- 
David Kastrup
