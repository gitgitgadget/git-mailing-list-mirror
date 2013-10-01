From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Local tag killer
Date: Mon, 30 Sep 2013 23:04:22 -0400
Message-ID: <524A3BB6.9060808@xiplink.com>
References: <52327E62.2040301@alum.mit.edu> <CAPc5daXvCf90WYoUWC+DxRyZEQhXGL7Bd_ZJKwfoqxeKt8TADQ@mail.gmail.com> <xmqqd2o3p0nk.fsf@gitster.dls.corp.google.com> <523D3FD2.4090002@alum.mit.edu> <20130924075119.GD7257@sigill.intra.peff.net> <alpine.LFD.2.03.1309251834210.312@syhkavp.arg> <5246C975.1050504@alum.mit.edu> <CALKQrgeJn1J4ntE_2Lr7Et+Oao=vB1FE6nLfaFJOvLHJLzG9tA@mail.gmail.com> <5247ACB9.40208@alum.mit.edu> <52499797.9030100@xiplink.com> <alpine.LFD.2.03.1309301138200.6331@syhkavp.arg> <5249CDF7.4050904@xiplink.com> <alpine.LFD.2.03.1309301527270.6331@syhkavp.arg> <5249E9C8.1070700@xiplink.com> <alpine.LFD.2.03.1309301839080.6331@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Carlos_Mart=EDn_Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Oct 01 05:04:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQqGQ-0003Zf-G2
	for gcvg-git-2@plane.gmane.org; Tue, 01 Oct 2013 05:04:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755378Ab3JADE0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 23:04:26 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:60859 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755251Ab3JADEZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 23:04:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp20.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 303321C013C;
	Mon, 30 Sep 2013 23:04:24 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp20.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 851AD1C00DB;
	Mon, 30 Sep 2013 23:04:23 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <alpine.LFD.2.03.1309301839080.6331@syhkavp.arg>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235638>

On 13-09-30 06:44 PM, Nicolas Pitre wrote:
> On Mon, 30 Sep 2013, Marc Branchaud wrote:
>
>> On 13-09-30 04:08 PM, Nicolas Pitre wrote:
>>> Again, in the cases where there is actually a SHA1 conflict between all
>>> possible tags that match a tag short-end then listing them and asking the
>>> user to be more explicit is the right thing to do.  But that should be a
>>> very rare case in practice, and designing for making this case easy is
>>> the wrong approach.
>>>
>>> Instead, the common case of multiple remotes with duplicated tag names
>>> referring to the same thing _and/or_ multiple remotes with distinct tags
>>> names is what should be made easy to use with no extra steps.
>>
>> Again, I don't think that's the common case.  I think it's just as likely for
>> there to be multiple remotes with duplicate tag names that refer to different
>> objects.
>
> Why do you say so?  I'm curious to know what kind of work flow would do
> that in practice.

The use case I have in mind is where a project makes use of other 
projects, for example an application that uses some libraries.  The 
application's repository could contain the full histories of the 
libraries, each subtree-merged into a different directory.

So maybe that's not so common these days, but the current flat tag 
namespace makes it pretty much impractical.

		M.
