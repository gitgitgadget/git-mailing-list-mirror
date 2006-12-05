X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 05 Dec 2006 14:58:47 -0800
Message-ID: <7vy7pmdk60.fsf@assigned-by-dhcp.cox.net>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org>
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
	<Pine.LNX.4.63.0612052340260.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 22:58:56 +0000 (UTC)
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwen@xs4all.nl>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0612052340260.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 5 Dec 2006 23:42:46 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33385>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrjFV-0002ko-Qc for gcvg-git@gmane.org; Tue, 05 Dec
 2006 23:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966263AbWLEW6u (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 17:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966205AbWLEW6u
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 17:58:50 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:51895 "EHLO
 fed1rmmtao04.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S966263AbWLEW6t (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 17:58:49 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205225849.LHVQ7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Tue, 5
 Dec 2006 17:58:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id vAyy1V00L1kojtg0000000; Tue, 05 Dec 2006
 17:58:58 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 24 Nov 2006, Han-Wen Nienhuys wrote:
>
>> The recently posted patch documenting is an improvement, but why not
>> add an option so you can do
>> 
>>   --format 'committer %c\nauthor %a\n'
>>   
>> this catches all combinations, and is easier for scripting.
>
> Yes, it would be easier for scripting, and it would probably be relatively 
> easy, what with the addition of interpolate.[ch] to git. However, it is 
> work, and I am lazy.

Lazy is good when the details should not matter.  If some people
are scripting, they are fully capable of reading raw or fuller.


