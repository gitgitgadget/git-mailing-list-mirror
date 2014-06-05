From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 8/9] fetch doc: add a section on configured remote-tracking
 branches
Date: Thu, 05 Jun 2014 11:29:39 -0400
Message-ID: <53908CE3.6080106@xiplink.com>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com>	<1401833792-2486-9-git-send-email-gitster@pobox.com>	<538F3359.2050601@xiplink.com> <xmqqfvjktj40.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 17:29:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsZbk-0007A4-Oz
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 17:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751800AbaFEP3c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 11:29:32 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:33647 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751162AbaFEP3c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 11:29:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp12.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 54A832E08A3;
	Thu,  5 Jun 2014 11:29:31 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp12.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 03D652E06C8;
	Thu,  5 Jun 2014 11:29:30 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqqfvjktj40.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250845>

On 14-06-04 06:17 PM, Junio C Hamano wrote:
> Marc Branchaud <mbranchaud@xiplink.com> writes:
> 
> [jc: omitted good suggestions I'll use in amending]
> 
>>> +  the refspecs to be used to fetch.  The example above will fetch
>>
>> /to be used//
> 
> I have a problem with that change, actually, because you do not
> "fetch" refspec from anywhere.  A refspec is what is used to
> determine what histories to fetch (i.e. left-hand side of it before
> the colon) and which local refs to update with what is fetched
> (i.e. right-hand side of it after the colon), and this description
> of the traditional behaviour is meant to highlight the difference
> from the second usage, which is relatively new since f2690487
> (fetch: opportunistically update tracking refs, 2013-05-11),
> i.e. how the variable is *not* used as a refspec when the command
> line already has one.
> 
> Perhaps
> 
>     ... `remote.<repository>.fetch` values are used as the refspecs,
>     i.e. they specify what refs to fetch and what local refs to
>     update.
> 
> or something?

s/what/which/ and I think that would be fine.

		M.
