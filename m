From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH v4] commit.c: use =?utf-8?b?c2tpcF9wcmVmaXgoKQ==?= instead of =?utf-8?b?c3RhcnRzX3dpdGgoKQ==?=
Date: Tue, 4 Mar 2014 22:32:30 +0000 (UTC)
Message-ID: <loom.20140304T233205-398@post.gmane.org>
References: <1393967190-3181-1-git-send-email-tanayabh@gmail.com> <xmqqzjl5iro0.fsf@gitster.dls.corp.google.com> <xmqqvbvtiph8.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 23:33:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKxtW-0002pT-QE
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 23:33:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139AbaCDWc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 17:32:58 -0500
Received: from plane.gmane.org ([80.91.229.3]:59411 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755781AbaCDWc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 17:32:57 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WKxtP-0002lF-GR
	for git@vger.kernel.org; Tue, 04 Mar 2014 23:32:56 +0100
Received: from triband-del-59.178.159.53.bol.net.in ([triband-del-59.178.159.53.bol.net.in])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 23:32:55 +0100
Received: from tanayabh by triband-del-59.178.159.53.bol.net.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 23:32:55 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 59.178.159.53 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Firefox/24.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243401>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> Junio C Hamano <gitster <at> pobox.com> writes:
> 
> >> +		found = skip_prefix(buf, sigcheck_gpg_status[i].check + 1);
> >> +		if(!found) {
> 
> Missing SP between the control keyword and parenthesized expression
> the keyword uses.
> 
> I've fixed this (and the broken indentation) locally and queued the
> result to 'pu', so no need to resend to correct this one.
> 
> Thanks.
> 
> 

Sorry about the indentation, it was due to not setting the tab to eight
spaces. I found your mail late, so I had already
sent a revised patch [1]. Please ignore that mail.

Also , what should be my next step ,should I present a rough draft of a
proposal , or tackle other bugs on the mailing list?

Thanks for the suggestions and advice,

Regards,
Tanay Abhra.

[1] http://article.gmane.org/gmane.comp.version-control.git/243395
