From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 5/5] implement @{publish} shorthand
Date: Thu, 9 Jan 2014 08:39:44 -0000
Organization: OPDS
Message-ID: <02F63E901C46405BAAEEFBC48870A7C2@PhilipOakley>
References: <20140108093338.GA15659@sigill.intra.peff.net> <20140108093716.GE15720@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Git List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jeff King" <peff@peff.net>,
	"Ramkumar Ramachandra" <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 09 09:42:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1B9S-0001jG-Ir
	for gcvg-git-2@plane.gmane.org; Thu, 09 Jan 2014 09:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755557AbaAIIjj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jan 2014 03:39:39 -0500
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:30397 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752466AbaAIIji (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jan 2014 03:39:38 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvQYAPhfzlJOl3+v/2dsb2JhbABZgws4g1SFPrECAQECAQGBDBd0aQEBgR8BARQBBAEBAQEDCAEBGRUeAQEhCwIDBQIBAw4HAQQCBSECAhQBBBoGBxcGARIIAgECAwEKhS4HAYISJQmqCppfF4EpjVyCdjWBEwSPHoopkGWDLTw
X-IPAS-Result: AvQYAPhfzlJOl3+v/2dsb2JhbABZgws4g1SFPrECAQECAQGBDBd0aQEBgR8BARQBBAEBAQEDCAEBGRUeAQEhCwIDBQIBAw4HAQQCBSECAhQBBBoGBxcGARIIAgECAwEKhS4HAYISJQmqCppfF4EpjVyCdjWBEwSPHoopkGWDLTw
X-IronPort-AV: E=Sophos;i="4.95,630,1384300800"; 
   d="scan'208";a="94605848"
Received: from host-78-151-127-175.as13285.net (HELO PhilipOakley) ([78.151.127.175])
  by out1.ip07ir2.opaltelecom.net with SMTP; 09 Jan 2014 08:39:36 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240253>

From: "Jeff King" <peff@peff.net>
Sent: Wednesday, January 08, 2014 9:37 AM
> In a triangular workflow, you may have a distinct
> @{upstream} that you pull changes from, but publish by
> default (if you typed "git push") to a different remote (or
> a different branch on the remote).

One of the broader issues is the lack of _documenation_ about what the 
'normal' naming convention is for the uspstream remote. Especially the 
implicit convention used within our documentation (and workflow).

This is especially true for github users who will normally fork a repo 
of interest and then clone it from their own copy/fork. This means that 
the 'origin' remote is _not_ the upstream. See 
https://help.github.com/articles/fork-a-repo In my case 'origin' is my 
publish repo (as suggested by Github) while 'junio' is the upstream (as 
do some others). There are similar results from the likes of 
Stackoverflow.

Much of the earlier discussion did appear to be as much a confusion over 
terminology as that of coding a suitable solution ro Ram's original 
forked-from issue.

I know it's been an issue I've had for some while 
http://thread.gmane.org/gmane.comp.version-control.git/194175/focus=195385

Philip
