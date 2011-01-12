X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: clone breaks replace
Date: Tue, 11 Jan 2011 19:59:54 -0500
Message-ID: <4D2CFD0A.1060901@cfl.rr.com>
References: <4D262D68.2050804@cfl.rr.com> <201101112048.57326.j6t@kdbg.org> <20110111195107.GA18714@sigill.intra.peff.net> <201101112100.32083.j6t@kdbg.org> <4D2CBC1A.9000302@cfl.rr.com> <20110111205043.GA19928@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 12 Jan 2011 01:00:25 +0000 (UTC)
Cc: Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Stephen Bash <bash@genarts.com>
To: Jonathan Nieder <jrnieder@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
X-Authority-Analysis: v=1.1 cv=uESSSoDEku2quKX/oFXS2Smn5+55LTFcWFr5T5T8nFs= c=1 sm=0 a=8nJEP1OIZ-IA:10 a=JmtI77n5PKyEllQSDapvNg==:17 a=hUQfzj0zOGuIpjcWwgkA:9 a=JHCIHP7ozoucK-i4ZYpMhqDkrHYA:4 a=wPNLvfGTeEIA:10 a=JmtI77n5PKyEllQSDapvNg==:117
X-Cloudmark-Score: 0
X-Originating-IP: 184.91.189.177
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <20110111205043.GA19928@burratino>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165000>
Received: from vger.kernel.org ([209.132.180.67]) by lo.gmane.org with esmtp
 (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id 1Pcp4H-00008i-M4
 for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 02:00:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932615Ab1ALA76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Jan 2011
 19:59:58 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:38160 "EHLO
 cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932846Ab1ALA75 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 11 Jan
 2011 19:59:57 -0500
Received: from [184.91.189.177] ([184.91.189.177:50499] helo=[192.168.1.3])
 by cdptpa-oedge01.mail.rr.com (envelope-from <psusi@cfl.rr.com>) (ecelerity
 2.2.3.46 r()) with ESMTP id 98/EE-07087-B0DFC2D4; Wed, 12 Jan 2011 00:59:56
 +0000
Sender: git-owner@vger.kernel.org

On 01/11/2011 03:50 PM, Jonathan Nieder wrote:
> Yes, except for "Using filter-branch is bad".  Using filter-branch is
> not bad.

It is bad because it breaks people tracking your branch, and violates 
the immutability of history.
