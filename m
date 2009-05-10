From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [RESEND PATCH] git-svn testsuite: use standard configuration
	for Subversion tools
Date: Sat, 9 May 2009 18:17:16 -0700
Message-ID: <20090510011716.GA2114@dcvr.yhbt.net>
References: <BfKhGHDBpSzjNF/dt4ZDx88u9wI@BjOYljNjUB0FD+/Fw7pzaXMw/Hc> <7vfxfowugm.fsf@gitster.siamese.dyndns.org> <Z0zFdWIzyQzuBQjCf+Jk/nJtvIw@BjOYljNjUB0FD+/Fw7pzaXMw/Hc> <7viqkkv43t.fsf@gitster.siamese.dyndns.org> <GzXVCxlG1vigUEGxhNBLVXNYljM@AnOk+mYbmYVORDu5SWQWxomMUcc> <7vtz437m6r.fsf@alter.siamese.dyndns.org> <Lpio3mDQDlK3iIczVIH3OPF7/N0@psUvbB26hX94GoQd3C5ThNBxOp8> <toS3g/caDjln1k7lKlVDYehlCbQ@psUvbB26hX94GoQd3C5ThNBxOp8>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eygene Ryabinkin <rea-git@codelabs.ru>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 10 03:21:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2xj8-00066J-7u
	for gcvg-git-2@gmane.org; Sun, 10 May 2009 03:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313AbZEJBRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 21:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754842AbZEJBRR
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 21:17:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:35936 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754237AbZEJBRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 21:17:16 -0400
Received: from localhost (unknown [127.0.2.5])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3400E1F7A1;
	Sun, 10 May 2009 01:17:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <toS3g/caDjln1k7lKlVDYehlCbQ@psUvbB26hX94GoQd3C5ThNBxOp8>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118696>

Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> I have tweaked configuration in my ~/.subversion directory, namely I am
> running auto-properties and automatically adding '$Id$' expansion to
> every file.  This choke the last test named 'proplist' from
> t9101-git-svn-props.sh, because one more property, svn:keywords is
> automatically added.
> 
> I had just wrapped svn invocation with the svn_cmd that specifies empty
> directory via --config-dir argument.  Since the latter is the global
> option, it should be recognized by all svn subcommands, so no
> regressions will be introduced.
> 
> Now svn_cmd is used everywhere, not just in the failed test module: this
> should guard us from the future clashes with user-defined configuration
> tweaks.
> 
> Signed-off-by: Eygene Ryabinkin <rea-git@codelabs.ru>

Thanks Eygene,

Acked-by: Eric Wong <normalperson@yhbt.net>
and pushed out to git://git.bogomips.org/git-svn.git

(There's an 'l' in my email address :)

-- 
Eric Wong
