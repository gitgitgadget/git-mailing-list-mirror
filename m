From: "Philip Oakley" <philipoakley@iee.org>
Subject: Everday contents (was part of Re: What's cooking in git.git (Jul 2014, #04; Tue, 22))
Date: Sat, 2 Aug 2014 18:28:58 +0100
Organization: OPDS
Message-ID: <35435A61F3C04DC8924B2E2329F9461E@PhilipOakley>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com><B6FB0C239E6E4E2489FAB9EF1C902988@PhilipOakley><xmqqegxcdjzl.fsf@gitster.dls.corp.google.com><7ACC0F5AD23E4C839D2F819B23DA9564@PhilipOakley><xmqqvbqm74v7.fsf@gitster.dls.corp.google.com> <xmqqegx95bxc.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 02 19:29:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDd7F-0006Ao-Fx
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 19:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712AbaHBR27 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 13:28:59 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:45704 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754547AbaHBR27 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Aug 2014 13:28:59 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: An0rAIge3VMCYJjrPGdsb2JhbABZgw1SEQFFhy+BBMNdh0oFAQIBAQx4FwUBAQEBODaDfgUBAQUIAQEuHgEBIQsCAwUCARgBCyUUAQQaBgcDFAYTCAIBAgMBiDW2TJA2F4wdgk0RAVA1gwGBHAWKVYcIlh2KcoFHPC+BDQ
X-IPAS-Result: An0rAIge3VMCYJjrPGdsb2JhbABZgw1SEQFFhy+BBMNdh0oFAQIBAQx4FwUBAQEBODaDfgUBAQUIAQEuHgEBIQsCAwUCARgBCyUUAQQaBgcDFAYTCAIBAgMBiDW2TJA2F4wdgk0RAVA1gwGBHAWKVYcIlh2KcoFHPC+BDQ
X-IronPort-AV: E=Sophos;i="5.01,787,1400022000"; 
   d="scan'208";a="506505590"
Received: from host-2-96-152-235.as13285.net (HELO PhilipOakley) ([2.96.152.235])
  by out1.ip03ir2.opaltelecom.net with SMTP; 02 Aug 2014 18:28:57 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254704>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Friday, July 25, 2014 11:08 PM
...
>
> | Individual Developer (Participant)[[Individual Developer 
> (Participant)]]
> | ------------------------------------------------------------------------

...
> | $ git pull git://git.kernel.org/pub/.../jgarzik/libata-dev.git ALL 
> <5>

Would I be right that "ALL" can simply be dropped as something from 
'back then' (13 Dec 2005 v0.99.9-516-g44db136) that I'm ignorant of?

...
> | <5> fetch from a specific branch from a specific repository and 
> merge.
> | <6> revert the pull.
> | <7> garbage collect leftover objects from reverted pull.
> | <8> from time to time, obtain official tags from the `origin`
> | and store them under `.git/refs/tags/`.
>
> This example works directly on 'master', which is not ideal.  If I
> were writing this today, I would have made it work on 'mine' branch,
> produced a patch series out of that branch relative to @{u}, threw
> in 'git send-email' invocation, and had "git pull" update the
> pristine 'mater' branch after "git checkout master".  Merging of
> work by jgarzik (i.e. not your upstream) would also have gone to its
> own branch, not to 'master'.
>
Slowly working through it ;-)

Ta.

Philip 
