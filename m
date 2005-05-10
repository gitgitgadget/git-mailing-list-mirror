From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] minor Makefile and local-pull.c edits for Darwin
Date: Tue, 10 May 2005 14:05:58 -0700
Message-ID: <7vekceyeo9.fsf@assigned-by-dhcp.cox.net>
References: <20050510021105.53984.qmail@web41213.mail.yahoo.com>
	<428038D0.5000706@zytor.com> <7vpsvzpolp.fsf@assigned-by-dhcp.cox.net>
	<4280C883.6080209@zytor.com> <4280CAC6.4000805@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Allen <mrallen1@yahoo.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 10 23:04:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVbth-0004fY-T2
	for gcvg-git@gmane.org; Tue, 10 May 2005 23:04:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVEJVKr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 May 2005 17:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVEJVGk
	(ORCPT <rfc822;git-outgoing>); Tue, 10 May 2005 17:06:40 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:64237 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261796AbVEJVGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2005 17:06:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050510210558.DXHJ20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 May 2005 17:05:58 -0400
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <4280CAC6.4000805@zytor.com> (H. Peter Anvin's message of "Tue,
 10 May 2005 07:52:54 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "HPA" == H Peter Anvin <hpa@zytor.com> writes:

HPA> That being said, there are also a whole bunch of assumptions that any
HPA> object can be memory-mapped *plus* fit uncompressed in
HPA> memory... that's obviously not going to be the case for large files.

HPA> On the other hand, one has to start cleaning up somewhere...

I agree to that, but on the other hand one also has to know
where to stop.  The primary purpose of GIT being to manage the
source files for the Linux kernel project, not worrying about
_huge_ files that would cause mmap+uncompressed or st.st_size
not fitting in unsigned long may just be fine.



