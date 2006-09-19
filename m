From: Junio C Hamano <junkio@cox.net>
Subject: Re: Patch for http-fetch.c and older curl releases
Date: Mon, 18 Sep 2006 17:37:44 -0700
Message-ID: <7vvenkofmv.fsf@assigned-by-dhcp.cox.net>
References: <20060918225445.GF1261@artsapartment.org>
	<7v4pv4pyey.fsf@assigned-by-dhcp.cox.net>
	<20060918235753.GG1261@artsapartment.org>
	<7vzmcwogp9.fsf@assigned-by-dhcp.cox.net>
	<20060919003237.GH1261@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 19 02:38:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPTcU-00059x-55
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 02:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbWISAhr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 20:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbWISAhr
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 20:37:47 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:43913 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751981AbWISAhq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 20:37:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060919003745.OSRI2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Mon, 18 Sep 2006 20:37:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Q0dm1V00r1kojtg0000000
	Mon, 18 Sep 2006 20:37:47 -0400
To: git@vger.kernel.org
In-Reply-To: <20060919003237.GH1261@artsapartment.org> (Art Haas's message of
	"Mon, 18 Sep 2006 19:32:37 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27265>

"Art Haas" <ahaas@airmail.net> writes:

>> Eh, why not
>> 
>>         #ifndef CURLE_HTTP_RETURNED_ERROR
>>         #define CURLE_HTTP_RETURNED_ERROR CURLE_HTTP_NOT_FOUND
>>         #endif
>
> Hi.
>
> Both 'CURLE_HTTP_RETURNED_ERROR' and 'CURLE_HTTP_NOT_FOUND' are part of
> an enumeration, not preprocessor '#define' values. I suppose that the
> odd-looking 'E' in the names is meant to signify 'enum'.

Ah, sorry I misunderstood the original problem completely.
Then your original patch is _much_ better.
