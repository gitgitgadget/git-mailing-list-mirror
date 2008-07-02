From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: RFC: grafts generalised
Date: Wed, 2 Jul 2008 20:10:21 +0200
Message-ID: <20080702181021.GD16235@cuci.nl>
References: <20080702143519.GA8391@cuci.nl> <37fcd2780807021019t76008bbfq265f8bf15f59c178@mail.gmail.com> <37fcd2780807021058r5ed820cfmdc98f98f36d5c8ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 20:11:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE6nY-0004vW-8U
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 20:11:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbYGBSKX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 14:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbYGBSKX
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 14:10:23 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:38635 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbYGBSKW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 14:10:22 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 6DEAD5465; Wed,  2 Jul 2008 20:10:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <37fcd2780807021058r5ed820cfmdc98f98f36d5c8ae@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87171>

Dmitry Potapov wrote:
>On second thought, it may be not necessary. You can extract an old commit
>object, edit it, put it into Git with a new SHA1, and then use the graft file to
>replace all references from an old to a new one. And you will be able to see
>changes immediately in gitk.

Hmmmm, interesting thought.  That just might solve my problem.
In that case, I will stick to extending git fsck to check grafts more
rigorously and fix git clone to *refrain* from looking at grafts.
If anyone still wants the extended format, I'd be willing to implement
it, but my immediate itch for it is gone.
-- 
Sincerely,
           Stephen R. van den Berg.

You are confused; but this is your normal state.
