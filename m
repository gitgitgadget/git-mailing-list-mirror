From: Bo98 <BoEllisAnderson@aol.com>
Subject: Re: PROPFIND 405 with git-http-backend and Smart HTTP
Date: Mon, 30 Jul 2012 01:40:00 -0700 (PDT)
Message-ID: <1343637600904-7564056.post@n2.nabble.com>
References: <1343587966493-7564017.post@n2.nabble.com> <CAJo=hJtB6OQ8+8Q_JgPoAntOdQ=Z0tOERYRD7wJ0LRLgacYA8A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 10:40:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvlWM-00076c-BK
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 10:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752455Ab2G3IkC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 04:40:02 -0400
Received: from sam.nabble.com ([216.139.236.26]:55845 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751351Ab2G3IkB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 04:40:01 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <BoEllisAnderson@aol.com>)
	id 1SvlWC-00053P-U5
	for git@vger.kernel.org; Mon, 30 Jul 2012 01:40:00 -0700
In-Reply-To: <CAJo=hJtB6OQ8+8Q_JgPoAntOdQ=Z0tOERYRD7wJ0LRLgacYA8A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202530>


Shawn Pearce wrote
> 
>> And here's a snip from my access_log:
>>
>>     ::1 - - [29/Jul/2012:18:34:34 +0100] "GET
>> /repo/myproject.git/info/refs?service=git-receive-pack HTTP/1.1" 200 117
> 
> Was this request actually served using the smart http-backend? Try the
> request yourself on the command line with curl, making sure to pass
> the ?service=git-receive-pack query parameter. A smart HTTP response
> will include a service=git-receive-pack line as the first line of the
> response body. I don't think Apache called the http-backend CGI, and
> so the client thought the server was not smart HTTP capable.
> 

This is what curl returned:

2ddf56592a0f55456b8c42dc9f2cb9289f083f53	refs/heads/1.0.x
55079bb13d9af8a9164ad0d24b654cbfe119bc7e	refs/heads/master

Looks okay. Those are the 2 branches I've got.



--
View this message in context: http://git.661346.n2.nabble.com/PROPFIND-405-with-git-http-backend-and-Smart-HTTP-tp7564017p7564056.html
Sent from the git mailing list archive at Nabble.com.
