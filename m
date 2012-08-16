From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] man: git pull -r is a short for --rebase
Date: Thu, 16 Aug 2012 23:36:11 +0100
Organization: OPDS
Message-ID: <B7310EA0CC00423EB5B26E3FAAB54541@PhilipOakley>
References: <20120816095018.GD5489@suse.cz> <7v1uj63iyx.fsf@alter.siamese.dyndns.org> <2BB1E674DD214C66B06660612F34109D@PhilipOakley> <7vk3wy1t7l.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@suse.cz>, "Git List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 17 00:36:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T28fw-0003V8-2N
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 00:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933466Ab2HPWgE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 18:36:04 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:19230 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932521Ab2HPWgB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Aug 2012 18:36:01 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aq0NAJZ0LVBcHKfT/2dsb2JhbABFi0CtcwQBAQJ3gQiCGwUBAQUIAQEuHgEBIQsCAwUCAQMVAQslFAEEGgYHFwYTCAIBAgMBiAC6c4sKVzSBB4NlYAOIGYVCmAaCYA
X-IronPort-AV: E=Sophos;i="4.77,781,1336345200"; 
   d="scan'208";a="44892939"
Received: from host-92-28-167-211.as13285.net (HELO PhilipOakley) ([92.28.167.211])
  by out1.ip07ir2.opaltelecom.net with SMTP; 16 Aug 2012 23:35:59 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Thursday, August 16, 2012 9:23 PM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> I wasn't aware of the  "abbreviated options" capability. Is meant to
>> be in the man pages as I couldn't find it, or is it described
>> differently?
>
> $ git help gitcli
>
> is the closest that comes to mind.
>
> If it is not reachable from "git help git", we may want to sprinkle
> some more linkgit:gitfoo[$n] around the documentation sources.  I
> didn't check.
>

I eventually found a reference in the parse-options API to the fact that
'Long options may be abbreviated, as long as the abbreviation is
unambiguous.'

It may be worth bringing some of those parse-options API basics bullets'
forward into the gitcli page, if appropriate.
