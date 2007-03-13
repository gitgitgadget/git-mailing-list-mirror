From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] Replace fork_with_pipe in bundle with run_command
Date: Mon, 12 Mar 2007 17:54:42 -0700
Message-ID: <7v3b4aotd9.fsf@assigned-by-dhcp.cox.net>
References: <20070312183815.GD15996@spearce.org>
	<7vslcaow13.fsf@assigned-by-dhcp.cox.net>
	<20070313003646.GA17169@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Mar 13 01:55:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQvI3-0001Ny-6P
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 01:54:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752535AbXCMAyp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 20:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752548AbXCMAyo
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 20:54:44 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:63366 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752535AbXCMAyn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 20:54:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070313005443.ZHOB748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 12 Mar 2007 20:54:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id a0ui1W0021kojtg0000000; Mon, 12 Mar 2007 20:54:42 -0400
In-Reply-To: <20070313003646.GA17169@spearce.org> (Shawn O. Pearce's message
	of "Mon, 12 Mar 2007 20:36:47 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42100>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> >  	return status;
>> 
>> As the variable 'status' is not used anymore, I think this should return 0.
>
> Indeed.  I replaced that patch with another (same subject) in my
> latest series.  Because leaving that 'status' variable in caused
> a failure in the test suite when trying to create a bundle.
>
>   fixed:  http://article.gmane.org/gmane.comp.version-control.git/42087
>   borked: http://article.gmane.org/gmane.comp.version-control.git/42056
>
> You quoted the borked one.  Please drop it and apply the fixed one.

Ok, diffing these two the only differences I see are identical
to what I locally hand-fixed, so we are Ok it seems.
