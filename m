From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/6] Make 'git help everyday' work -> relnotes
Date: Tue, 21 Jan 2014 22:25:26 -0000
Organization: OPDS
Message-ID: <BA4E87FA92ED4E8FB2C00F013BD7B3FF@PhilipOakley>
References: <1389309192-5748-1-git-send-email-philipoakley@iee.org> <xmqqppo090m7.fsf@gitster.dls.corp.google.com> <52CFACBB.7000805@atlas-elektronik.com> <F11CD558C63947F9B4AA75501D2F9F62@PhilipOakley> <52D91B0E.6080000@atlas-elektronik.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "GitList" <git@vger.kernel.org>
To: =?utf-8?Q?Stefan_N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Tue Jan 21 23:25:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W5jlM-0008Ly-N3
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jan 2014 23:25:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbaAUWZh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Jan 2014 17:25:37 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:3280 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752353AbaAUWZg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jan 2014 17:25:36 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhtGALnz3lICYJZt/2dsb2JhbABagwtIA4NAhT6zLwECAQELgQoXdGkBAYEfAQEUAQQBAQEBAgEIAQEZBAsBBR4BASELAgMFAgEDFQUCBSECAhQBBBoGBxcGEwgCAQIDAYU4BwGCExkMplGcIxeBKY1WNYJBNYEUBI8mmxSDLTw
X-IPAS-Result: AhtGALnz3lICYJZt/2dsb2JhbABagwtIA4NAhT6zLwECAQELgQoXdGkBAYEfAQEUAQQBAQEBAgEIAQEZBAsBBR4BASELAgMFAgEDFQUCBSECAhQBBBoGBxcGEwgCAQIDAYU4BwGCExkMplGcIxeBKY1WNYJBNYEUBI8mmxSDLTw
X-IronPort-AV: E=Sophos;i="4.95,697,1384300800"; 
   d="scan'208";a="433411793"
Received: from host-2-96-150-109.as13285.net (HELO PhilipOakley) ([2.96.150.109])
  by out1.ip04ir2.opaltelecom.net with SMTP; 21 Jan 2014 22:25:23 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240781>

=46rom: "Stefan N=C3=A4we" <stefan.naewe@atlas-elektronik.com>
> Am 16.01.2014 22:14, schrieb Philip Oakley:
>> From: "Stefan N=C3=A4we" <stefan.naewe@atlas-elektronik.com>
>> [...]
>>>
>>> I'd really like to see 'git help relnotes' working as well...
>>>
>>> Stefan
>>
>> Stefan,
>>
>> Were you thinking that all the release notes would be quoted verbati=
m=20
>> in
>> the one long man page?
>>
>> Or that it would be a set of links to each of the individual text=20
>> files
>> (see the ifdef::stalenotes[] in git/Documentation/git.txt)?
>>
>> The latter allows individual release notes to be checked, but still
>> leaves folks with a difficult search problem if they want to find=20
>> when
>> some command was 'tweaked'.
>>
>> Obviously, any method would need to be easy to maintain. And the
>> RelNotes symlink would need handling.
>
> 'git help relnotes' should show the current release note with
> a link to the previous.

OK, that seems very sensible, as the concatenated release notes run to=20
15k lines!

Determining which is the current release note is possibly more=20
problematic, which should be when making the documentation.

>
> And 'git help git' should link to the current release note.
>
In some sense that 'current' should be the same as the 'git --version',=
=20
but through an assumption of a common distribution of git and the=20
documentation, rather than any run time determination.

At the moment the Documenation/git.txt 'stalenotes' section could be=20
separated into its own file to act as the basis for the links, but as=20
yet I don't have a good view as to how the current release notes (with =
/=20
without maint notes?) would be embedded without a maintenance burden fo=
r=20
Junio.

Philip=20
