From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-format-patch: Make the second and subsequent mails replies to the first
Date: Mon, 10 Jul 2006 22:25:08 +0200
Organization: At home
Message-ID: <e8ud22$jo1$1@sea.gmane.org>
References: <1152546266.8890.19.camel@josh-work.beaverton.ibm.com> <Pine.LNX.4.63.0607101801360.29667@wbgn013.biozentrum.uni-wuerzburg.de> <20060710162920.GR20191@harddisk-recovery.com> <1152549787.8890.36.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Jul 10 22:25:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G02Jc-0002do-P1
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 22:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422709AbWGJUZI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 16:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422802AbWGJUZI
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 16:25:08 -0400
Received: from main.gmane.org ([80.91.229.2]:35732 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1422709AbWGJUZG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Jul 2006 16:25:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1G02JC-0002ZI-O3
	for git@vger.kernel.org; Mon, 10 Jul 2006 22:24:46 +0200
Received: from host-81-190-19-52.torun.mm.pl ([81.190.19.52])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Jul 2006 22:24:46 +0200
Received: from jnareb by host-81-190-19-52.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 10 Jul 2006 22:24:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-19-52.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23648>

Josh Triplett wrote:

> On Mon, 2006-07-10 at 18:29 +0200, Erik Mouw wrote:
>> On Mon, Jul 10, 2006 at 06:01:48PM +0200, Johannes Schindelin wrote:
>> > please make that behaviour optional.
>> 
>> Rather make it consistent with git-send-email. Principle of least
>> surprise.
> 
> Well, git-send-email does not include an option to disable the threading
> headers, so consistency with git-send-email would imply not including
> any such option.  I can, however, implement a --no-thread option to omit
> the headers, as well as git-send-email's --in-reply-to option to set an
> initial In-Reply-To/References.  New patch series shortly.

git-send-email has three ways of sending files:
 1. Chain Reply-To:, where every patch refers to earlier in series.
    Ugly in threaded mail/news readers, harder to comment, but there is
    no way to loose the order (e.g. if patches are not numbered *blush*)
 2. No chain reply-to, with cover letter introducing patch series.
    IMHO nicest format... provided there are no errors nor mistakes.
 3. No chain reply-to, without cover letter. I presonally don't like 
    this format, YMMV.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
