From: Raphael Zimmerer <killekulla@rdrz.de>
Subject: Re: [PATCH] git grep: Add "-Z/--null" option as in GNU's grep.
Date: Wed, 1 Oct 2008 01:41:57 +0200
Message-ID: <20080930234157.GA1453@rdrz.de>
References: <1222816390-9141-1-git-send-email-killekulla@rdrz.de> <20080930231619.GR21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 01:43:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkosJ-0000td-LH
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 01:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753690AbYI3XmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 19:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754020AbYI3XmA
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 19:42:00 -0400
Received: from rdrz.de ([217.160.107.209]:42699 "HELO rdrz.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752156AbYI3Xl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 19:41:59 -0400
Received: (qmail 12902 invoked by uid 1009); 30 Sep 2008 23:41:57 -0000
Mail-Followup-To: "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080930231619.GR21310@spearce.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97170>

On Tue, Sep 30, 2008 at 04:16:19PM -0700, Shawn O. Pearce wrote:
> Elsewhere in Git we call this "-z", like "git ls-tree -z", "git
> log -z".  Should we match grep or git convention here?

I'd tend to grep's convention, as most options of git-grep mimic those
of grep. grep uses "-z" for \0 on _input_, so that would be very
confusing for grep users...

- Raphael
