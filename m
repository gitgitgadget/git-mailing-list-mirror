From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: Question about 'branch -d' safety
Date: Mon, 19 Jul 2010 21:05:22 -0600
Message-ID: <4C451272.8000802@workspacewhiz.com>
References: <20091230065442.6117@nanako3.lavabit.com>	 <201007181355.36691.jnareb@gmail.com> <1279484847.8999.22.camel@dreddbeard>	 <201007190119.04873.jnareb@gmail.com> <1279523523.3077.8.camel@dreddbeard>	 <4C448879.4040202@workspacewhiz.com> <1279568744.3009.14.camel@dreddbeard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>
To: wmpalmer@gmail.com
X-From: git-owner@vger.kernel.org Tue Jul 20 05:05:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ob394-0006xY-Lr
	for gcvg-git-2@lo.gmane.org; Tue, 20 Jul 2010 05:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758134Ab0GTDFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 23:05:22 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:33809 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757941Ab0GTDFV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 23:05:21 -0400
Received: (qmail 29557 invoked by uid 399); 19 Jul 2010 21:05:20 -0600
Received: from unknown (HELO ?192.168.1.100?) (jjensen@workspacewhiz.com@76.27.116.215)
  by hsmail.qwknetllc.com with ESMTPAM; 19 Jul 2010 21:05:20 -0600
X-Originating-IP: 76.27.116.215
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.4) Gecko/20100608 Lightning/1.0b2 Thunderbird/3.1
In-Reply-To: <1279568744.3009.14.camel@dreddbeard>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151296>

  ----- Original Message -----
From: Will Palmer
Date: 7/19/2010 1:45 PM
> On Mon, 2010-07-19 at 11:16 -0600, Joshua Jensen wrote:
>> My brain has become muddied with all the ~2 stuff.  Explain again why it
>> can't be as simple as this?
> ...snip...
>> git checkout -b integration HEAD@{1}  (or 8000000)
>>
>> -Josh
> Because:
>   1) The HEAD reflog is the wrong place to stick things which weren't
> recently checked-out.
>   and 2) the previous tip is currently the easiest-to-recover part of a
> deleted branch. What's lost is all the reflog data: order of states, and
> how they were reached.
>
> However, I /do/ think it's as simple as "don't delete the reflog right
> away when you delete a branch", and other edge-cases and niceties in
> terms of UI (such as ref renaming, resurrection of refs for tracking
> unrelated data, etc) can be taken care of later, if there's actually a
> need for them.
Thanks for the extra clarification.

For my sake, how is the previous tip the easiest-to-recover part of a 
deleted branch?  How do you go about finding the lost object?

Josh
