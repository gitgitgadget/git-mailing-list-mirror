From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] contrib/vim: change URL to point to the latest syntax files
Date: Tue, 13 Jan 2009 09:54:50 +0200
Message-ID: <8763kjej3p.fsf@iki.fi>
References: <200901130310.26727.markus.heidelberg@web.de>
	<20090113071623.GB12631@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Heidelberg <markus.heidelberg@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 13 08:56:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMe8M-0000xK-Fr
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 08:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752652AbZAMHzA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 02:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbZAMHy6
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 02:54:58 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:39899 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752531AbZAMHy6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 02:54:58 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 48FC5B8903A716D5; Tue, 13 Jan 2009 09:54:52 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LMe6s-0002sU-DT; Tue, 13 Jan 2009 09:54:50 +0200
In-Reply-To: <20090113071623.GB12631@coredump.intra.peff.net> (Jeff King's message of "Tue\, 13 Jan 2009 02\:16\:24 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105466>

Jeff King (2009-01-13 02:16 -0500) wrote:

> On Tue, Jan 13, 2009 at 03:10:26AM +0100, Markus Heidelberg wrote:
>
>> Vim's SVN repository doesn't offer the latest runtime files, since
>> normally they are only updated there on a release. Though currently
>> there is no difference between the SVN and HTTP/FTP version of the
>> git syntax files.
>
> So their version control _doesn't_ have the latest version, but it is
> available on the website? It's not that I don't believe you, but I
> don't think I want to know the version control workflow that leads to
> that.

Vim is essentially just a one-man project and the maintainer doesn't use
version control system. He just piles "diff -c" -type patches on top of
the previous release and sends them to vim-dev mailing list and to some
FTP site. Then other people try to maintain VCS repositories based on
the patches and resources that are available.

Vim's bus factor: 1
