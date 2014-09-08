From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 22/32] checkout: support checking out into a new working
 directory
Date: Mon, 08 Sep 2014 10:06:25 -0400
Message-ID: <540DB7E1.4090302@xiplink.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com> <1409387642-24492-23-git-send-email-pclouds@gmail.com> <70985AC885404243A2B95F534083A0E9@PhilipOakley> <CACsJy8CpGhLN58GyJa_3-PDqNqYUCshPEGDr8-pKngad+-oAdg@mail.gmail.com> <CACsJy8ASW0xO3WzU7f+T4iDhjL=Y=C6K+Cvi-OWOnS16r=m+9Q@mail.gmail.com> <64D6AA311E524C27A8B6EDE7A63489D7@PhilipOakley> <CACsJy8CTLRpjmh+0K6ypLKUgi52gsFEqnNsha2yfOvRVCdhdMQ@mail.gmail.com> <5405D983.3050707@xiplink.com> <xmqqfvga2ai9.fsf@gitster.dls.corp.google.com> <CACsJy8DxUguPohjYGTgnHjBc=0mqn20c67pTBN34VRz7oCjyGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>
To: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 16:06:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQzaZ-0004ZV-SM
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 16:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754267AbaIHOGf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 10:06:35 -0400
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:44736 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947AbaIHOGN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 10:06:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp14.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 2F041803D4;
	Mon,  8 Sep 2014 10:06:11 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp14.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id EF695803E7;
	Mon,  8 Sep 2014 10:06:10 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.2.10);
	Mon, 08 Sep 2014 14:06:11 GMT
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <CACsJy8DxUguPohjYGTgnHjBc=0mqn20c67pTBN34VRz7oCjyGA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256648>

On 14-09-08 06:52 AM, Duy Nguyen wrote:
> 
> While we're changing the terms, I wonder if "primary working
> directory" and "secondary working directories" are better than "main
> checkout" and "linked checkout".

I might have a slight preference for main/linked, because primary/secondary
can imply that there are further orders -- tertiary, quaternary, etc.  Also,
at least in English, "linked" is commonly used and it doesn't necessarily
imply an implementation (e.g. with hard or soft filesystem links).

(How many angels can dance on the threshold of an open bikeshed door? :) )

		M.
