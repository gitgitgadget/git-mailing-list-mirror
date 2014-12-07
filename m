From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: How to repair a shallow clone (?)
Date: Sun, 7 Dec 2014 11:05:22 -0000
Organization: OPDS
Message-ID: <C4634931164E4141BEC9D1395D80CF9B@PhilipOakley>
References: <5482F55F.1060008@web.de> <5483A166.4010109@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Dec 07 12:12:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxZlF-0003AA-8t
	for gcvg-git-2@plane.gmane.org; Sun, 07 Dec 2014 12:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbaLGLFY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Dec 2014 06:05:24 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:27989 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753018AbaLGLFX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Dec 2014 06:05:23 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AkwWALIzhFQCYJpWPGdsb2JhbABagwZSWIMFhBq/BIF5AYQRAQMBAYEOFwEBAQEBAQUBAQEBOCAbg30FAQEBAQMIAQEZDwEFHgEBIQsCAwUCAQMVAwICBSECAhQBBAgSBgcDFAYBEggCAQIDAYgVAxYJvjyGZ4kNDYV1DCCBKIx6gi2CdjKBFQWPRlyDIoQygws0i1iCL4dRPzCCQwEBAQ
X-IPAS-Result: AkwWALIzhFQCYJpWPGdsb2JhbABagwZSWIMFhBq/BIF5AYQRAQMBAYEOFwEBAQEBAQUBAQEBOCAbg30FAQEBAQMIAQEZDwEFHgEBIQsCAwUCAQMVAwICBSECAhQBBAgSBgcDFAYBEggCAQIDAYgVAxYJvjyGZ4kNDYV1DCCBKIx6gi2CdjKBFQWPRlyDIoQygws0i1iCL4dRPzCCQwEBAQ
X-IronPort-AV: E=Sophos;i="5.07,533,1413241200"; 
   d="scan'208";a="767740048"
Received: from host-2-96-154-86.as13285.net (HELO PhilipOakley) ([2.96.154.86])
  by out1.ip01ir2.opaltelecom.net with SMTP; 07 Dec 2014 11:05:21 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260987>

=46rom: "Tr=E1=BA=A7n Ng=E1=BB=8Dc Qu=C3=A2n" <vnwildman@gmail.com>
> On 06/12/2014 19:23, Torsten B=C3=B6gershausen wrote:
>> I think I started to clone the repo in a shallow way
>> (SparkleShare asked if I want to clone the complete history,
>> and I probably answered "no" )
>>
>> Is there a way to repair this situation ?
>> (Except doing a complete re-clone ?)
>>
> I think git don't accept push from shallow repo. I've ever encounter
> this problem. I UNshallow it, then every thing will work:
>
> $ git fetch --unshallow origin
>
> This command will convert a shallow repository to a complete one.
> See git-fetch(1) and git-clone(1).
>
Since v1.9.0 (14 Feb '14.) you can do various push/pull from a shallow=20
clone (I'd asked this way back=20
http://stackoverflow.com/questions/6900103/why-cant-i-push-from-a-shall=
ow-clone=20
and noted when it was corrected/improved)

That's not to say that you don't have to take care about your local=20
depth being sufficiently inclusive.

I'm sure that sometime a --timedepth=3D<time_t time> will eventually be=
=20
coded by someone sufficiently in need. ;-)

--
Philip=20
