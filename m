From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] get_sha1() shorthands for blob/tree objects
Date: Wed, 19 Apr 2006 14:49:20 -0700
Message-ID: <7v3bg96xsv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604181627101.3701@g5.osdl.org>
	<7vpsjecriu.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604181805080.3701@g5.osdl.org>
	<7vd5fecpyd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604181836400.3701@g5.osdl.org>
	<7v8xq2ciws.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604182108070.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 19 23:49:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWKYA-0003Bi-4T
	for gcvg-git@gmane.org; Wed, 19 Apr 2006 23:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWDSVtX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Apr 2006 17:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWDSVtX
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Apr 2006 17:49:23 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:55209 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751258AbWDSVtW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Apr 2006 17:49:22 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060419214922.ZSLP24981.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Apr 2006 17:49:22 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604182108070.3701@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 18 Apr 2006 21:14:01 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18942>

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 18 Apr 2006, Junio C Hamano wrote:
>> 
>> A small fry in the ointment.  What should the parts that are
>> output with --name-only say for such a diff?
>
> I have no idea, I have to say ;)

Another small one ;-).  Bare blobs do not have modes, so diffcore
needs to be told "do not bother comparing mode for this pair".
