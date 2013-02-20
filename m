From: Adam Spiers <git@adamspiers.org>
Subject: Re: Re* [PATCH 2/2] check-ignore.c: fix segfault with '.' argument
 from repo root
Date: Wed, 20 Feb 2013 02:00:46 +0000
Message-ID: <20130220020046.GC7860@pacific.linksys.moosehall>
References: <CAOkDyE_96Ef5CjoxNk3mbsNi+ZAuv6XeHcO7r8RQ-Of5ELsuKw@mail.gmail.com>
 <1361282783-1413-1-git-send-email-git@adamspiers.org>
 <1361282783-1413-2-git-send-email-git@adamspiers.org>
 <7v1ucc6vgd.fsf@alter.siamese.dyndns.org>
 <CAOkDyE9VVuFn6B=Fe4XHxGCEW0MFgndx1X0+9hO36Soxb37YQw@mail.gmail.com>
 <7v1ucc5b7n.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 20 03:01:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7yzg-0004AG-HC
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 03:01:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934197Ab3BTCAs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 21:00:48 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:33726 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933627Ab3BTCAr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 21:00:47 -0500
Received: from localhost (c.2.7.1.0.6.0.3.6.a.7.2.5.6.9.7.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:7965:27a6:3060:172c])
	by coral.adamspiers.org (Postfix) with ESMTPSA id C14B455AFA
	for <git@vger.kernel.org>; Wed, 20 Feb 2013 02:00:46 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7v1ucc5b7n.fsf_-_@alter.siamese.dyndns.org>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216673>

On Tue, Feb 19, 2013 at 11:56:44AM -0800, Junio C Hamano wrote:
> Adam Spiers <git@adamspiers.org> writes:
> 
> > Fair enough.  I'll reply to this with a new version.[0]
> >
> > [0] I wish there was a clean way to include the new version inline,
> >     but as I've noted before, there doesn't seem to be:
> >
> >     http://article.gmane.org/gmane.comp.version-control.git/146110
> 
> I find it easier to later find the patch if you made it a separate
> follow-up like you did, but you can do it this way if you really
> want to, using a scissors line, like so.  Please do not try to be
> creative and change the shape of scissors just for the sake of
> chaning it.

[snipped]

OK, thanks for the information.  IMHO it would be nice if 'git
format-patch' and 'git am' supported this style of inline patch
inclusion, but maybe there are good reasons to discourage it?
