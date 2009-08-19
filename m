From: ib@wupperonline.de (Ingo Brueckl)
Subject: question concerning branches
Date: Wed, 19 Aug 2009 21:21:00 +0200
Message-ID: <4a8c4ece@wupperonline.de>
References: <7vr5v7vehj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 21:25:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdqmW-0008P7-E6
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 21:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752814AbZHSTZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 15:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752713AbZHSTZA
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 15:25:00 -0400
Received: from smtp.tal.de ([81.92.1.5]:34208 "EHLO smtp.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752694AbZHSTZA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 15:25:00 -0400
Received: from ib (i528C3684.versanet.de [82.140.54.132])
	by smtp.tal.de (Postfix) with SMTP id A2D31AB839D;
	Wed, 19 Aug 2009 21:22:36 +0200 (CEST)
X-Mailer: blueMail 1.4 (SlipDoor 2.2)
In-Reply-To: <7vr5v7vehj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126575>

Junio C Hamano <gitster@pobox.com> writes:

> This is one of the most useful features.

Wow. I'm sursprised to hear that, because I consider it at the moment as a
very strange one.

> For example, it is an essential
> part of supporting the workflow described here:
>     http://gitster.livejournal.com/25892.html

Here is what I'd expect to do with git (described with my own words, not in
git commands):

1. commit the quick fix to the release branch
2. push this single commit to origin and master

Now that all branches have the commit a later push and pull should notice
this and "skip" it.

This leads to a second question I have. Assuming I have three patches in my
repo (#1, #2 and #3), is it possible to push only #2 (because it is a
quick fix) and later, maybe after I committed #4, the rest, i.e. #1, #2 and
#4?

Ingo
