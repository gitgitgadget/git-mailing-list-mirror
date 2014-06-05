From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 9/9] fetch: allow explicit --refmap to override configuration
Date: Thu, 05 Jun 2014 11:45:49 -0400
Message-ID: <539090AD.9040100@xiplink.com>
References: <1401833792-2486-1-git-send-email-gitster@pobox.com>	<1401833792-2486-10-git-send-email-gitster@pobox.com>	<538F34E1.6010704@xiplink.com> <xmqqbnu8tim1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 05 17:46:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WsZrO-0002zp-6E
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jun 2014 17:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752158AbaFEPpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2014 11:45:42 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:59716 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbaFEPpm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2014 11:45:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp12.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 200892E0C26;
	Thu,  5 Jun 2014 11:45:41 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp12.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id B053E2E1083;
	Thu,  5 Jun 2014 11:45:40 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <xmqqbnu8tim1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250847>

On 14-06-04 06:28 PM, Junio C Hamano wrote:
> Marc Branchaud <mbranchaud@xiplink.com> writes:
> 
>>> Teach the command to pay attention to the --refmap=<lhs>:<rhs>
>>> command-line options that can be used to override the use of
>>> configured remote.*.fetch as the refmap.
>>
>> (Your 0/9 message merely said "The new patches at the
>> end clarifies how remote.*.fetch configuration variables are used in
>> two conceptually different ways." so I was not expecting fetch to get a new
>> option.)
> 
> This is more about conceptual consistency & completeness than new
> and useful addition, in that configured values and the feature they
> enable ought to be expressible and overridable from the command line
> options but we so far lacked a way to trigger the "do not affect
> what gets fetched, only affect where they go locally" feature, which
> is offered by the second way to use remote.*.fetch variable.  I do
> not think we absolutely need it and that is why it is at the end as
> an optional addition.

Ah, OK.

I don't have any objection to the option per se.  But I do wonder if there's
a need to add yet another knob to git just for completeness.  Has anyone ever
needed this?

		M.
