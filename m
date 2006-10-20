From: Junio C Hamano <junkio@cox.net>
Subject: Re: VCS comparison table
Date: Fri, 20 Oct 2006 16:19:17 -0700
Message-ID: <7vlknalgne.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610171605440.3962@g5.osdl.org>
	<vpqirigqzpd.fsf@ecrins.imag.fr> <20061019123349.GE20017@pasky.or.cz>
	<200610201350.12273.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 01:19:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb3eU-0007ey-Fb
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 01:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWJTXTT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 19:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWJTXTT
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 19:19:19 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:27322 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030205AbWJTXTS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 19:19:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061020231918.VUSL2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Fri, 20 Oct 2006 19:19:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id cnK31V00B1kojtg0000000
	Fri, 20 Oct 2006 19:19:03 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29554>

Jakub Narebski <jnareb@gmail.com> writes:

>> The lack of parents ordering in Git is directly connected with
>> fast-forwarding.
>
> There are exactly _two_ places where Git treats first parent specially 
> (correct me if I'm wrong).

I am not bold enough to say _exactly_ N places, but you missed
at least one more important one.  Merge simplification favors
the earlier parents over later ones.
