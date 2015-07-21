From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2b 00/16, 2 updates] Make the msvc-build scripts work again
Date: Tue, 21 Jul 2015 17:46:00 +0100
Organization: OPDS
Message-ID: <73004CECB3514744A5916831B4501689@PhilipOakley>
References: <1437432846-5796-1-git-send-email-philipoakley@iee.org> <xmqq1tg2xwbd.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 20:45:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHcXO-0005XT-Ou
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 20:45:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933412AbbGUSpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2015 14:45:03 -0400
Received: from out1.ip06ir2.opaltelecom.net ([62.24.128.242]:7024 "EHLO
	out1.ip06ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933274AbbGUSpB (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2015 14:45:01 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2BICQDPka5VPMS/BlxcgxOBPYZQbbxKBAQCgUBNAQEBAQEBBwEBAQFBJBuEHgUBAQEBAgEIAQEuHgEBDxILAgMFAgEDFQwlFAEEGgYHAxQGEwgCAQIDAYgVDLwtkAmLTIUGgx6BFAWMcIdjAYENpCqBCWaCND0xgksBAQE
X-IPAS-Result: A2BICQDPka5VPMS/BlxcgxOBPYZQbbxKBAQCgUBNAQEBAQEBBwEBAQFBJBuEHgUBAQEBAgEIAQEuHgEBDxILAgMFAgEDFQwlFAEEGgYHAxQGEwgCAQIDAYgVDLwtkAmLTIUGgx6BFAWMcIdjAYENpCqBCWaCND0xgksBAQE
X-IronPort-AV: E=Sophos;i="5.15,517,1432594800"; 
   d="scan'208";a="685649084"
Received: from host-92-6-191-196.as43234.net (HELO PhilipOakley) ([92.6.191.196])
  by out1.ip06ir2.opaltelecom.net with ESMTP; 21 Jul 2015 19:44:58 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274394>

From: "Junio C Hamano" <gitster@pobox.com>
> Philip Oakley <philipoakley@iee.org> writes:
>
>> This updates two patches in the series based on Eric Sunshine's
>> comments.
>>
>> Patch 8b updates the commit message to make clear what was going
>> wrong.
>>
>> Patch 10b improves the perl code.
>
> Is v2b like saying v3 or something else?  Does 8b replaces 8 or
> updates it (i.e. comes between 8 and 9)?


Sorry for the confusion. Yes these are quick replacements, rather than
re-rolling the whole series immediately.

>
>> Junio: would a full re-roll be appropriate at a suitable point?
>
> Probably, but I'd like to see people try it out and give positive
> feedback first.  This part of the tree I can give no input or pre-
> pushout testing at all.

It has been tried out on the Msysgit list, and also against the github
Pull Request, with responses noted there.

I'll do another branch / rebase and PR onto the G4W SDK as well,
for an extra chance at getting more replies. Ideally, if part of this
mainstream Git, it would get picked up automatically by them
(rather than being local 'fixes' endlessly carried forward).

>
> Who are the people involved in this part of the system in the past?
> Does "shortlog -n --no-merges contrib/buildsystems compat/vcbuild"
> tell us anything?
>

There has been no activity here on the 'create a visual studio project'
aspects in the last few years. Any changes listed in the logs relate to
ensuring that the MSVC compiler will run as part of a regular Makefile
run (IIUC). The last significant commit was 74cf9bd (engine.pl: Fix a
recent breakage of the buildsystem generator, 2010-01-22) Ramsay Jones,
so that's five and a half years. Mind you, it's taken me a while to find 
all
the bit rots.

>
>> Philip Oakley (2):
>
