From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v13 11/11] Documentation: add documentation for 'git interpret-trailers'
Date: Thu, 21 Aug 2014 10:16:46 -0400
Message-ID: <53F5FF4E.5090009@xiplink.com>
References: <20140816153440.18221.29179.chriscool@tuxfamily.org>	<20140816160622.18221.71416.chriscool@tuxfamily.org>	<53F51B98.2060903@xiplink.com> <CAP8UFD3hi6rRS=Z9dvbpvW75_K5mN5mPaxQdx3ATYOwXbuw3Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 16:16:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKTAV-0005Nx-Gh
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 16:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755433AbaHUOQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 10:16:43 -0400
Received: from smtp130.ord.emailsrvr.com ([173.203.6.130]:34150 "EHLO
	smtp130.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754890AbaHUOQm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 10:16:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp13.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id D2A711800DF;
	Thu, 21 Aug 2014 10:16:41 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp13.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id DF2171800A9;
	Thu, 21 Aug 2014 10:16:40 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.10);
	Thu, 21 Aug 2014 14:16:41 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <CAP8UFD3hi6rRS=Z9dvbpvW75_K5mN5mPaxQdx3ATYOwXbuw3Pw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255617>

On 14-08-20 11:39 PM, Christian Couder wrote:
> On Thu, Aug 21, 2014 at 12:05 AM, Marc Branchaud <marcnarc@xiplink.com> wrote:
>> On 14-08-16 12:06 PM, Christian Couder wrote:
>>> +
>>> +* after them it's only possible to have some lines that contain only
>>> +  spaces, and then a patch; the patch part is recognized using the
>>> +  fact that its first line starts with '---' (three minus signs),
>>
>> Is that "starts with" or "consists solely of"?
> 
> It is starts with. (The starts_with() function is used.)

Wouldn't it be more robust to do it the other way?  I can imagine cases when
a human might want to start a line of text with "---", whereas we can make
sure that git tools always use a plain "---" line with no extra text.

Not a big deal either way though.  Thanks for working on this!

		M.
