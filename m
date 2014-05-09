From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: What's cooking in git.git (Apr 2014, #08; Fri, 25)
Date: Fri, 9 May 2014 18:51:24 +0100
Organization: OPDS
Message-ID: <EB47099AB5D848DD9FB6D66A4832DC96@PhilipOakley>
References: <xmqqoazpt45p.fsf@gitster.dls.corp.google.com> <20140425231953.GB3855@sigill.intra.peff.net> <536D080C.7030402@alum.mit.edu>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>,
	"Felipe Contreras" <felipe.contreras@gmail.com>
To: "Michael Haggerty" <mhagger@alum.mit.edu>,
	"Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 09 19:51:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WioxV-0006cy-1v
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 19:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756683AbaEIRvl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 May 2014 13:51:41 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:58308 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756360AbaEIRvk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 May 2014 13:51:40 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ak0mAE0VbVMCYJWP/2dsb2JhbABZDoJ4XwODLIU9vSMBAgEBCIERF3SCIAUBAQUIAQEZDwEFHgEBIQsCAwUCAQMOBwMCAgUhAgIUAQQaBgcXBgESCAIBAgMBiDSsUIVbnnEXgSqKGYIkazWCRzaBFQSQE5w2gnZBPA
X-IPAS-Result: Ak0mAE0VbVMCYJWP/2dsb2JhbABZDoJ4XwODLIU9vSMBAgEBCIERF3SCIAUBAQUIAQEZDwEFHgEBIQsCAwUCAQMOBwMCAgUhAgIUAQQaBgcXBgESCAIBAgMBiDSsUIVbnnEXgSqKGYIkazWCRzaBFQSQE5w2gnZBPA
X-IronPort-AV: E=Sophos;i="4.97,1019,1389744000"; 
   d="scan'208";a="611806173"
Received: from host-2-96-149-143.as13285.net (HELO PhilipOakley) ([2.96.149.143])
  by out1.ip06ir2.opaltelecom.net with SMTP; 09 May 2014 18:51:23 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248598>

=46rom: "Michael Haggerty" <mhagger@alum.mit.edu>
> On 04/26/2014 01:19 AM, Jeff King wrote:
>> On Fri, Apr 25, 2014 at 03:50:26PM -0700, Junio C Hamano wrote:
>> [...]
>>> * fc/publish-vs-upstream (2014-04-21) 8 commits
>>>  - sha1_name: add support for @{publish} marks
>>>  - sha1_name: simplify track finding
>>>  - sha1_name: cleanup interpret_branch_name()
>>>  - branch: display publish branch
>>>  - push: add --set-publish option
>>>  - branch: add --set-publish-to option
>>>  - Add concept of 'publish' branch
>>>  - t5516 (fetch-push): fix test restoration
>>>
>>>  Add branch@{publish}; it seems that this is somewhat different fro=
m
>>>  Ram and Peff started working on.  There were many discussion
>>>  messages going back and forth but it does not appear that the
>>>  design issues have been worked out among participants yet.
>>
>> [...]
>> As for the patches themselves, I have not reviewed them carefully,=20
>> and
>> would prefer not to. As I mentioned before, though, I would prefer=20
>> the
>> short "@{p}" not be taken for @{publish} until it has proven itself.
>
> Is it too late and/or impossible to think of a different name for=20
> either
> "push" or "publish" so that their single-letter abbreviations don't
> coincide?

I'd initially grated against the 'publish' name. I didn't feel as that=20
what I'd be pushing would be publish-worthy in the sense that when a=20
book is published it's also edited before release, unless=20
vanity-published.

=46or a basic triangular flow where the user is simply using a remote=20
server as a sort of backup (e.g. github) then I thought that "self" may=
=20
a suitable name, though it does feel too much of a specific case.

Part of the problem is that the DVCS style is new so there isn't a good=
=20
word for 'the other side of the river', that's neither upstream, nor=20
downstream, but a ferry crossing to another safe harbour.

I'm now sort of OK with push and publish being the same thing.

--
Philip
=C2=A30.02p=20
