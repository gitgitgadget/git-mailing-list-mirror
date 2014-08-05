From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH] Release notes grammatical fixes.
Date: Tue, 05 Aug 2014 17:57:19 -0400
Message-ID: <53E1533F.7020601@xiplink.com>
References: <xmqqy4v3q43r.fsf@gitster.dls.corp.google.com>	<1407257445-18363-1-git-send-email-marcnarc@xiplink.com>	<xmqqha1qpz7e.fsf@gitster.dls.corp.google.com> <xmqq8un2pyk3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 05 23:57:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEmjR-0002UF-Kt
	for gcvg-git-2@plane.gmane.org; Tue, 05 Aug 2014 23:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbaHEV5R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2014 17:57:17 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:39036 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987AbaHEV5R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2014 17:57:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp12.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 812EF100387;
	Tue,  5 Aug 2014 17:57:16 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp12.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 49EC3100134;
	Tue,  5 Aug 2014 17:57:16 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.10);
	Tue, 05 Aug 2014 21:57:16 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqq8un2pyk3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254831>

On 14-08-05 02:43 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Marc Branchaud <marcnarc@xiplink.com> writes:
>> ...
>>> @@ -87,22 +87,20 @@ UI, Workflows & Features
>>>   * "git mergetool" learned to drive the vimdiff3 backend.
>>>  
>>>   * mergetool.prompt used to default to 'true', always asking "do you
>>> -   really want to run the tool on this path?".  Among the two
>>> -   purposes this prompt serves, ignore the use case to confirm that
>>> -   the user wants to view particular path with the named tool, and
>>> -   redefine the meaning of the prompt only to confirm the choice of
>>> -   the tool made by the autodetection (for those who configured the
>>> -   tool explicitly, the prompt shown for the latter purpose is
>>> -   simply annoying).
>>> -
>>> -   Strictly speaking, this is a backward incompatible change and the
>>> +   really want to run the tool on this path?".  The default has been
>>> +   changed to 'false'.  However, the prompt will still appear if
>>> +   mergetool used its autodetection system to guess which tool to use.
>>> +   Users who explicitly specify or configure a tool will no longer see
>>> +   the prompt by default.
>>> +
>>> +   Strictly speaking, this is a backward incompatible change and
>>>     users need to explicitly set the variable to 'true' if they want
>>> -   to resurrect the now-ignored use case.
>>> +   to resurrect the old behaviour.
>>
>> I however think you are losing information here.  It is unclear in
>> the rewritten one why you would ever want the "old" behaviour, i.e.
>> what you may be missing by following along with this change.
> 
> Perhaps this on top of yoru patch?

Yes, I think that's good, thanks.

		M.


>  Documentation/RelNotes/2.1.0.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/RelNotes/2.1.0.txt b/Documentation/RelNotes/2.1.0.txt
> index 4fd153e..1b16b12 100644
> --- a/Documentation/RelNotes/2.1.0.txt
> +++ b/Documentation/RelNotes/2.1.0.txt
> @@ -95,7 +95,7 @@ UI, Workflows & Features
>  
>     Strictly speaking, this is a backward incompatible change and
>     users need to explicitly set the variable to 'true' if they want
> -   to resurrect the old behaviour.
> +   to be prompted to confirm running the tool on each path.
>  
>   * "git replace" learned the "--edit" subcommand to create a
>     replacement by editing an existing object.
> 
