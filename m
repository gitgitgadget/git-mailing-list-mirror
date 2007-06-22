From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/2] Teach git-blame --gui how to start git-gui blame
Date: Thu, 21 Jun 2007 22:20:48 -0700
Message-ID: <7vps3oa7kf.fsf@assigned-by-dhcp.pobox.com>
References: <20070621045333.GB13977@spearce.org>
	<7vtzt13k4o.fsf@assigned-by-dhcp.pobox.com>
	<20070622035652.GD17393@spearce.org>
	<7vzm2sab63.fsf@assigned-by-dhcp.pobox.com>
	<20070622044716.GG17393@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 22 07:20:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1bZp-0000UL-Gi
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 07:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbXFVFUu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jun 2007 01:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbXFVFUu
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jun 2007 01:20:50 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:59724 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbXFVFUt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jun 2007 01:20:49 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070622052048.OBPA1594.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Fri, 22 Jun 2007 01:20:48 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id EVLo1X00F1kojtg0000000; Fri, 22 Jun 2007 01:20:49 -0400
In-Reply-To: <20070622044716.GG17393@spearce.org> (Shawn O. Pearce's message
	of "Fri, 22 Jun 2007 00:47:16 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50677>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> This is only minor nuisance, but can we do something about this?
>> 
>>  $ git gui --version
>>  Application initialization failed: no display name and no $DISPLAY environment variable
>> 
>> I know it is from wish, not you, so I wouldn't insist, though.
>
> Actually that should be fixable.
>
> Should be as simple as using a Bourne shell script up front to
> check for "z$1" = zversion || "z$1" = z--version, and if so dump
> back the version, otherwise exec wish.  This is actually quite easy
> and won't change things for existing users.  I'll put a patch into
> maint tonight for it.

If this makes life any harder to people on Windows, especially
minGW, I would suggest against it.
