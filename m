From: walt <wa1ter@myrealbox.com>
Subject: Re: [ANNOUNCE] GIT 0.99.9i aka 1.0rc2
Date: Tue, 15 Nov 2005 07:26:37 -0800
Organization: none
Message-ID: <Pine.LNX.4.64.0511150715390.17817@x2.ybpnyarg>
References: <7vr79isfy9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 16:41:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec2oT-0000dB-OM
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 16:33:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbVKOPd3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 10:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVKOPd3
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 10:33:29 -0500
Received: from main.gmane.org ([80.91.229.2]:31444 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932544AbVKOPd2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 10:33:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ec2jR-00075H-FR
	for git@vger.kernel.org; Tue, 15 Nov 2005 16:28:25 +0100
Received: from adsl-69-234-227-15.dsl.irvnca.pacbell.net ([69.234.227.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Nov 2005 16:28:25 +0100
Received: from wa1ter by adsl-69-234-227-15.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 15 Nov 2005 16:28:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-227-15.dsl.irvnca.pacbell.net
In-Reply-To: <7vr79isfy9.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11908>



On Mon, 14 Nov 2005, Junio C Hamano wrote:

> GIT 0.99.9i aka 1.0rc2 is found at usual places.
>
> I think the source-tree-wise almost everything is done except:
>
>  - http-fetch file descriptor leak fix; I tried Nick's
>    clean-ups, but haven't tried Pasky's patch yet.  Walt reports
>    neither patch fixed the problem.  I wasted the weekend not
>    being able to reproduce this myself, until Pasky reminded me
>    that I have an old special code in git-clone, which was
>    unrelated to this problem, but nevertheless was masking it.

So, you're saying that you have *not* fixed it?  Hm.  Using the
up-to-the-minute repository versions of cogito and git I can now
do a successful clone of the git repository with ulimit -n 64,
which I couldn't do two days ago.  When I get home I'll try it
again on NetBSD also.
