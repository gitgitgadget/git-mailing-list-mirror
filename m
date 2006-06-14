From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff --cc broken in 1.4.0?
Date: Wed, 14 Jun 2006 13:32:46 -0700
Message-ID: <7vmzcfcwb5.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90606112132jaf33a25x5794a19db2a06d8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 22:32:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fqc2k-0003WJ-OP
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 22:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbWFNUcs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 16:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWFNUcs
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 16:32:48 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:32496 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932251AbWFNUcr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jun 2006 16:32:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060614203247.SFBH554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Jun 2006 16:32:47 -0400
To: "Martin Langhoff" <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90606112132jaf33a25x5794a19db2a06d8d@mail.gmail.com>
	(Martin Langhoff's message of "Mon, 12 Jun 2006 16:32:45 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21861>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> I was looking at some merges in gitk and lamenting the apparent loss
> of the nice two-sided diff we get with -cc, and now duting a slightly
> messy merge I did git-diff -cc only to get...

This not a regression that I know of in 1.4.0; mind showing the
stage 2 and 3 blobs and the file in the resolution result (I do
not need stage 1)?

One thing to note is that --cc does not show a hunk in which you
take only from one side.

>
> $ git-ls-files --unmerged
> 100644 f1d3843b2b2e42ba78adcf37da6440f0d321852e 1       local/version.php
> 100644 9352efa45cd25d9ad58df12b4ac241ac226a8ad4 2       local/version.php
> 100644 50da9b47903f6179f55a3f44290e7feaa08342f4 3       local/version.php
