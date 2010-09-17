From: Bryan Drewery <bryan@shatow.net>
Subject: Re: [PATCH 1/2] commit: add message options for rebase --autosquash
Date: Fri, 17 Sep 2010 11:14:03 -0500
Message-ID: <4C9393CB.4010107@shatow.net>
References: <1284687596-236-1-git-send-email-patnotz@gmail.com> <1284687596-236-2-git-send-email-patnotz@gmail.com> <4C93288B.7000908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pat Notz <patnotz@gmail.com>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 18:14:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwdZv-0006p8-VD
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 18:14:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755410Ab0IQQOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Sep 2010 12:14:11 -0400
Received: from secure.xzibition.com ([173.160.118.92]:50033 "EHLO
	secure.xzibition.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754596Ab0IQQOK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Sep 2010 12:14:10 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws; d=shatow.net; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=sweb; b=irSNTp
	94KEzlSFTCIiqGAlQafARbTe7qKTdwD6vePhCWXOPGoV8rJlzM7nJZlUfYhFrSdl
	EXzJLiq6DGadZ5m+hcpClxqtZ2oa9kBofjqkRYhKZjdsPIydNkCeFMDqTmSFTGI3
	KHrL3iZ/r6C2dLuupVw1MU53LQ94wfxe5ITFE=
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=shatow.net; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=sweb; bh=89JvtMsvBvfM
	D2hj5KDZVg0XVdVbiLs3hHr7xpy7WFE=; b=Q50CrpxQRWKPYGZw4pwKo6UeQJvq
	F///4fuq0TBaCmqU2dSUIDT2yrLSA3MsWLDSfSmlyrTu+dIzkoW9NFYE+3iLZBwJ
	W5atjJ434KCtaEJeMccvQeKIFQQudW4ImIDrN8gdv4hI6zgtdMsMwnMtRlPMeMxs
	1cLUH2arbwP2ojg=
Received: (qmail 44313 invoked from network); 17 Sep 2010 11:14:07 -0500
Received: from unknown (HELO ?192.168.0.201?) (bryan@shatow.net@74.94.87.209)
  by sweb.xzibition.com with ESMTPA; 17 Sep 2010 11:14:07 -0500
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <4C93288B.7000908@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156393>

Stephen Boyd wrote:
> On 09/16/2010 06:39 PM, Pat Notz wrote:
>   
>> These options make it convenient to construct commit messages for use
>> with 'rebase --autosquash'.  The resulting commit message will be
>> "fixup! ..." or "squash! ..." where "..." is the subject line of the
>> specified commit message.
>>
>> Example usage:
>>   $ git commit --fixup HEAD~2
>>   $ git commit --squash HEAD~5
>>
>> Signed-off-by: Pat Notz <patnotz@gmail.com>
>> ---
>>     
>
> So far I've been using an alias for these, but I suppose making them
> real features of git could be worthwhile. What are the benefits with
> this approach vs. an alias?
>
>   

I keep wanting to do these at commit time.

What are the alternative aliases?

Bryan
