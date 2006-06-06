From: Junio C Hamano <junkio@cox.net>
Subject: Re: New release?
Date: Tue, 06 Jun 2006 08:20:39 -0700
Message-ID: <7v3beiux88.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606052002530.5498@g5.osdl.org>
	<7vodx6zus2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0606061019440.11478@wbgn013.biozentrum.uni-wuerzburg.de>
	<7virnevath.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0606061439500.28953@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 17:21:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FndMR-0002MR-H8
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 17:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932222AbWFFPUl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Jun 2006 11:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWFFPUl
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jun 2006 11:20:41 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:20688 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932222AbWFFPUk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jun 2006 11:20:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060606152040.ZZQS19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Jun 2006 11:20:40 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606061439500.28953@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 6 Jun 2006 14:42:59 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21380>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Also, what you talk about the "lazy clone" is a lot more involved than 
>> what Eric wanted to have.
>
> A little more involved. And I wanted to know what people think about this 
> way to tackle shallow clones.

This truly is a lot more involved, not because "lazy clone" is
hard (which it is) but because what Eric wants to have is not to
produce a shallow clone situation.  The issue is about being
able to fetch an object that is not listed as one of the refs
the server side has, and it still will result in a fully
connected repository.
