From: Chris Webb <chris@arachsys.com>
Subject: Re: Using git commit --amend on a commit with an empty message
Date: Mon, 9 Jul 2012 19:17:55 +0100
Message-ID: <20120709181754.GE23859@arachsys.com>
References: <20120709142437.GQ13885@arachsys.com>
 <7v7guclucl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 20:18:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SoIX7-00074b-Q4
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jul 2012 20:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511Ab2GISSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jul 2012 14:18:00 -0400
Received: from alpha.arachsys.com ([91.203.57.7]:38778 "EHLO
	alpha.arachsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498Ab2GISR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2012 14:17:59 -0400
Received: from [81.2.114.212] (helo=arachsys.com)
	by alpha.arachsys.com with esmtpa (Exim 4.72)
	(envelope-from <chris@arachsys.com>)
	id 1SoIX0-0004u6-5A; Mon, 09 Jul 2012 19:17:58 +0100
Content-Disposition: inline
In-Reply-To: <7v7guclucl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201214>

Junio C Hamano <gitster@pobox.com> writes:

> Yeah, it is a "bug" that exists only because nobody sane uses empty
> message commits, let alone tries to amend such commits, hence went
> unnoticed for a long time.

Quite. I only noticed it because this is the default behaviour of Github
gists and I wanted to replace the empty commit messages with more meaningful
ones.

> The patch looks sane; if we want to keep this as a feature or a
> bugfix, we may want to pretect it with a new test, though.

Yes, it's hardly something people will test often. Okay, I'll send a version
two with a suitable test.

Best wishes,

Chris.
