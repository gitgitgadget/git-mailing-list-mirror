From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/7] gitweb: Make pickaxe search a feature
Date: Thu, 07 Sep 2006 02:02:06 -0700
Message-ID: <7vmz9c2goh.fsf@assigned-by-dhcp.cox.net>
References: <200609061504.40725.jnareb@gmail.com>
	<1157548091229-git-send-email-jnareb@gmail.com>
	<7vlkow5x77.fsf@assigned-by-dhcp.cox.net> <edoli0$oql$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 11:02:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLFm1-0006p5-Ow
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 11:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWIGJB4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 05:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751241AbWIGJB4
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 05:01:56 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:29891 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751246AbWIGJBy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 05:01:54 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060907090154.MNMI2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Thu, 7 Sep 2006 05:01:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KM1m1V0051kojtg0000000
	Thu, 07 Sep 2006 05:01:47 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <edoli0$oql$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	07 Sep 2006 10:34:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26619>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Jakub Narebski <jnareb@gmail.com> writes:
>> 
>>> As pickaxe search (selected using undocumented 'pickaxe:' operator in
>>> search query) is resource consuming, allow to turn it on/off using
>>> feature meachanism.
>> 
>> I do not have a problem against making it configurable.
>> 
>>> +    'pickaxe' => {
>>> +            'sub' => \&feature_pickaxe,
>>> +            'override' => 0,
>>> +            'default' => [0]},
>>>  );
>> 
>> The patch suggests that it is turned off by default right now; I
>> have not checked it myself, but is that the case?
>
> No, it is not. Currently it is turned on, _but_ undocumented.

Then it would be nice to make it documented and keep the default
perhaps?
