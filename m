From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: HTTP pushes
Date: Tue, 1 Nov 2005 16:59:57 -0800
Message-ID: <20051102005957.GB3928@reactrix.com>
References: <20051101020248.GA3928@reactrix.com> <Pine.LNX.4.63.0511012008310.11979@wbgn013.biozentrum.uni-wuerzburg.de> <7v1x1z51id.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 02 02:01:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX6zR-0000zP-2p
	for gcvg-git@gmane.org; Wed, 02 Nov 2005 02:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVKBBAY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 20:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbVKBBAY
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 20:00:24 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:18196 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S932117AbVKBBAX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2005 20:00:23 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jA20xwTE030293;
	Tue, 1 Nov 2005 16:59:58 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jA20xvRX030291;
	Tue, 1 Nov 2005 16:59:57 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1x1z51id.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10987>

On Tue, Nov 01, 2005 at 04:36:42PM -0800, Junio C Hamano wrote:

> I had an impression that DAV has its own notion of version
> control, so using git as a backend on the server side might be
> an interesting exercise.

There are versioning extensions to DAV, but they're not supported in all
implementations - for example, Apache's mod_dav only supports the
distributed authoring methods and that's what I've been testing with.
Pushing should work fine to a version-aware DAV server, although the
push should fail if the repository files are version-controlled (they
don't have to be, and it wouldn't make sense for them to be anyway.)

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
