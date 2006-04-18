From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT_OBJECT_DIRECTORY
Date: Tue, 18 Apr 2006 11:20:58 -0700
Message-ID: <7vfykag2yd.fsf@assigned-by-dhcp.cox.net>
References: <20060418133847.GC4720@wohnheim.fh-wedel.de>
	<Pine.LNX.4.64.0604180822470.3701@g5.osdl.org>
	<20060418175853.GA25688@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 20:21:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVupN-0002EM-U8
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 20:21:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWDRSVD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 18 Apr 2006 14:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750947AbWDRSVD
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 14:21:03 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:28384 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750837AbWDRSVB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Apr 2006 14:21:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060418182059.CVXV20694.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Apr 2006 14:20:59 -0400
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
In-Reply-To: <20060418175853.GA25688@wohnheim.fh-wedel.de>
 (=?iso-8859-1?Q?J=F6rn?= Engel's
	message of "Tue, 18 Apr 2006 19:58:53 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18866>

J=F6rn Engel <joern@wohnheim.fh-wedel.de> writes:

> Well, .git/objects for your kernel still consumes 121M.  It's not
> gigabytes but I still wouldn't want too many copies of that lying
> around.

That is what "git clone -l -s" is for. =20

The alternates pointer mechanism used with the above largely
makes GIT_OBJECT_DIRECTORY unnecessary for end users these days.
It is a fine mechanism as an implementation detail of the
lowlevel and Porcelains, and that is the reason the
documentation still mentions the environment.
