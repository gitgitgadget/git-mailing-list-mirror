From: Stefan Naewe <stefan.naewe@googlemail.com>
Subject: Re: [tig] Re: compilation error: undefined reference to =?utf-8?b?YHNldF90YWJzaXplJw==?=
Date: Tue, 21 Sep 2010 06:37:50 +0000 (UTC)
Message-ID: <loom.20100921T083551-528@post.gmane.org>
References: <20100920174200.GA13017@vidovic> <loom.20100920T203217-346@post.gmane.org> <20100920204344.GB13017@vidovic> <20100920230559.GJ23119@bowser.ece.utexas.edu> <20100920231349.GK23119@bowser.ece.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 21 08:38:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OxwUl-0000he-Qo
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 08:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295Ab0IUGiU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 02:38:20 -0400
Received: from lo.gmane.org ([80.91.229.12]:46498 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754861Ab0IUGiG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 02:38:06 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1OxwUL-0000c6-3d
	for git@vger.kernel.org; Tue, 21 Sep 2010 08:38:01 +0200
Received: from lxsrv96.atlas.de ([194.156.172.86])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 08:38:01 +0200
Received: from stefan.naewe by lxsrv96.atlas.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 08:38:01 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 194.156.172.86 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/534.3 (KHTML, like Gecko) Chrome/6.0.472.62 Safari/534.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156691>

Kumar Appaiah <a.kumar <at> alumni.iitm.ac.in> writes:

> 
> On Mon, Sep 20, 2010 at 06:05:59PM -0500, Kumar Appaiah wrote:
> > Ack that this also breaks build on CentOS. The simple reason is that
> > the ncurses version on CentOS 5.5 is ncurses-5.5, while that on Debian
> > Lenny is 5.7+. According to the changelog, 5.6 onwards has
> > set_tabsize, so checking for that version of ncurses might be a good
> > option.
> 
> I have attached a patch which uses the patch number to determine this:
> 

Good. Works for me on Debian 5.0.6 and Cygwin.

Regards,

Stefan
