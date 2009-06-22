From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Mon, 22 Jun 2009 01:59:06 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrnh3tpb9.rhr.sitaramc@sitaramc.homelinux.net>
References: <19004.34350.109422.730109@cargo.ozlabs.ibm.com>
 <slrnh3ru9v.vgo.sitaramc@sitaramc.homelinux.net>
 <7v3a9uszzl.fsf@alter.siamese.dyndns.org>
 <20090622063405.6117@nanako3.lavabit.com>
 <7vtz29p3qm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 03:59:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIYoh-0005IX-6o
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 03:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbZFVB7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 21:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752305AbZFVB7R
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 21:59:17 -0400
Received: from main.gmane.org ([80.91.229.2]:44097 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752249AbZFVB7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 21:59:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MIYoX-0006MZ-JH
	for git@vger.kernel.org; Mon, 22 Jun 2009 01:59:17 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 01:59:17 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 22 Jun 2009 01:59:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122004>

On 2009-06-21 23:27:13, Junio C Hamano <gitster@pobox.com> wrote:

> If we wanted users of gitk to use it to detach HEAD, the current UI is not
> a good way to do so anyway --- it only allows detaching the tip of remote
> tracking branches and not an arbitrary commit.

Aaah -- excellent; wish I'd thought of it :-)  Thanks

> So I retract my earlier objection entirely.  I do not think the feature
> Sitaram is disabling was meant to allow detaching HEAD at all and it can
> be safely disabled for remote tracking branches to make the GUI experience
> safer.

Thanks.  I will resubmit to you and Paul again with the diff
header changed to suit his tree.

Regards,

Sitaram
