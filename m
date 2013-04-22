From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 22:00:01 +0100
Organization: OPDS
Message-ID: <B91DA87BC1F548ECB1FDB9550F4AB017@PhilipOakley>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com> <87ppxmogdv.fsf@linux-k42r.v.cablecom.net> <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com> <87wqruk2pj.fsf@linux-k42r.v.cablecom.net> <CALkWK0mUH2m5zJ4MwPWC85CsZZ=2RODumLvsF9q3rLj-+d7vBw@mail.gmail.com> <CALkWK0n5gaz3A7kHT6+5z3YkYdpgU5p6Pv4heMbLzikTbROwkA@mail.gmail.com> <CALkWK0k0LbAnkhAAqdeAvBnCig_HO+bT+WiQuQQ3Fgc=FzFtRw@mail.gmail.com> <87zjwqpebl.fsf@hexa.v.cablecom.net> <CALkWK0kVDbyQBTSTbEDoVFs8E6JKWw3Z6L77NCXSb=FU8GNDkw@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Ramkumar Ramachandra" <artagnon@gmail.com>,
	"Thomas Rast" <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Apr 22 22:59:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUNqB-0000j4-5n
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 22:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753559Ab3DVU7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 16:59:54 -0400
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:21357 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753082Ab3DVU7x (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Apr 2013 16:59:53 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvANABGkdVFOl3ma/2dsb2JhbABQgwaDZ4U/uBQEAQMBgQUXdIIaBQEBBQgBARkVHgEBIQsCAwUCAQMOBwECAgIFIQICFAEECBIGBxcGARIIAgECAwGHcQMTqkqIVQ2IRoEji0WBbWpqgVEyYQOOToZjjWCFHoJ/Djs
X-IronPort-AV: E=Sophos;i="4.87,529,1363132800"; 
   d="scan'208";a="421589419"
Received: from host-78-151-121-154.as13285.net (HELO PhilipOakley) ([78.151.121.154])
  by out1.ip03ir2.opaltelecom.net with SMTP; 22 Apr 2013 21:59:51 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222090>

From: "Ramkumar Ramachandra" <artagnon@gmail.com>
Sent: Monday, April 22, 2013 8:54 PM
> Thomas Rast wrote:
>> There is a market for a rename detection that works at the tree 
>> level.
>
> Exactly.  And making it auto-follow with a low threshold would be a
> great default.  We'll have to deal with D/F conflicts that Junio was
> talking about in (2), every once in a while.  We'll have a lot more
> incentive to build the D/F conflict resolution process a nice UI.
>
> git-core will actually start working with trees the way it works with 
> blobs.
> --

Is this not similar to the previous attempts at bulk rename detection? 
Such as $gmane/160233.

A practical bulk rename detection would be good. It doesn't have to be 
perfect.

Philip 
