From: Jeremy Morton <admin@game-point.net>
Subject: Re: [PATCH v10 11/12] Documentation: add documentation for 'git interpret-trailers'
Date: Tue, 29 Apr 2014 14:25:23 +0100
Message-ID: <535FA843.1000706@game-point.net>
References: <20140406163214.15116.91484.chriscool@tuxfamily.org>	<20140406170204.15116.15559.chriscool@tuxfamily.org>	<xmqqmwfv3433.fsf@gitster.dls.corp.google.com>	<20140425.215619.2296838250398594645.chriscool@tuxfamily.org>	<xmqq8uqptno9.fsf@gitster.dls.corp.google.com>	<535F8785.10302@game-point.net> <CAP8UFD2oXpW9QEkSh+vpNGRAxRFp0zJF39ZZ8sUZLTcKB9mHWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 15:25:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf82N-0005lk-7c
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 15:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757398AbaD2NZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 09:25:26 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:49846 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbaD2NZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 09:25:25 -0400
Received: from [192.168.0.2] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id 4AA5A18A09AD;
	Tue, 29 Apr 2014 08:33:10 -0500 (CDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <CAP8UFD2oXpW9QEkSh+vpNGRAxRFp0zJF39ZZ8sUZLTcKB9mHWQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247582>

On 29/04/2014 12:47, Christian Couder wrote:
>> Also, if there were no current branch name because you're committing in a
>> detached head state, it would be nice if you could have some logic to
>> determine that, and instead write the trailer as:
>>          Made-on-branch: (detached HEAD: AB12CD34)
>
> You may need to write a small script for that.
> Then you just need the "trailer.m-o-b.command" config value to point
> to your script.
>
>> ... or whatever.  And also how about some logic to be able to say that if
>> you're committing to the "master" branch, the trailer doesn't get inserted
>> at all?
>
> You can script that too.

But it would be nicer if the logic were built-in, then you wouldn't have 
to share some script with your work colleagues. :-)

-- 
Best regards,
Jeremy Morton (Jez)
