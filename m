From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Convert open("-|") to qx{} calls
Date: 23 Feb 2006 13:15:37 -0800
Message-ID: <863bi9g4jq.fsf@blue.stonehenge.com>
References: <Pine.LNX.4.63.0602231532470.29635@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0602230738s3445bd86h2d1d670e0ef5daed@mail.gmail.com>
	<86hd6qgit5.fsf@blue.stonehenge.com>
	<7v1wxuhsgw.fsf@assigned-by-dhcp.cox.net>
	<863bi9hq6u.fsf@blue.stonehenge.com>
	<Pine.LNX.4.63.0602232039160.30630@wbgn013.biozentrum.uni-wuerzburg.de>
	<86lkw1g647.fsf@blue.stonehenge.com>
	<20060223211403.GB5827@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 22:15:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCNoR-00059H-I0
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 22:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbWBWVPo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 16:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWBWVPo
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 16:15:44 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:64934 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751785AbWBWVPn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 16:15:43 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 7AFCA8F768;
	Thu, 23 Feb 2006 13:15:38 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 22827-01-43; Thu, 23 Feb 2006 13:15:37 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id BB4F48F76F; Thu, 23 Feb 2006 13:15:37 -0800 (PST)
To: Alex Riesen <raa.lkml@gmail.com>
x-mayan-date: Long count = 12.19.13.1.7; tzolkin = 7 Manik; haab = 5 Kayab
In-Reply-To: <20060223211403.GB5827@steel.home>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16668>

>>>>> "Alex" == Alex Riesen <raa.lkml@gmail.com> writes:

Alex> Randal L. Schwartz, Thu, Feb 23, 2006 21:41:44 +0100:
Johannes> Now that our local Perl guru joined the discussion, may I ask what
Johannes> is, and what is not quoted when put inside qx{}?
>> 
>> Nothing is quoted.  Your string acts as if it was XXX in:
>> 
>> sh -c 'XXX'
>> 

Alex> Not so for ActiveState. It'll just run the first non-whitespace word
Alex> passing the rest of the line in its command-line.
Alex> It's not even worse then to pass it all to cmd/command :)

Right.  That's why I suggest (in a later message) that safe_qx merely
fall back to qx() on Activestate.  Can't go much more wrong. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
