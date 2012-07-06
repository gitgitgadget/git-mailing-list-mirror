From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 2/6] Teach remote.c about the remote.default configuration
 setting.
Date: Fri, 06 Jul 2012 15:57:51 -0400
Message-ID: <4FF7433F.606@xiplink.com>
References: <1341526277-17055-1-git-send-email-marcnarc@xiplink.com> <1341526277-17055-3-git-send-email-marcnarc@xiplink.com> <7v4nplrfe4.fsf@alter.siamese.dyndns.org> <4FF6F805.20403@xiplink.com> <7vhatkofe6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens.Lehmann@web.de, peff@peff.net,
	phil.hord@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 21:58:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SnEfK-00053L-Ut
	for gcvg-git-2@plane.gmane.org; Fri, 06 Jul 2012 21:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720Ab2GFT54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jul 2012 15:57:56 -0400
Received: from smtp146.ord.emailsrvr.com ([173.203.6.146]:43609 "EHLO
	smtp146.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab2GFT5n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2012 15:57:43 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp23.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 262E91C8096;
	Fri,  6 Jul 2012 15:57:43 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp23.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id A16341C80B7;
	Fri,  6 Jul 2012 15:57:42 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120615 Thunderbird/13.0.1
In-Reply-To: <7vhatkofe6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201144>

On 12-07-06 03:31 PM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> On 12-07-05 06:50 PM, Junio C Hamano wrote:
>>>
>>>>  - effective_remote_name is the name of the remote tracked by the current
>>>>    branch, or is default_remote_name if the current branch doesn't have a
>>>>    remote.
>>>
>>> The explanation of the latter belongs to the previous step, I think.
>>> I am not sure if "effective" is the best name for the concept the
>>> above explains, though.
>>
>> Well, the previous commit removes default_remote_name, so the explanation
>> wouldn't be valid verbatim.
> 
> The previous one introduces "effective" (which I still think is not
> the best word for the semantics you are trying to give to the
> variable)

I'm open to suggestions.

		M.
