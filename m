From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: Our cumbersome mailing list workflow
Date: Wed, 3 Dec 2014 23:57:47 -0000
Organization: OPDS
Message-ID: <221286D608764D5EA342E08097333279@PhilipOakley>
References: <1416423000-4323-1-git-send-email-sbeller@google.com>	<1416578950-23210-1-git-send-email-mhagger@alum.mit.edu>	<546F4B5B.2060508@alum.mit.edu> <xmqq61e81ljq.fsf@gitster.dls.corp.google.com> <5473CD28.5020405@alum.mit.edu>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="Windows-1252";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Stefan Beller" <sbeller@google.com>,
	"Jonathan Nieder" <jrnieder@gmail.com>,
	"Ronnie Sahlberg" <sahlberg@google.com>, <git@vger.kernel.org>
To: "Michael Haggerty" <mhagger@alum.mit.edu>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 00:57:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwJnq-0001I1-Vp
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 00:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752442AbaLCX5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 18:57:47 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:20049 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751639AbaLCX5q (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Dec 2014 18:57:46 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuUYACmif1ROl3OcPGdsb2JhbABaDoJ4gSqGNWzBKAGEFQQCgRYXAQEBAQEBBQEBAQE4IBuDfQUBAQEBAwgBAS4eAQEWCwsCAwUCAQMOBwECCSUUAQQaBgcDFAYBEggCAQIDAYgxxwCPXAEBAQEBBQEBAQEekAQRAVCDK4EeBZAPXosOjwuHIj8/MIEMgTkBAQE
X-IPAS-Result: AuUYACmif1ROl3OcPGdsb2JhbABaDoJ4gSqGNWzBKAGEFQQCgRYXAQEBAQEBBQEBAQE4IBuDfQUBAQEBAwgBAS4eAQEWCwsCAwUCAQMOBwECCSUUAQQaBgcDFAYBEggCAQIDAYgxxwCPXAEBAQEBBQEBAQEekAQRAVCDK4EeBZAPXosOjwuHIj8/MIEMgTkBAQE
X-IronPort-AV: E=Sophos;i="5.07,511,1413241200"; 
   d="scan'208";a="478967228"
Received: from host-78-151-115-156.as13285.net (HELO PhilipOakley) ([78.151.115.156])
  by out1.ip04ir2.opaltelecom.net with SMTP; 03 Dec 2014 23:57:42 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260716>

From: "Michael Haggerty" <mhagger@alum.mit.edu>
Sent: Tuesday, November 25, 2014 12:28 AM
> On 11/21/2014 07:00 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>
>>> I don't think that those iterations changed anything substantial 
>>> that
>>> overlaps with my version, but TBH it's such a pain in the ass 
>>> working
>>> with patches in email that I don't think I'll go to the effort of
>>> checking for sure unless somebody shows interest in actually using 
>>> my
>>> version.
>>>
>>> Sorry for being grumpy today :-(
[..]
> Let me list the aspects of our mailing list workflow that I find
> cumbersome as a contributor and reviewer:
>
> * Submitting patches to the mailing list is an ordeal of configuring
> format-patch and send-email and getting everything just right, using
> instructions that depend on the local environment. We saw that hardly
> any GSoC applicants were able to get it right on their first attempt.
> Submitting a patch series should be as simple as "git push".
>
> * Once patches are submitted, there is no assurance that you (Junio)
> will apply them to your tree at the same point that the submitter
> developed and tested them.
>
> * The branch name that you choose for a patch series is not easily
> derivable from the patches as they appeared in the mailing list. 
> Trying
> to figure out whether/where the patches exist in your tree is a 
> largely
> manual task. The reverse mapping, from in-tree commit to the email 
> where
> it was proposed, is even more difficult to infer.
>
> * Your tree has no indication of which version of a patch series (v1,
> v2, etc) is currently applied.
>
> The previous three points combine to make it awkward to get patches 
> into
> my local repository to review or test. There are two alternatives, 
> both
> cumbersome and imprecise:
>
>  * I do "git fetch gitster", then try to figure out whether the branch
> I'm interested in is present, what its name is, and whether the 
> version
> in your tree is the latest version, then "git checkout xy/foobar".
>

I had a thought about the issue of version labeling and of keeping the 
old patch series hanging about during development that I felt was worth 
recording.

My thought was that while the cover letter and series version number are 
currently stripped out from the start of the series, they could be added 
back as a supplemental commit at the end of the series (an --allow-empty 
commit). This could contain all of the patch subject lines and their 
post '---' notes as appropriate.

Thus the series branch would appear to have an extra commit (compared to 
the current process) after the original tip's possible merge into say 
pu.

When subsequent series are sent to the list, the new supplemental commit 
would be a 'merge', with its second parent being the old series, thus 
the old series is not lost until the branch is deleted, and the existing 
merge pattern is retained.

Clearly if this would need some additional coding as it's not suitable 
as a manual process, but it could be just as automatic as the current 
process while providing that little bit of additional visibility.

Below, I've tried to set out how the commit graph might look (oldest to 
the left). Hopefully my MUA won't ruin it.
The first patch series branches at A, and is merged at D, with the 
supplemental commit labeled with v1z.

When the new series arrives, and pu is rewound, we have the new series 
applied from G (which in reality may not be linked directly from A), and 
merged back at K. However the new v2z supplemental commit is now the 
po/patches
branch head, and is also a merge back to v1z.

patch series 1 (cover letter z)
- A - B - C - D - E - F   <- pu
   \        /
    v1a-v1b--v1z     <-po/patches

patch series 2
- A - G - H - I - J - K     <- pu (note re-wound)
  |        \         /            (merge D lost)
   \       v2a-v2b-v2c--v2z    <-po/patches
    \                  /
    v1a-v1b--v1z - - -.

The key idea here is to use the existing branching model, but then to 
add the cover letter and other details at the end, rather than the 
beginning as might have been expected from the email transmit sequence.

Philip
