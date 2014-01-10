From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/6] Make 'git help everyday' work
Date: Fri, 10 Jan 2014 08:06:28 -0000
Organization: OPDS
Message-ID: <0AB7145111924BA986B1E172CD293B1D@PhilipOakley>
References: <1389309192-5748-1-git-send-email-philipoakley@iee.org> <xmqqppo090m7.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 10 09:06:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1X6p-0006fj-Ar
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 09:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbaAJIGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 03:06:24 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:61809 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751152AbaAJIGW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Jan 2014 03:06:22 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgwZANSpz1JOl3z1/2dsb2JhbABZgwuJSrB/AQIBAYEGF3RpAQGBHwEBFAEEAQEBAQIBCAEBLh4BASELAgMFAgEDFQwlFAEEGgYHFwYTCAIBAgMBhTgHAYISGQzDLhePBYMrgRMEiQuGE5sOgy08
X-IPAS-Result: AgwZANSpz1JOl3z1/2dsb2JhbABZgwuJSrB/AQIBAYEGF3RpAQGBHwEBFAEEAQEBAQIBCAEBLh4BASELAgMFAgEDFQwlFAEEGgYHFwYTCAIBAgMBhTgHAYISGQzDLhePBYMrgRMEiQuGE5sOgy08
X-IronPort-AV: E=Sophos;i="4.95,637,1384300800"; 
   d="scan'208";a="441549668"
Received: from host-78-151-124-245.as13285.net (HELO PhilipOakley) ([78.151.124.245])
  by out1.ip05ir2.opaltelecom.net with SMTP; 10 Jan 2014 08:06:20 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240295>

From: "Junio C Hamano" <gitster@pobox.com>
>I think we already use a nicer way to set up a page alias to keep
> old links working than making a copy in Documentation/; please mimic
> that if possible.

This was mainly about ensuring that the 'git help' command could access 
these extra extra guides that it currently misses. (Tt also misses the 
'user-manual', which isn't a man page, but could have a link page to 
guide the seeker of truth between 'git help' and the actual user-manual)

The only method I can see for that (via help.c) is to get the filename 
format correct.  Where you thinking of something else?

>
> It may be overdue to refresh the suggested set of "top 20" commands,
> as things have vastly changed over the past 8 years.  Perhaps we
> should do that after reorganizing with something like this series.

Agreed.

> --
