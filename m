From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/2] Teach git-blame --gui how to start git-gui blame
Date: Thu, 21 Jun 2007 21:03:00 -0700
Message-ID: <7vzm2sab63.fsf@assigned-by-dhcp.pobox.com>
References: <20070621045333.GB13977@spearce.org>
	<7vtzt13k4o.fsf@assigned-by-dhcp.pobox.com>
	<20070622035652.GD17393@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 22 06:03:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1aMU-00087E-Vi
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 06:03:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbXFVEDE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 00:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751219AbXFVEDD
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 00:03:03 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:65360 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbXFVEDB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 00:03:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070622040300.MVOE1594.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 22 Jun 2007 00:03:00 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id EU301X00A1kojtg0000000; Fri, 22 Jun 2007 00:03:00 -0400
In-Reply-To: <20070622035652.GD17393@spearce.org> (Shawn O. Pearce's message
	of "Thu, 21 Jun 2007 23:56:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50672>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Hmm.  Now, how does "git-blame" tell if there is usable git-gui
>> installed with it?  Will we have "git-gui --list-features"?
>
> It can run `git gui version` and check to see that it is >= 0.7.3.

This is only minor nuisance, but can we do something about this?

 $ git gui --version
 Application initialization failed: no display name and no $DISPLAY environment variable

I know it is from wish, not you, so I wouldn't insist, though.
 
