From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] send-pack.c: mark a file-local function static
Date: Fri, 13 Dec 2013 22:50:25 +0000
Message-ID: <52AB8F31.40107@ramsay1.demon.co.uk>
References: <52AA43AA.9030703@ramsay1.demon.co.uk> <CACsJy8DnVUc2xQGD4hr2tuFhaGj4kuc=63xxmmUwq1bkFtztOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 13 23:50:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrbZ7-0002eA-QF
	for gcvg-git-2@plane.gmane.org; Fri, 13 Dec 2013 23:50:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab3LMWub (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Dec 2013 17:50:31 -0500
Received: from mdfmta004.mxout.tbr.inty.net ([91.221.168.45]:35591 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752082Ab3LMWua (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Dec 2013 17:50:30 -0500
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id A52C1A0C089;
	Fri, 13 Dec 2013 22:50:28 +0000 (GMT)
Received: from mdfmta004.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP id 66A0AA0C080;
	Fri, 13 Dec 2013 22:50:28 +0000 (GMT)
Received: from [192.168.254.16] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mdfmta004.tbr.inty.net (Postfix) with ESMTP;
	Fri, 13 Dec 2013 22:50:27 +0000 (GMT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <CACsJy8DnVUc2xQGD4hr2tuFhaGj4kuc=63xxmmUwq1bkFtztOw@mail.gmail.com>
X-MDF-HostID: 9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239268>

On 13/12/13 00:58, Duy Nguyen wrote:
> On Fri, Dec 13, 2013 at 6:15 AM, Ramsay Jones
> <ramsay@ramsay1.demon.co.uk> wrote:
>> BTW, I have not been following these patches, but I noticed that the
>> 'remove_nonexistent_ours_in_pack()' function has no callers. (There are
>> two commented out callers - but they seem to have *always* been commented
>> out ;-) ). So, step 5 is no longer required? :-D
> 
> It's more of an optimization than a requirement, to avoid expensive
> calculation later. Uncommenting is possible but I need to pass the
> pack file name around a bit.
> 

Ah, OK.

(I should probably refrain from commenting on code I haven't read ... :-P )

ATB,
Ramsay Jones
