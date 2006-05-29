From: Matthias Kestenholz <lists@spinlock.ch>
Subject: Re: gitk highlighting descendents/ancestors
Date: Mon, 29 May 2006 14:55:37 +0200
Message-ID: <20060529125537.GD4916@spinlock.ch>
References: <17530.60026.636981.60532@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 14:56:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkhIA-0008RL-82
	for gcvg-git@gmane.org; Mon, 29 May 2006 14:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbWE2M4M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 08:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWE2M4L
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 08:56:11 -0400
Received: from mail19.bluewin.ch ([195.186.18.65]:25235 "EHLO
	mail19.bluewin.ch") by vger.kernel.org with ESMTP id S1750785AbWE2M4L
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 08:56:11 -0400
Received: from spinlock.ch (81.62.55.56) by mail19.bluewin.ch (Bluewin 7.2.073)
        id 4461DA9100482378; Mon, 29 May 2006 12:55:38 +0000
Received: (nullmailer pid 17429 invoked by uid 1000);
	Mon, 29 May 2006 12:55:37 -0000
To: Paul Mackerras <paulus@samba.org>
Content-Disposition: inline
In-Reply-To: <17530.60026.636981.60532@cargo.ozlabs.ibm.com>
X-Editor: Vim http://www.vim.org/
X-Operating-System: GNU/Linux 2.6.17-rc4-g2f880b65 (i686)
X-GPG-Fingerprint: 249B 3CE7 E6AE 4A1F F24A  DC44 B546 3304 690B 13F9
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20947>

Hi,

* Paul Mackerras (paulus@samba.org) wrote:
> I have implemented a feature in gitk (on the "new" branch) where it
> can highlight the commits that are, or are not, descendents or
> ancestors of the selected commit.  For now it is invoked via a
> drop-down menu.  Does this look useful to people?
> 

Yes, this is very useful for me. I have a complicated history graph
because I manage the codebase for several websites with one git
repository. It gets very hard to follow the colored lines in gitk
when there are many merges of feature branches.

The most useful feature for me is probably the "ancestor" view; "not
ancestor" could also be interesting if I wanted to visualize which
feature branches were already merged and which are not.

Thanks,
Matthias
