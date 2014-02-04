From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/PATCH] howto/maintain-git.txt: new version numbering scheme
Date: Tue, 4 Feb 2014 21:03:48 -0000
Organization: OPDS
Message-ID: <43FB93CCA3984B8890CA448E9E75E44E@PhilipOakley>
References: <xmqqfvo3hhhe.fsf@gitster.dls.corp.google.com><9E6F99D96D124571897121E4227508EF@PhilipOakley> <xmqqa9e7bvfv.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 04 22:05:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAnB4-0006S8-B2
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 22:05:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933724AbaBDVEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 16:04:05 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:29476 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933711AbaBDVDx (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Feb 2014 16:03:53 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtY2AFNV8VICYJR6/2dsb2JhbABPCoMMSAOJA7VYAQIBAQeBBxd0giAFAQEEAQgBAR0RHgEBIQUGAgMFAgEDFQwlFAEEGgYHFwYTCAIBAgMBCIdkDM4yjhlcNYJ2gRQEiRGGGIUZlgqDLTw
X-IPAS-Result: AtY2AFNV8VICYJR6/2dsb2JhbABPCoMMSAOJA7VYAQIBAQeBBxd0giAFAQEEAQgBAR0RHgEBIQUGAgMFAgEDFQwlFAEEGgYHFwYTCAIBAgMBCIdkDM4yjhlcNYJ2gRQEiRGGGIUZlgqDLTw
X-IronPort-AV: E=Sophos;i="4.95,781,1384300800"; 
   d="scan'208";a="448914631"
Received: from host-2-96-148-122.as13285.net (HELO PhilipOakley) ([2.96.148.122])
  by out1.ip03ir2.opaltelecom.net with SMTP; 04 Feb 2014 21:03:47 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241554>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> If we are progressing from V1.9 to V2.0 quickly (one cycle?), which I
>> understand is the plan, then mixing the minor development items 
>> (patch
>> series which progress to master) with the maintenance fixes over the
>> next few months, thus only having 1.9.x releases, sounds reasonable.
>>
>> If there is going to be separate maintenance fixes from the patch 
>> series
>> developments then keeping to the previous 1.9.x.y for maintenance 
>> would
>> be better.
>>
>> Will the new rapid counting continue after V2.0, such that we get to
>> V2.9 -> V3.0 rather more quickly than V1.0 -> V2.0 ?
>>
>> The key discriminator would be to say when V2.0 will be out for 
>> deciding
>> the V1.9 sequence.
>
> I do not quite follow.  The time distance between v1.9 and v2.0
> should not affect anything.  If it is a long road, there may be
> v1.10, v1.11, v1.12, ...

I wasn't sure if you were considering going past either 1.9.9 to 1.9.10, 
and going from 1.9 to 1.10 was something that hadn't occurred to me 
(somewhat of a Doh! moment maybe).


>            before we have v2.0.  If not, v2.0 may
> immediately follow v1.9 as a new feature release.  There may be
> maintenance releases based on v1.9 that does not add any new
> features.
>
> Right now, if you count the maintenance releases, there are
> potentially four kinds of version gaps:
>
> - Between v1.8.5 and v1.8.5.1, there are fixes but no new features;
>
> - Between v1.8.5 and v1.8.6, there are new features but no
>   compatibility worries;
>
> - Between v1.8.6 and v1.9.0, there are new features, no
>   compatibility worries, but somehow the jump is larger than the
>   one between v1.8.5 and v1.8.6; and
>
> - Between v1.9.0 and v2.0.0, there are new features and also
>   compatibility concerns.
>
> Switching to 2-digit scheme and calling the upcoming one v1.9 (and
> the next major one v2.0) was meant to make the naming more flat,

OK I'd buy that flattening approach.

>    as
> the third item in the above list "somehow the jump is larger" does
> not seem to add much value to the end users.  So the logical
> numbering becomes more like this:
>
> - Between v1.9 and v1.9.1, there are fixes but no new features;
>
> - Between v1.9.x and v1.10, there are new features but no
>   compatibility worries;
>
> - Between v1.9.x and v2.0, there are new features and also
>   compatibility concerns.
>
> With a twist, though.  There seem to be many places where at least
> three digits are assumed to exist in our version numbers, so in
> order to make life easier, the updated document says vX.Y (a feature
> release) will identify itself as vX.Y.0

Yes. I'd be happy to support that third 'digit' for the maint releases, 
with zero as the initial release.

Git Gui has a version string checking routine but its regex only needs 
two parts X.Y (we looked into the version string back in $gmane/217189

>
>

Thanks for the clarifications.
Philip. 
