From: walt <wa1ter@myrealbox.com>
Subject: Re: Problem with Linus's git repository?
Date: Wed, 27 Jun 2007 06:41:48 -0700
Organization: none
Message-ID: <Pine.LNX.4.64.0706270636140.7038@x2.ybpnyarg>
References: <f5r8q5$pbr$1@sea.gmane.org> <alpine.LFD.0.98.0706260935440.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 27 15:58:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Y2o-00074k-SZ
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 15:58:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752634AbXF0N6x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 09:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752644AbXF0N6x
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 09:58:53 -0400
Received: from main.gmane.org ([80.91.229.2]:50578 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752283AbXF0N6w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 09:58:52 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I3XvK-0002JG-VV
	for git@vger.kernel.org; Wed, 27 Jun 2007 15:51:11 +0200
Received: from adsl-69-234-208-182.dsl.irvnca.pacbell.net ([69.234.208.182])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Jun 2007 15:51:10 +0200
Received: from wa1ter by adsl-69-234-208-182.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 27 Jun 2007 15:51:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-208-182.dsl.irvnca.pacbell.net
In-Reply-To: <alpine.LFD.0.98.0706260935440.8675@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51044>



On Tue, 26 Jun 2007, Linus Torvalds wrote:

>
>
> On Tue, 26 Jun 2007, walt wrote:
> >
> > For two days I've been unable to pull from Linus's kernel
> > git repository.  The reason seems to be that HEAD is a
> > symlink to refs/heads/master, which appears to be missing.
>
> It's not missing, it's packed. I tend to re-pack after I make a release,
> and this time I did it after -rc6...

Sometime overnight this problem disappeared.  I haven't actually
tested this idea, but I have a hunch that your commit yesterday
of "Fix zero-object version-2 packs" is the reason.

If the problem recurs I'll follow up on it.

Thanks.
