From: Eric Blake <ebb9@byu.net>
Subject: Re: [PATCH] Re: configure: use =?utf-8?b?QUNfU0VBUkNIX0xJQlM=?= instead of =?utf-8?b?QUNfQ0hFQ0tfTElC?=
Date: Sun, 19 Jul 2009 22:53:16 +0000 (UTC)
Message-ID: <loom.20090719T225210-990@post.gmane.org>
References: <m34ot9c67t.fsf_-_@localhost.localdomain> <a52be8ba36206abc5ff5c91a759036a931e2658c.1248007036.git.nicolas.s.dev@gmx.fr> <20090719131404.GA11546@vidovic> <7v3a8szm4q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 20 00:55:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSfI4-000091-8l
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 00:55:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbZGSWxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 18:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbZGSWxf
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 18:53:35 -0400
Received: from main.gmane.org ([80.91.229.2]:42999 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751724AbZGSWxe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2009 18:53:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MSfG6-0001hB-Sx
	for git@vger.kernel.org; Sun, 19 Jul 2009 22:53:31 +0000
Received: from c-24-10-247-15.hsd1.ut.comcast.net ([c-24-10-247-15.hsd1.ut.comcast.net])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 19 Jul 2009 22:53:30 +0000
Received: from ebb9 by c-24-10-247-15.hsd1.ut.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 19 Jul 2009 22:53:30 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 24.10.247.15 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080702 Firefox/2.0.0.16 Mnenhy/0.7.5.666)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123563>

Junio C Hamano <gitster <at> pobox.com> writes:

> The autoconf documentation does not give much confidence either way:
> 
> 	AC_CHECK_LIB requires some care in usage, and should be avoided in
> 	some common cases.
> 
> It is unclear what these "some" are, and is sufficiently unclear for us to
> decide if our situation falls into these "some common cases."  The only
> problem it cites is that alternative libraries may contain a variant
> implementation of the same function found in a more common library, in
> which case you may not want to use such an alternative implementation, and
> I do not think "basename() in -lgen" falls into that category.

Please report that as a bug to the autoconf lists, then.

> If autoconf people say AC_SEARCH_LIBS() should be preferred over
> AC_CHECK_LIB(), it probably is the right thing to do.  But I want to have
> a warmer-and-fuzzier feeling that we understand why it went wrong, rather
> than blindly doing what the documentation says because the documentation
> tells us to.

As autoconf maintainer (and hoping to release autoconf 2.64 soon), yes, I can
definitively say that AC_SEARCH_LIBS is nicer than AC_CHECK_LIB.

-- 
Eric Blake
