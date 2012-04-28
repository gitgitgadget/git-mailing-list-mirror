From: username localhost <username.localhost@gmail.com>
Subject: Re: organizing multiple repositories with dependencies
Date: Sat, 28 Apr 2012 17:31:54 +0000 (UTC)
Message-ID: <loom.20120428T191337-86@post.gmane.org>
References: <1334568432.53977.YahooMailNeo@web65906.mail.ac4.yahoo.com> <m3hawjagw9.fsf@localhost.localdomain> <nng3983phhc.fsf@transit.us.cray.com> <CAE1pOi1KnvRk4yxK8OQHi9h_ueNnh5Ar3tbKFBKTA69=Aje0TQ@mail.gmail.com> <201204171837.q3HIbbcW013784@no.baka.org> <CAE1pOi29dKd2LHW7MJ+TTN4HzFkOPFEyf7Sf2emSsBYm93uYUA@mail.gmail.com> <nng1unmnksx.fsf@transit.us.cray.com> <4F8EB157.5060707@web.de> <nngbomh3uz0.fsf@transit.us.cray.com> <201204241759.q3OHxSbH017287@no.baka.org> <4F970C92.3030704@web.de> <nngobqg1ztl.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 28 19:35:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOBYi-0003Mj-DP
	for gcvg-git-2@plane.gmane.org; Sat, 28 Apr 2012 19:35:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127Ab2D1RfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Apr 2012 13:35:15 -0400
Received: from plane.gmane.org ([80.91.229.3]:58673 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752656Ab2D1RfO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2012 13:35:14 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SOBY0-0002k5-H8
	for git@vger.kernel.org; Sat, 28 Apr 2012 19:35:06 +0200
Received: from 76-243-42-111.lightspeed.cntmoh.sbcglobal.net ([76.243.42.111])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Apr 2012 19:35:04 +0200
Received: from username.localhost by 76-243-42-111.lightspeed.cntmoh.sbcglobal.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 28 Apr 2012 19:35:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 76.243.42.111 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20100101 Firefox/12.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196499>

dag writes:
> 
> Should gitslave be covered in this document if gitslave is not in the
> upstream git repository?  I'm not knocking gitslave, in fact I think
> it's cool technology and probably _should_ be contributed upstream.  I'm
> just asking the question about whether stuff in Documentation/ is or
> should be limited to things in the upstream repository.

I think that it would be better to be inclusive while initially writing such a
document. The work of helping to distinguish gitslave from the others should
also help to flesh out the differences between submodules and git-subtree.

Once the document is in good enough shape that it can be merged, it would be
easy enough to strip gitslave out if it were decided that it should not be
included. 


> 
> How about creating a topic branch for this and publishing it so several
> of us can collaborate?  I think that would make things a bit easier
> moving forward.

I second that. As a git user, I would love to see a document that described
these systems, explaining how they differ, showing how various "common" actions
are done in each, and describing the workflows each is best in, and what
workflows each does poorly with.

If somebody does not create a branch and post a starting point, I'm afraid this
idea will simply die out.

--
username@localhost
