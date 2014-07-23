From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: What's cooking in git.git (Jul 2014, #04; Tue, 22)
Date: Wed, 23 Jul 2014 07:56:52 +0100
Organization: OPDS
Message-ID: <B6FB0C239E6E4E2489FAB9EF1C902988@PhilipOakley>
References: <xmqq4my9f4qw.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: "Junio C Hamano" <gitster@pobox.com>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 23 08:57:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9qTx-0001ku-VV
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 08:56:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755644AbaGWG4y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 02:56:54 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:52751 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755346AbaGWG4x (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jul 2014 02:56:53 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Au0ZAGNbz1NOl35wPGdsb2JhbABZgw6BKYcvgQTGdwUBAgGBDBcEAQEBATg2g34FAQEEAQgBAS4eAQEmBgIDBQIBAxUMJRQBBBoGBwMUBgESCAIBAgMBiCkMrkWQSYwchmSBGAWKLIZxlWaMHjwv
X-IPAS-Result: Au0ZAGNbz1NOl35wPGdsb2JhbABZgw6BKYcvgQTGdwUBAgGBDBcEAQEBATg2g34FAQEEAQgBAS4eAQEmBgIDBQIBAxUMJRQBBBoGBwMUBgESCAIBAgMBiCkMrkWQSYwchmSBGAWKLIZxlWaMHjwv
X-IronPort-AV: E=Sophos;i="5.01,715,1400022000"; 
   d="scan'208";a="509852505"
Received: from host-78-151-126-112.as13285.net (HELO PhilipOakley) ([78.151.126.112])
  by out1.ip02ir2.opaltelecom.net with SMTP; 23 Jul 2014 07:56:51 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254059>

From: "Junio C Hamano" <gitster@pobox.com>
> --------------------------------------------------
> [Stalled]
>
>
> * po/everyday-doc (2014-01-27) 1 commit
> - Make 'git help everyday' work
>
> This may make the said command to emit something, but the source is
> not meant to be formatted into a manual pages to begin with, and
> also its contents are a bit stale.

> It may be a good first step in
> the right direction, but needs more work to at least get the
> mark-up right before public consumption.
>
> Will hold.
>

It's not clear to me which bits of mark-up are 'wrong' and must be 
reworked,
and which markup styles are just unusal and could wait until better eyes 
can
review the detailed content.

At the moment I'm guessing as to what changes to do, and falling down 
various
Asciidoc rabbit holes. I'd judged my initial changes as 'adequate' 
rather than
'good' because of that issue.

Philip
-- 
