From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH for "next"] pretty-formats: add 'format:<string>'
Date: Fri, 23 Feb 2007 10:30:54 -0800
Message-ID: <7vabz44tgh.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org>
	<87hcx1u934.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0611141518590.2591@xanadu.home>
	<87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
	<Pine.LNX.4.64.0611141633430.2591@xanadu.home>
	<7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142007010.2591@xanadu.home>
	<7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611142306090.2591@xanadu.home>
	<Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
	<455BBCE9.4050503@xs4all.nl>
	<Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
	<455C412D.1030408@xs4all.nl> <7v7ixvbq80.fsf@assigned-by-dhcp.cox.net>
	<455C618A.7080309@xs4all.nl> <ejkd6g$vog$1@sea.gmane.org>
	<4566E512.4010405@xs4all.nl>
	<Pine.LNX.4.63.0702230125270.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vslcx9ywx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702231237500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 23 19:31:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKfCM-0005uX-1s
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 19:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933166AbXBWSa4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 13:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933167AbXBWSa4
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 13:30:56 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:56390 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933166AbXBWSaz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 13:30:55 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070223183054.EDXQ2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Fri, 23 Feb 2007 13:30:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id T6Wu1W00r1kojtg0000000; Fri, 23 Feb 2007 13:30:55 -0500
In-Reply-To: <Pine.LNX.4.63.0702231237500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 23 Feb 2007 12:48:07 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40459>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > The supported placeholders are:
>> >
>> > 	'%H': commit hash
>> >...
>> > 	'%b': body
>> 
>> Hmmm.  Would we want to make them somehow interoperable with
>> git-for-each-ref format atoms?
>
> But those placeholders are so long! Not even GNU date supports such long 
> placeholders... And I could not reuse interpolate.[ch] as is for that.

What I was hinting at was to fix (or extend) for-each-ref to
accept these short-and-sweet placeholders.

>> Also, it _might_ be worthwhile to do something like "%+4b" which means 
>> "indent each line of this field with 4 spaces", for a multi-line field 
>> like "%b".
>
> Same goes here: interpolate.[ch] does not (yet) allow for that.

Nah, if you feel it is too much work, I trust your judgement (I
do not recall details of how interpolate.c does its thing).  I
do not think it's worth it.
