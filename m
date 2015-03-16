From: Manos Pitsidianakis <epilys@norn.io>
Subject: Re: [PATCH v3] log: forbid log --graph --no-walk
Date: Mon, 16 Mar 2015 21:00:38 +0200
Message-ID: <55072856.5090308@norn.io>
References: <5504D5A2.2070405@norn.io> <CABwkPcpdpsVUFa_GSr=qYazYQDBr_ygQTctFXmYQf2ZsRt5bpA@mail.gmail.com> <5504DF62.4050104@norn.io> <CABwkPcpRG0d23OCuoktRdXt9nyA3RtmxGkqkoQ-wApzZvtfYDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, me@ikke.info,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Dongcan Jiang <dongcan.jiang@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 19:59:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXaEY-0000HK-GN
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 19:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755132AbbCPS7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 14:59:22 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:40643 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753817AbbCPS7V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 14:59:21 -0400
Received: from mfilter15-d.gandi.net (mfilter15-d.gandi.net [217.70.178.143])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id DC9FC172089;
	Mon, 16 Mar 2015 19:59:17 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter15-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter15-d.gandi.net (mfilter15-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id hhMtGD25b0cp; Mon, 16 Mar 2015 19:59:16 +0100 (CET)
X-Originating-IP: 5.54.110.208
Received: from [192.168.2.2] (ppp005054110208.access.hol.gr [5.54.110.208])
	(Authenticated sender: epilys@norn.io)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 67A6B17209D;
	Mon, 16 Mar 2015 19:59:15 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CABwkPcpRG0d23OCuoktRdXt9nyA3RtmxGkqkoQ-wApzZvtfYDQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265587>

On 03/15/2015 03:39 AM, Dongcan Jiang wrote:
> Because "revs->no_walk" gets set when it comes to "git show".

So basically rewriting t4052-stat-output.sh to exclude git show --graph
cases (or similar) is not enough. If rewriting git-show code is what is
needed, is that in the scope of a microproject?
