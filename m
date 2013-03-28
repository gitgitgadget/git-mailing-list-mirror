From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: What's cooking in git.git (Mar 2013, #07; Tue, 26)
Date: Thu, 28 Mar 2013 09:00:17 +0100
Message-ID: <87ehf0uf72.fsf@linux-k42r.v.cablecom.net>
References: <7v620dss3j.fsf@alter.siamese.dyndns.org>
	<20130327203535.GA5220@sigill.intra.peff.net>
	<878v58worp.fsf@linux-k42r.v.cablecom.net>
	<7vy5d8jz0y.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"Matthew Blissett" <matt@blissett.me.uk>,
	David Aguilar <davvid@gmail.com>,
	"John Keeping" <john@keeping.me.uk>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 09:01:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UL7ld-0007I5-IJ
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 09:01:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513Ab3C1IA3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 04:00:29 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:54793 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753579Ab3C1IA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 04:00:26 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Thu, 28 Mar
 2013 09:00:21 +0100
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.209.32) by
 CAS22.d.ethz.ch (172.31.51.112) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Thu, 28 Mar 2013 09:00:21 +0100
In-Reply-To: <7vy5d8jz0y.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 27 Mar 2013 14:47:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.209.32]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219372>

Junio C Hamano <gitster@pobox.com> writes:

>> * tr/line-log (2013-03-23) 6 commits
>>  - Speed up log -L... -M
>>  - log -L: :pattern:file syntax to find by funcname
>>  - Implement line-history search (git log -L)
>>  - Export rewrite_parents() for 'log -L'
>>  - fixup
>>  - Refactor parse_loc
>>
>>  Rerolled; collides with nd/magic-pathspecs.
>
> Honestly I am not sure what to make of this one.  I'd say we should
> merge this down as-is to 'master', expecting that in some future we
> would fix "log --follow" to keep the refspecs per history traversal
> path, so that this can be more naturally reimplemented.  Objections?

I was really hoping for something like that to happen :-) but I need to
look into at least one segfault bug in the option parser, noticed by
Antoine Pelisse.  Expect a (final?) reroll soon.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
