From: Adam Spiers <git@adamspiers.org>
Subject: Re: questions / suggestions about history simplification
Date: Thu, 19 Dec 2013 21:04:48 +0000
Message-ID: <20131219210448.GK23496@pacific.linksys.moosehall>
References: <20131219183645.GD23496@pacific.linksys.moosehall>
 <20131219190333.GE23496@pacific.linksys.moosehall>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 19 22:04:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vtkm6-0001uw-Og
	for gcvg-git-2@plane.gmane.org; Thu, 19 Dec 2013 22:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756184Ab3LSVEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 16:04:50 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:46008 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754956Ab3LSVEu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Dec 2013 16:04:50 -0500
Received: from localhost (243.103.2.81.in-addr.arpa [81.2.103.243])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 696F92E30D
	for <git@vger.kernel.org>; Thu, 19 Dec 2013 21:04:49 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20131219190333.GE23496@pacific.linksys.moosehall>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239548>

On Thu, Dec 19, 2013 at 07:03:33PM +0000, Adam Spiers wrote:
> I still don't understand a few things about history simplification:
> 
> 1. The "--full-history without parent rewriting" correctly asserts
>    that commit Q will be shown.  But AFAICS this contradicts the
>    documented behaviour "Commits are included if they are not TREESAME
>    to any parent" which is implied by "This mode differs from the
>    default in one point:", because Q is TREESAME to P.

I'm *guessing* that this apparent exception to the stated rules could
be because Q is the start of the walk.  Or maybe I'm just missing a
key detail.  I'd love to hear confirmation either way.

[Questions 2 and 3 snipped]

4. --dense (the default behaviour) includes walked commits iff they are not
   TREESAME to any parent.  --sparse includes all walked commits.  But
   how do I get the middle ground, i.e. all walked commits which are
   not TREESAME to at least one parent?

This seems like an obvious use case, but I haven't figured out how to
do it yet :-/

Thanks!  (I probably don't say that often enough, but the sentiment is
always there ;-)
