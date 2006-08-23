From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] adding support for md5
Date: Tue, 22 Aug 2006 21:46:08 -0700
Message-ID: <7v3bbojbzj.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0608172259280.25827@chino.corp.google.com>
	<Pine.LNX.4.64.0608191339010.11811@g5.osdl.org>
	<20060821204430.GA2700@tuatara.stupidest.org>
	<7vr6z9s376.fsf@assigned-by-dhcp.cox.net>
	<20060823041453.GA25796@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 06:46:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFkd4-0006LK-AK
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 06:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932353AbWHWEqL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 00:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbWHWEqL
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 00:46:11 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:168 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932353AbWHWEqK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 00:46:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060823044609.GCWU29796.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 23 Aug 2006 00:46:09 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060823041453.GA25796@spearce.org> (Shawn Pearce's message of
	"Wed, 23 Aug 2006 00:14:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25895>

Shawn Pearce <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> I personally am not interested in making this configurable at
>> all.  The hashcmp() change on the other hand to abstract out 20
>> was a good preparation, if we ever want to switch to longer
>> hashes we would know where to look.
>
> What about all of those memcpy(a, b, 20)'s?  :-)

Surely.  If you are inclined to, go wild.

> I can see us wanting to support say SHA-128 or SHA-256 in a few
> years.  Especially as processors get faster and better attacks are
> developed against SHA-1 such that its no longer really the best
> trade-off hash function available.
