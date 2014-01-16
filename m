From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/6] Make 'git help everyday' work -> relnotes
Date: Thu, 16 Jan 2014 21:14:10 -0000
Organization: OPDS
Message-ID: <F11CD558C63947F9B4AA75501D2F9F62@PhilipOakley>
References: <1389309192-5748-1-git-send-email-philipoakley@iee.org> <xmqqppo090m7.fsf@gitster.dls.corp.google.com> <52CFACBB.7000805@atlas-elektronik.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "GitList" <git@vger.kernel.org>
To: =?utf-8?Q?Stefan_N=C3=A4we?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Thu Jan 16 22:14:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3uGR-0000da-AB
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jan 2014 22:14:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbaAPVOH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Jan 2014 16:14:07 -0500
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:25841 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750784AbaAPVOG (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Jan 2014 16:14:06 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqoYAHlK2FJZ8YEW/2dsb2JhbABZgwuEDIU+slEBAgEBgQ4XdGkBAYEfAQEUAQQBAQEBAwgBARkECwEFHgEBIQsCAwUCAQMVBQIFIQICFAEEGgYHFwYTCAIBAgMBhTgHAYISJakOnCQXgSmNVoJ2NYEUBI8lmxODLTw
X-IPAS-Result: AqoYAHlK2FJZ8YEW/2dsb2JhbABZgwuEDIU+slEBAgEBgQ4XdGkBAYEfAQEUAQQBAQEBAwgBARkECwEFHgEBIQsCAwUCAQMVBQIFIQICFAEEGgYHFwYTCAIBAgMBhTgHAYISJakOnCQXgSmNVoJ2NYEUBI8lmxODLTw
X-IronPort-AV: E=Sophos;i="4.95,669,1384300800"; 
   d="scan'208";a="95330760"
Received: from host-89-241-129-22.as13285.net (HELO PhilipOakley) ([89.241.129.22])
  by out1.ip07ir2.opaltelecom.net with SMTP; 16 Jan 2014 21:14:04 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240535>

=46rom: "Stefan N=C3=A4we" <stefan.naewe@atlas-elektronik.com>
[...]
>
> I'd really like to see 'git help relnotes' working as well...
>
> Stefan

Stefan,

Were you thinking that all the release notes would be quoted verbatim i=
n=20
the one long man page?

Or that it would be a set of links to each of the individual text files=
=20
(see the ifdef::stalenotes[] in git/Documentation/git.txt)?

The latter allows individual release notes to be checked, but still=20
leaves folks with a difficult search problem if they want to find when=20
some command was 'tweaked'.

Obviously, any method would need to be easy to maintain. And the=20
RelNotes symlink would need handling.

Philip

--
