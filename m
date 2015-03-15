From: Manos Pitsidianakis <epilys@norn.io>
Subject: Re: [PATCH v3] log: forbid log --graph --no-walk
Date: Sun, 15 Mar 2015 03:24:50 +0200
Message-ID: <5504DF62.4050104@norn.io>
References: <5504D5A2.2070405@norn.io> <CABwkPcpdpsVUFa_GSr=qYazYQDBr_ygQTctFXmYQf2ZsRt5bpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, me@ikke.info,
	sandals@crustytoothpaste.net, Junio C Hamano <gitster@pobox.com>,
	peff@peff.net
To: Dongcan Jiang <dongcan.jiang@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 02:23:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWxHF-00066R-PH
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 02:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbbCOBXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 21:23:33 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:58702 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbbCOBXc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 21:23:32 -0400
Received: from mfilter5-d.gandi.net (mfilter5-d.gandi.net [217.70.178.132])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 34CCBA80AC;
	Sun, 15 Mar 2015 02:23:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter5-d.gandi.net
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter5-d.gandi.net (mfilter5-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id kTVdBFUonQxP; Sun, 15 Mar 2015 02:23:29 +0100 (CET)
X-Originating-IP: 5.54.110.208
Received: from [192.168.2.2] (ppp005054110208.access.hol.gr [5.54.110.208])
	(Authenticated sender: epilys@norn.io)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 946CEA80AB;
	Sun, 15 Mar 2015 02:23:28 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <CABwkPcpdpsVUFa_GSr=qYazYQDBr_ygQTctFXmYQf2ZsRt5bpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265474>

On 03/15/2015 03:08 AM, Dongcan Jiang wrote:
> it seems that your patch could not pass t4052-stat-output.sh.
> 
> I think it would be better if you could improve the specification for
> this change in Document/rev-list-options.txt

Can't grok why this happens. What exactly is happening in
t4052-stat-output.sh? Is it testing every possible combination of git
commands and arguments?
