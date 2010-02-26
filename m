From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: support user-supplied completion scripts for
	user's git commands
Date: Fri, 26 Feb 2010 12:17:43 -0800
Message-ID: <20100226201743.GB24776@spearce.org>
References: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com> <20100129151127.GA21821@spearce.org> <7v4om4kdt3.fsf@alter.siamese.dyndns.org> <20100129175950.GE21821@spearce.org> <7vockciyb8.fsf@alter.siamese.dyndns.org> <20100129190642.GA31303@neumann> <7viqakireb.fsf@alter.siamese.dyndns.org> <20100226152710.GA17460@neumann> <7vmxyvsqzn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER G??bor <szeder@ira.uka.de>,
	David Rhodes Clymer <david@zettazebra.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 21:17:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nl6dE-0007nu-Sw
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 21:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965992Ab0BZURr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2010 15:17:47 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35502 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965970Ab0BZURq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2010 15:17:46 -0500
Received: by gyh20 with SMTP id 20so235859gyh.19
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 12:17:46 -0800 (PST)
Received: by 10.150.193.3 with SMTP id q3mr1498587ybf.221.1267215466043;
        Fri, 26 Feb 2010 12:17:46 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 7sm151248yxg.32.2010.02.26.12.17.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 26 Feb 2010 12:17:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vmxyvsqzn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141146>

Junio C Hamano <gitster@pobox.com> wrote:
> > ...  BTW, Mercurial's
> > completion script uses _hg_cmd_foo() for hg commands and
> > _hg_ext_bar() for extensions, so we might as well be a bit consistent,
> > and call our completion functions _git_cmd_foo().
> 
> In Hg's context it might make sense to name a function _hg_cmd_foo vs
> _hg_ext_bar iff the end users need to be very aware of the distinction
> between commands and extensions, but for us I think "git_cmd_foo" is
> probably the most meaningless rename, as it doesn't add any extra
> information (we know 'git foo' is a command already without 'cmd').

I agree.  _git_cmd_foo is pointless.

But I would be ok with _git_completion_foo for the completion
function of git foo.  As Junio pointed out, better to do it now
before users start to really build their own extension library on
top of the package.

-- 
Shawn.
