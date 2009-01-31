From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Line diff fragments, custom colour markers and word
	change highlighting
Date: Sat, 31 Jan 2009 01:57:42 -0500
Message-ID: <20090131065742.GA3033@coredump.intra.peff.net>
References: <3f4fd2640901301244s34d94e0fka00ce2eb6f6bef48@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jan 31 07:59:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT9ow-0000Dt-OX
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 07:59:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbZAaG5q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 01:57:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbZAaG5p
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 01:57:45 -0500
Received: from peff.net ([208.65.91.99]:60967 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111AbZAaG5o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 01:57:44 -0500
Received: (qmail 10307 invoked by uid 107); 31 Jan 2009 06:57:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 31 Jan 2009 01:57:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Jan 2009 01:57:42 -0500
Content-Disposition: inline
In-Reply-To: <3f4fd2640901301244s34d94e0fka00ce2eb6f6bef48@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107907>

On Fri, Jan 30, 2009 at 08:44:26PM +0000, Reece Dunn wrote:

> At the moment, I am manually editing the output of git diff to produce
> the desired output. I intend on modifying git to get it to produce the
> output in a format that I am interested in so that I don't have to
> edit it by hand.

Have you considered writing an external diff driver (see the description
of GIT_EXTERNAL_DIFF in git(1))? That would be a good starting point for
experimenting if you want to use a totally different diff driver (but if
you are just making tweaks to git's diff code, then obviously that isn't
a good idea).

Your RFCs look more like tweaks, but I wonder if there isn't already a
good external tool for doing these sorts of non-line-oriented diffs.

-Peff
