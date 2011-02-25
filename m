From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [RFC/PATCH] commit notes workflow
Date: Fri, 25 Feb 2011 15:30:54 -0500
Message-ID: <1298665854.27129.25.camel@drew-northup.unet.maine.edu>
References: <20110225133056.GA1026@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 25 21:31:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt4Jn-0002lL-J1
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 21:31:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932981Ab1BYUbK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 15:31:10 -0500
Received: from beryl.its.maine.edu ([130.111.32.94]:59330 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932968Ab1BYUbI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 15:31:08 -0500
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p1PKUxSo021486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 25 Feb 2011 15:30:59 -0500
In-Reply-To: <20110225133056.GA1026@sigill.intra.peff.net>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=4 Fuz1=4
	Fuz2=4
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p1PKUxSo021486
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1299270661.21441@5wiGvvm+EdCaU35LM6caXg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167940>


On Fri, 2011-02-25 at 08:30 -0500, Jeff King wrote:
> I was revising a long-ish series today, and I have been wanting to start
> using "git notes" to store information on what's changed between
> versions (which will eventually go after the "---" in format-patch).


>   1. If we are amending, it populates the commit message not just with
>      the existing message, but also with a "---" divider and any notes on
>      the commit.
> 
>   2. After editing the commit message, it looks for the "---" divider
>      and puts everything after it into a commit note (whether or not it
>      put in a divider in step (1), so you can add new notes, too).
> 
> So your commit template looks like:
> 
>   subject
> 
>   commit message body
>   ---
>   notes data
> 
>   # usual template stuff
> 
> I'm curious what people think. Do others find this useful? Does it seem
> harmful?
> 

I'm in agreement with the others that it doesn't seem like a bad idea,
and likely a good one. Just one thing, can you add an end-of-note
delimiter (the same thing perhaps)? I didn't spend a long time looking
at the code, but I can imagine more than a few ways for this to go wrong
without one.

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
