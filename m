From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: Plans to put together an Info manual?
Date: Thu, 08 Jan 2009 19:09:35 +0200
Message-ID: <87vdspk9m8.fsf@iki.fi>
References: <c115fd3c0901080747p4dd1233fla2f877f39ffa9806@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tim Visher" <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 18:11:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKyPQ-0006L0-BF
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 18:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758727AbZAHRJk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 12:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758495AbZAHRJj
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 12:09:39 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:35758 "EHLO kirsi2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757621AbZAHRJi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 12:09:38 -0500
Received: from mithlond.arda.local (80.220.180.181) by kirsi2.inet.fi (8.5.014)
        id 48FC5B890379553C; Thu, 8 Jan 2009 19:09:36 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.69)
	(envelope-from <tlikonen@iki.fi>)
	id 1LKyNz-0005Bv-D1; Thu, 08 Jan 2009 19:09:35 +0200
In-Reply-To: <c115fd3c0901080747p4dd1233fla2f877f39ffa9806@mail.gmail.com> (Tim Visher's message of "Thu\, 8 Jan 2009 10\:47\:20 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104943>

Tim Visher (2009-01-08 10:47 -0500) wrote:

> I wast just wondering A) If there is an info manual for Git, B) If
> there isn't, is one planned?

There is already something that _can_ be called "info manual for Git".
It's basically info version of Git User's Manual:

    http://www.kernel.org/pub/software/scm/git/docs/user-manual.html

Regular man pages are also available in info format.

The info manuals are not written in native info format, though. They are
generated from the asciidoc markup files, through xml format. There are
some problems with typesetting as some characters simply disappear in
the "asciidoc -> xml -> texi -> info" conversion. Two dashes (--) turn
into one (-), for example. But if you are not too demanding the info
manuals are quite usable. You can compile them with "make info" command.
