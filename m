From: Kumar Appaiah <a.kumar@alumni.iitm.ac.in>
Subject: Re: [tig] Re: compilation error: undefined reference to
 `set_tabsize'
Date: Mon, 20 Sep 2010 18:05:59 -0500
Message-ID: <20100920230559.GJ23119@bowser.ece.utexas.edu>
References: <20100920174200.GA13017@vidovic>
 <loom.20100920T203217-346@post.gmane.org>
 <20100920204344.GB13017@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan =?iso-8859-1?Q?N=E4we?= <stefan.naewe@googlemail.com>,
	git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Sep 21 01:06:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxpR2-0006Kp-Qe
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 01:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731Ab0ITXGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Sep 2010 19:06:03 -0400
Received: from irongate.mail.utexas.edu ([146.6.25.6]:41491 "EHLO
	irongate.mail.utexas.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754703Ab0ITXGC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Sep 2010 19:06:02 -0400
X-IronPort-MID: 55927329
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAPOFl0yAU36S/2dsb2JhbACiIHHEe4VBBIROhWqEeA
Received: from wb7-a.mail.utexas.edu ([128.83.126.146])
  by irongate.mail.utexas.edu with ESMTP; 20 Sep 2010 18:06:01 -0500
Received: (qmail 42537 invoked from network); 20 Sep 2010 23:06:00 -0000
Received: from bowser.ece.utexas.edu (a.kumar@146.6.33.245)
  by wb7.mail.utexas.edu with (RC4-SHA encrypted) ESMTPSSA; 20 Sep 2010 23:06:00 -0000
Content-Disposition: inline
In-Reply-To: <20100920204344.GB13017@vidovic>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156676>

On Mon, Sep 20, 2010 at 10:43:44PM +0200, Nicolas Sebrecht wrote:
> > That change works for me on Cygwin, Ubuntu 10.04, Debian 5.0.6
> > 
> > Maybe you should say something about your system/OS version ?
> 
> Naturally. I'm running on Gentoo.
> 

Ack that this also breaks build on CentOS. The simple reason is that
the ncurses version on CentOS 5.5 is ncurses-5.5, while that on Debian
Lenny is 5.7+. According to the changelog, 5.6 onwards has
set_tabsize, so checking for that version of ncurses might be a good
option.

Thanks.

Kumar
