From: Junio C Hamano <junkio@cox.net>
Subject: Re: git push to a non-bare repository
Date: Mon, 19 Mar 2007 17:54:01 -0700
Message-ID: <7vk5xcd9au.fsf@assigned-by-dhcp.cox.net>
References: <vpq648ye9w6.fsf@olympe.imag.fr>
	<20070319020053.GA11371@thunk.org>
	<7vr6rmm1y9.fsf@assigned-by-dhcp.cox.net>
	<20070319022143.GF20658@spearce.org>
	<20070319024744.GD11371@thunk.org>
	<20070319025603.GG20658@spearce.org>
	<20070319032130.GF11371@thunk.org>
	<20070319035351.GI20658@spearce.org> <45FF2393.6070700@vilain.net>
	<7vodmod9id.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Theodore Tso <tytso@mit.edu>, git <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Mar 20 01:54:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTSc5-0001bQ-MF
	for gcvg-git@gmane.org; Tue, 20 Mar 2007 01:54:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966061AbXCTAyF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 20:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966062AbXCTAyF
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 20:54:05 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:41294 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966061AbXCTAyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 20:54:03 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070320005402.JJTY28911.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 20:54:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cou11W00Q1kojtg0000000; Mon, 19 Mar 2007 20:54:01 -0400
In-Reply-To: <7vodmod9id.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 19 Mar 2007 17:49:30 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42686>

Junio C Hamano <junkio@cox.net> writes:

> However, sometimes I accidentally leave 'next' checked out.  If
> I find out that I left non 'master' checked out, I would do "git
> reset --hard HEAD" before doing anything else, and I do not want
> my push to sometimes result in detached HEAD and sometimes not.
> I do not want to lose the information which branch I was on last
> (because the next thing I would do is on which branch Meta/Doit

s/do is on/do is to find out on/;

> failed).  If I _were_ annoyed enough by sometimes mistakenly
> pushing into the live branch, I would switch to separate remote
> layout and push into remotes/origin/* hierarchy, and there will
> be truly nothing to worry about after that point.
