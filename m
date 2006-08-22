From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] adding support for md5
Date: Mon, 21 Aug 2006 23:18:53 -0700
Message-ID: <7vr6z9s376.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
	<Pine.LNX.4.64.0608191339010.11811@g5.osdl.org>
	<20060821204430.GA2700@tuatara.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 22 08:18:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFPbG-0003wN-Ew
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 08:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWHVGSz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 02:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750840AbWHVGSz
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 02:18:55 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:55007 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750803AbWHVGSz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 02:18:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060822061854.ECIC18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 02:18:54 -0400
To: Chris Wedgwood <cw@f00f.org>
In-Reply-To: <20060821204430.GA2700@tuatara.stupidest.org> (Chris Wedgwood's
	message of "Mon, 21 Aug 2006 13:44:30 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25832>

Chris Wedgwood <cw@f00f.org> writes:

> On Sat, Aug 19, 2006 at 01:50:32PM -0700, Linus Torvalds wrote:
>
>> I can see the point of configurable hashes, but it would be for a
>> stronger hash than sha1, not for a (much) weaker one.
>
> Why any configuration option at all?  What in practice does it really
> buy?

I personally am not interested in making this configurable at
all.  The hashcmp() change on the other hand to abstract out 20
was a good preparation, if we ever want to switch to longer
hashes we would know where to look.
