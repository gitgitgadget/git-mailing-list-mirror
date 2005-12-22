From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 1.0.0b quickfix
Date: Wed, 21 Dec 2005 19:40:50 -0800
Message-ID: <7vu0d1u7ct.fsf@assigned-by-dhcp.cox.net>
References: <7vpsnq3wrg.fsf@assigned-by-dhcp.cox.net>
	<43A9E15F.1060808@zytor.com> <7vpsnqyqji.fsf@assigned-by-dhcp.cox.net>
	<43AA0C68.4030802@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 04:41:10 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpHKG-0000m3-Dy
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 04:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbVLVDkx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 22:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbVLVDkx
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 22:40:53 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:65459 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751186AbVLVDkw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 22:40:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051222033959.NVVC20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 22:39:59 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43AA0C68.4030802@zytor.com> (H. Peter Anvin's message of "Wed,
	21 Dec 2005 18:16:08 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13931>

"H. Peter Anvin" <hpa@zytor.com> writes:

>>>Wouldn't it make more sense for the maintenance release to be 1.0.1?
>> Maybe.  Nobody mentioned this about 0.99.9a, 0.99.9b... though.
>
> Yeah, well, the 0.99 bit in front kind of had made that hard to do.

Well, I could have done 0.99.9.1 instead of 0.99.9a.

>> The series 1.0.0[a-z] is meant to parallel 2.6.14.[123...]
>> "fixes only"; OTOH I'd like to allow 1.0.[123...] to contain
>> enhancements.
>
> Well, the Linux numbering scheme has gotten ridiculous, with the 2. in 
> front having no meaning.

True.

We could do 1.0.0 (base 1.0 release), 1.0.1 (instead of 1.0.0a),
1.0.2 (instead of 1.0.0b) on the "maint" branch and 1.1.0 to be
next minor feature release.  Do you like it better?
