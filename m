From: Thomas Pasch <thomas.pasch@jentro.com>
Subject: some questions
Date: Fri, 22 Aug 2008 09:31:13 +0200
Organization: Jentro Technologies GmbH
Message-ID: <48AE6B41.1070005@jentro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 09:46:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWRLO-0001un-83
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 09:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752019AbYHVHo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 03:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751453AbYHVHo6
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 03:44:58 -0400
Received: from mail2.infra.net ([212.89.96.7]:1925 "EHLO gamma.m.infra.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751611AbYHVHo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 03:44:58 -0400
X-Greylist: delayed 821 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Aug 2008 03:44:57 EDT
Received: from epsilon.m.infra.net (epsilon.m.infra.net [212.89.96.8])
	by gamma.m.infra.net (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m7M7VEMC029005
	for <git@vger.kernel.org>; Fri, 22 Aug 2008 09:31:14 +0200
Received: from [192.1.1.184] (u19-17.dsl.vianetworks.de [194.231.42.17])
	(authenticated bits=0)
	by epsilon.m.infra.net (8.13.4/8.13.4/Debian-3) with ESMTP id m7M7VD95018553
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Fri, 22 Aug 2008 09:31:14 +0200
User-Agent: Thunderbird 2.0.0.16 (X11/20080720)
X-Enigmail-Version: 0.95.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93266>

Hello,

I try to migrate our old cvs repo to git.
However, I still have to following questions
that I found difficult to answer with
the documentation.

- Is there a way to convert a indexVersion 1
  repo to indexVersion 2? (And vice versa?)

- Is there a way to find out if a repository
  is indexVersion 1 or indexVersion 2 (from
  the pack/index files)?

- http for git seems to be read-only/fetch.
  Would it be (theoretically) possible to
  support write/push (with WebDAV or so)?

- I do not fully understand the implication
  of 'git repack -a' (or 'git repack -A -d').
  Is this bad for remote repos that are used
  with http? (as '-a' is 'Especially useful when
  packing a repository that is used for private
  development and there is no need to worry about
  people fetching via dumb protocols from it').

- What would be the implication to mount the
  git repo with nts (or another remote fs).
  Is it save to use such a mounted repo from
  more than one computer?

Kind regards,

Thomas

-- 
