From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: RFC: grafts generalised
Date: Mon, 7 Jul 2008 08:59:33 +0200
Message-ID: <20080707065933.GB25877@cuci.nl>
References: <20080702143519.GA8391@cuci.nl> <m3lk0kfdo1.fsf@localhost.localdomain> <g4gb7a$ket$1@ger.gmane.org> <20080702174255.GB16235@cuci.nl> <4871B7A0.1090604@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Jul 07 09:00:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFki9-00011i-B8
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 09:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbYGGG7f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 02:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbYGGG7f
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 02:59:35 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:55619 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750858AbYGGG7f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 02:59:35 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id EFB7F5465; Mon,  7 Jul 2008 08:59:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4871B7A0.1090604@op5.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87589>

Andreas Ericsson wrote:
>Stephen R. van den Berg wrote:
>>of time.  I need something that can be changed at will, then viewed with
>>gitk a second later.

>A second later might be too much, but for the case where you need to
>add a patch in the middle (which I suspect is the most timeconsuming
>and tricky part at the moment), you might want to use a temporary
>branch checked out where you need to apply the patch, apply the patch
>and then rebase the rest of the history onto that new commit. Rebase
>is fairly quick (although not a one-second thing for 20k commits), so
>you'll get the time down quite a bit, I imagine.

Not really.
Rebase does two things:
a. Apply every patch/commit again, which takes too long for 20k commits.
b. Mess up carefully grafted parent/merge relationships.

Rebase is only suitable for short linear strands of commits.
The history I'm dealing with is neither short, nor linear.
-- 
Sincerely,
           Stephen R. van den Berg.

A truly wise man never plays leapfrog with a unicorn.
