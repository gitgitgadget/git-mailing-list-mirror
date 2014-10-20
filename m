From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] doc: fix 'git status --help' character quoting
Date: Mon, 20 Oct 2014 12:31:06 +0100
Organization: OPDS
Message-ID: <9FDB0D39D62C46ABA8D2C5356E497BE1@PhilipOakley>
References: <1413728235-1504-1-git-send-email-philipoakley@iee.org> <xmqqwq7vr91j.fsf@gitster.dls.corp.google.com> <8D139BC1FB1E4335B4375FB0F056BB0B@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 20 13:31:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgBBA-0002i2-QY
	for gcvg-git-2@plane.gmane.org; Mon, 20 Oct 2014 13:31:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbaJTLa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2014 07:30:58 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:17659 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753764AbaJTLap (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Oct 2014 07:30:45 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArYMAAjyRFROl3LyPGdsb2JhbABcgw5TiBWBBMNfh0sEBAKBERcBAQUBAQEBODuDfQUBAQEBAgEIAQEuHgEBIQUGAgMFAgEDFQwlFAEEGgYHAxQGEwgCAQIDAYgmDLU3jUaQUYM0gR4FiySGXF2DaYh/mC48L4JLAQEB
X-IPAS-Result: ArYMAAjyRFROl3LyPGdsb2JhbABcgw5TiBWBBMNfh0sEBAKBERcBAQUBAQEBODuDfQUBAQEBAgEIAQEuHgEBIQUGAgMFAgEDFQwlFAEEGgYHAxQGEwgCAQIDAYgmDLU3jUaQUYM0gR4FiySGXF2DaYh/mC48L4JLAQEB
X-IronPort-AV: E=Sophos;i="5.04,755,1406588400"; 
   d="scan'208";a="474462824"
Received: from host-78-151-114-242.as13285.net (HELO PhilipOakley) ([78.151.114.242])
  by out1.ip04ir2.opaltelecom.net with SMTP; 20 Oct 2014 12:30:42 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Philip Oakley" <philipoakley@iee.org>
> From: "Junio C Hamano" <gitster@pobox.com>
>> Philip Oakley <philipoakley@iee.org> writes:
..
>>
>>> While at it, use 00 for ASCII NUL to avoid any confusion with the 
>>> letter O.

> (remember its quotation is consumed by ascidoc) looked too much like 
> an
I mis-remembered. It's not quoted.

> Looking around some more, it's as if "0)" is special cased in some 
> conversion to HTML.

This looks to be an issue of the browser display font 
(Chrome/Chromium/Firefox) where it's almost impossible to distinguish 0 
and o without other numbers or letters being present for context. The 
old kernel.org page appears to specify the font differently and thus 
provides a clear rendering.

Philip 
