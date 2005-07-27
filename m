From: "Kirby C. Bohling" <kbohling@birddog.com>
Subject: Re: [PATCH/RFC] "Recursive Make considered harmful"
Date: Wed, 27 Jul 2005 09:37:21 -0500
Message-ID: <20050727143720.GG7410@birddog.com>
References: <20050727083910.GG19290@mythryan2.michonline.com> <42E79946.2020309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 27 16:42:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dxn6p-0002R4-N5
	for gcvg-git@gmane.org; Wed, 27 Jul 2005 16:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVG0Olb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jul 2005 10:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVG0OjH
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 10:39:07 -0400
Received: from hermes.birddog.com ([216.81.238.129]:54724 "EHLO
	hermes.birddog.com") by vger.kernel.org with ESMTP id S262279AbVG0OiD
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2005 10:38:03 -0400
Received: from hawk.birddog.com (hawk.birddog.com [10.15.4.100])
	by hermes.birddog.com (8.12.10/8.12.10) with ESMTP id j6REbRZP023705;
	Wed, 27 Jul 2005 09:37:29 -0500
Received: from hawk.birddog.com (localhost.localdomain [127.0.0.1])
	by hawk.birddog.com (8.12.11/8.12.11) with ESMTP id j6REbM0X010868;
	Wed, 27 Jul 2005 09:37:22 -0500
Received: (from kbohling@localhost)
	by hawk.birddog.com (8.12.11/8.12.11/Submit) id j6REbLwt010866;
	Wed, 27 Jul 2005 09:37:21 -0500
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <42E79946.2020309@gmail.com>
User-Agent: Mutt/1.4.1i
X-Scanned-By: MIMEDefang 2.15 (www dot roaringpenguin dot com slash mimedefang)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 27, 2005 at 10:25:10AM -0400, A Large Angry SCM wrote:
> Ryan Anderson wrote:
> >Convert build process from recurse Make to a single Make
> >
> 
> Please explain the rational for this.

I'm new to the list, but given the subject, I'm fairly confident
it's this.

http://www.canb.auug.org.au/~millerp/rmch/recu-make-cons-harm.html

I'm a convert.  I converted a fairly large code base at work, and it
was a huge boon for productivity.  Build times dropped dramatically
(from 40 seconds to 2-5 for a single file change).

He used the exact wording just about everyone dones when referring
to it conceptually.  It's easy to google for support and rebuttal:

http://www.google.com/search?hl=en&q=Recursive+Make+considered+harmful&btnG=Google+Search

    Thanks,
        Kirby
