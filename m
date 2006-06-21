From: Junio C Hamano <junkio@cox.net>
Subject: Re: Odd behavior with git and cairo-devel repo
Date: Wed, 21 Jun 2006 04:01:36 -0700
Message-ID: <7vy7vqzsa7.fsf@assigned-by-dhcp.cox.net>
References: <20060621010030.GP2820@artsapartment.org>
	<20060621024605.GO11245@skl-net.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Art Haas <ahaas@airmail.net>
X-From: git-owner@vger.kernel.org Wed Jun 21 13:01:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ft0Sw-00007T-IE
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 13:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWFULBj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Jun 2006 07:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWFULBi
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jun 2006 07:01:38 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:36745 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751497AbWFULBi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jun 2006 07:01:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060621110137.SUWT5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Jun 2006 07:01:37 -0400
To: Andre Noll <maan@systemlinux.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22259>

Andre Noll <maan@systemlinux.org> writes:

> On 20:00, Art Haas wrote:
>
>> $ git clone git://git.cairographics.org/git/cairo cairo
>> [ ... git clones the repo without problem ... ]
>> $ cd cairo
>> $ git fsck-objects
>> Floating point exception
>
> This is due to refs_hash_size being zero in mark_reachable().
> Both "git fsck-objects --full" and "git repack -a -d" seem to work
> fine with the patch below (tested by cloning your repo).

Good catch.  Thanks both!
