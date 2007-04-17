From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] git-bisect: allow bisecting with only one bad commit.
Date: Mon, 16 Apr 2007 22:03:56 -0700
Message-ID: <7v7isbsibn.fsf@assigned-by-dhcp.cox.net>
References: <7vzm5pw7ju.fsf@assigned-by-dhcp.cox.net>
	<20070404071202.483030b8.chriscool@tuxfamily.org>
	<7v7isqkoa3.fsf_-_@assigned-by-dhcp.cox.net>
	<200704170707.10938.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Apr 17 07:04:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdfrF-0002rO-Gw
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 07:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031084AbXDQFD6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 01:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753925AbXDQFD6
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 01:03:58 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:47606 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753888AbXDQFD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 01:03:57 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070417050357.POCR1271.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 17 Apr 2007 01:03:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id o53w1W00n1kojtg0000000; Tue, 17 Apr 2007 01:03:56 -0400
In-Reply-To: <200704170707.10938.chriscool@tuxfamily.org> (Christian Couder's
	message of "Tue, 17 Apr 2007 07:07:10 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44726>

Christian Couder <chriscool@tuxfamily.org> writes:

>> -test_expect_success 'bisect does not start with only one good' '
>> +test_expect_success 'bisect starts with only one good' '
>>  	git bisect reset &&
>>  	git bisect start &&
>>  	git bisect good $HASH1 || return 1
>
> But I don't understand the need to change the above comment when the test 
> code for starting with one good commit is not changed.

Good eyes, thanks.
