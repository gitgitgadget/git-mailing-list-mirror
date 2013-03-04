From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 2/5] Help.c use OPT_COUNTUP
Date: Mon, 4 Mar 2013 00:31:33 -0000
Organization: OPDS
Message-ID: <F455D17A40C2498C84F85E2937B732AC@PhilipOakley>
References: <1362342072-1412-1-git-send-email-philipoakley@iee.org> <1362342072-1412-3-git-send-email-philipoakley@iee.org> <7vwqtoyryp.fsf@alter.siamese.dyndns.org> <EE36F065A5DA4769989FC7345DF7BCE6@PhilipOakley> <7v4ngsyqpx.fsf@alter.siamese.dyndns.org>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "GitList" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 04 01:31:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCJJB-0002se-Qt
	for gcvg-git-2@plane.gmane.org; Mon, 04 Mar 2013 01:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768Ab3CDAas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Mar 2013 19:30:48 -0500
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:14596 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754655Ab3CDAas (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Mar 2013 19:30:48 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AgMFACjTM1FZ8rke/2dsb2JhbABFjAy2Pn0Xc4IaBQEBBQgBAS4eAQEhCwIDBQIBAxUBCyUUAQQaBgcXBhMIAgECAwGIBscZjj5fgmZhA4g2hWSSEIcIgwg
X-IronPort-AV: E=Sophos;i="4.84,774,1355097600"; 
   d="scan'208";a="401821396"
Received: from host-89-242-185-30.as13285.net (HELO PhilipOakley) ([89.242.185.30])
  by out1.ip04ir2.opaltelecom.net with SMTP; 04 Mar 2013 00:30:41 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217387>

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Monday, March 04, 2013 12:05 AM
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>>> Hrm, I do not recall anybody ever declared that "--all" is 
>>> deprecated.
>>
>> No, it was the use OPT_COUNTUP rather than OPT_BOOLEAN that the
>> deprecated' was refering to.
>
> Oh, no OPT_BOOLEAN was deprecated because too many people rightfully
> thought it was about 0/1 choice and got burned by its count-up
> behaviour.  When you want to count-up, OPT_COUNTUP is the right
> thing to do and replacing deprecated BOOLEAN with it is a correct
> thing to do.  But for this optoin, I do not think you want to count
> up in the first place.  You want a 0/1 choice, which is written as
> OPT_BOOL these days.

Ah, I missed that.

Though, for the longer term --guides usage, I'd envisaged that having it 
a second time could be used to invoke some extra search code that would 
list all guides, rather than just the short list of common guides. But 
I'm not sure how best to determine what are valid guides, including 
Msysgit/Git4Windows which only uses the html versions (no man command), 
so I'll use OPT_BOOL initially.

Philip 
