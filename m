From: Junio C Hamano <junkio@cox.net>
Subject: Re: Remove unneeded packs
Date: Sat, 12 Nov 2005 18:38:17 -0800
Message-ID: <7voe4pclwm.fsf@assigned-by-dhcp.cox.net>
References: <1131800663.29461.11.camel@blade> <4375EA80.7070405@op5.se>
	<1131802238.29461.18.camel@blade> <43766687.2000007@etek.chalmers.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp-2
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 13 03:38:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb7l8-00089k-Sn
	for gcvg-git@gmane.org; Sun, 13 Nov 2005 03:38:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbVKMCiU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 21:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750946AbVKMCiU
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 21:38:20 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:58029 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750861AbVKMCiT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 21:38:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051113023819.KBBM9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 12 Nov 2005 21:38:19 -0500
To: Lukas =?iso-2022-jp-2?B?U2FuZHN0chsuQRtOdm0=?= 
	<lukass@etek.chalmers.se>
In-Reply-To: <43766687.2000007@etek.chalmers.se> (Lukas
 =?iso-2022-jp-2?B?U2FuZHN0chsuQRtOdm0ncw==?= message
	of "Sat, 12 Nov 2005 23:02:47 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11724>

Lukas Sandstr.ANvm <lukass@etek.chalmers.se> writes:

> This is most likley because the pack b3c6... contains unreachable objects.
> git-pack-redundant only makes sure that all objects present in packfiles
> still are present in packfiles after the redundant packs have been removed.
> ...
> I'm thinking of the possibility passing a list of objects to be ignored
> on stdin to git-pack-redundant. This would hopefully solve this problem.

But once you go down that path, wouldn't doing 'repack -a -d'
become looking simpler and more attractive, I wonder?
