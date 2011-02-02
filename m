From: "George Spelvin" <linux@horizon.com>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: 1 Feb 2011 21:29:09 -0500
Message-ID: <20110202022909.30644.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 02 03:29:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkSTB-0002mO-OB
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 03:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752540Ab1BBC3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 21:29:11 -0500
Received: from science.horizon.com ([71.41.210.146]:41853 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752393Ab1BBC3L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 21:29:11 -0500
Received: (qmail 30645 invoked by uid 1000); 1 Feb 2011 21:29:09 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165887>

For what it's worth, I don't see the "cleanup".

If it significantly reduced the size of the largest directory,
that would be a win.  But moving everything into src/ doesn't
do that.

If there's a way to divide the source into cohesive subunits, that
would be great.  A programmer could ignore whole subdirectories
when working on something.

But just moving the whole existing pile into a subdirectory "because
everyone else does it" is not a reason; that's superstition.

Having to type "src/" a lot more often is definitely a downside.

Heck, that's one thing I actively dislike about GNU autoconf conventions.

If there's a compelling reason to change, could someone please describe it?
