From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: /* compiler workaround */ - what was the issue?
Date: Fri, 6 May 2016 15:30:29 -0400
Message-ID: <572CF0D5.6010305@xiplink.com>
References: <AA5B2B1715BAF7438221293187A417A7BDE9D11D@desmdswms002.des.grplnk.net>
 <17E04501C9474282B87758C7998A1F5B@PhilipOakley>
 <xmqqtwic9o88.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CBuU8H8r_f4KsnLkhLtfRv0nDo4hGS31LVn0e1Y_3OAQ@mail.gmail.com>
 <51C902B1F7464CF2B58EB0E495F86BB5@PhilipOakley>
 <572CDCFF.9050607@ramsayjones.plus.com>
 <xmqq60ur3tlu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Fri May 06 21:30:38 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aylSP-0004oY-6I
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 21:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758664AbcEFTac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 15:30:32 -0400
Received: from smtp90.iad3a.emailsrvr.com ([173.203.187.90]:59889 "EHLO
	smtp90.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758541AbcEFTac (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 May 2016 15:30:32 -0400
Received: from smtp20.relay.iad3a.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp20.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 06D051805EC;
	Fri,  6 May 2016 15:30:31 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp20.relay.iad3a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 487EE180317;
	Fri,  6 May 2016 15:30:30 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.5.4);
	Fri, 06 May 2016 15:30:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
In-Reply-To: <xmqq60ur3tlu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293851>

On 2016-05-06 02:54 PM, Junio C Hamano wrote:
>
> I wonder if can we come up with a short and sweet notation to remind
> futhre readers that this "initialization" is not initializing but
> merely squelching warnings from stupid compilers, and agree to use
> it consistently?

Perhaps

	#define COMPILER_UNINITIALIZED_WARNING_INITIALIZER 0

or, for short-and-sweet

	#define CUWI 0

?

:)

		M.
