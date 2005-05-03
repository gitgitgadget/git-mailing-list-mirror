From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and symlinks as tracked content
Date: Tue, 03 May 2005 16:16:16 -0700
Message-ID: <7v1x8nuchr.fsf@assigned-by-dhcp.cox.net>
References: <1115145234.21105.111.camel@localhost.localdomain>
	<Pine.LNX.4.58.0505031151240.26698@ppc970.osdl.org>
	<Pine.LNX.4.58.0505031255000.30768@sam.ics.uci.edu>
	<Pine.LNX.4.58.0505031304140.26698@ppc970.osdl.org>
	<7vr7got2tz.fsf@assigned-by-dhcp.cox.net> <42780185.7010204@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Gal <gal@uci.edu>,
	Kay Sievers <kay.sievers@vrfy.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 01:13:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT6ZB-0004pV-JI
	for gcvg-git@gmane.org; Wed, 04 May 2005 01:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbVECXR7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 19:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVECXR7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 19:17:59 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:53680 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261905AbVECXQT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 19:16:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503231618.XIHW7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 3 May 2005 19:16:18 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42780185.7010204@zytor.com> (H. Peter Anvin's message of "Tue,
 03 May 2005 15:56:05 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "HPA" == H Peter Anvin <hpa@zytor.com> writes:

HPA> Owner and permissions are part of the tree object, and apply to all
HPA> file types.

Huh?  I am confused...  Do you mean tree object should be
changed to record these?  That would make the existing in-cache
merging of files, which GIT was built for, quite interesting...

Well, doing device nodes _is_ a tangent, so let's drop this
discussion.


