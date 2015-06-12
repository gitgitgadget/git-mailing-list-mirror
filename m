From: Alex Cornejo <acornejo@gmail.com>
Subject: Re: git init with template dir
Date: Fri, 12 Jun 2015 15:59:51 +0000 (UTC)
Message-ID: <loom.20150612T175402-182@post.gmane.org>
References: <loom.20150612T085835-977@post.gmane.org> <xmqqioatdk0z.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 12 18:00:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3RNP-0007bx-Ht
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 18:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754606AbbFLQAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 12:00:10 -0400
Received: from plane.gmane.org ([80.91.229.3]:40950 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753345AbbFLQAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 12:00:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Z3RNG-0007WU-Pu
	for git@vger.kernel.org; Fri, 12 Jun 2015 18:00:08 +0200
Received: from cpe-172-91-14-114.socal.res.rr.com ([172.91.14.114])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 18:00:06 +0200
Received: from acornejo by cpe-172-91-14-114.socal.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Jun 2015 18:00:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 172.91.14.114 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.124 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271494>

Junio C Hamano <gitster <at> pobox.com> writes:

> Hmmm, I do not seem to be able to do this, though.
> 
>         $ ln -s $HOME/g/share/git-core/templates /var/tmp/git-template
>         $ cd /var/tmp
> 	$ git init --template=/var/tmp/git-template new
>         $ find new/.git -type l
>         ... nothing ...

Thanks for your prompt response Juno.

That make sense. The fact that you were unable to reproduce this tells
me that there is probably something fishy/unexpected with the
environment in which I tried this (which is not too surprising, given
that I was doing it inside a linux container, inside a virtual machine,
where both of these were setup using a scripts which ultimately failed
after the git init step, due to the symlink behavior I described, but
most likely this is my own fault). I should have tried to reproduce this
on a clean slate before posting this question.

Thanks again,

Alex
