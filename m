From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] test_interactive: interactive debugging in test scripts
Date: Mon, 16 Jan 2012 21:01:21 +0100
Message-ID: <4F148211.70106@web.de>
References: <4F133069.10308@web.de> <20120115232413.GA14724@sigill.intra.peff.net> <20120116154953.GA21238@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Jan 16 21:01:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmskS-0005yR-Ks
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 21:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754874Ab2APUBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 15:01:39 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:36688 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754157Ab2APUBi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 15:01:38 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate01.web.de (Postfix) with ESMTP id 3A8EB1A8FC777
	for <git@vger.kernel.org>; Mon, 16 Jan 2012 21:01:27 +0100 (CET)
Received: from [192.168.178.43] ([91.3.194.97]) by smtp.web.de (mrweb001) with
 ESMTPA (Nemesis) id 0LZeou-1SVtDE2HEK-00lJoF; Mon, 16 Jan 2012 21:01:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <20120116154953.GA21238@padd.com>
X-Provags-ID: V02:K0:B49VrD4lnf+o80jfJFvqTXf08j/L/zpe45cV3sbr2SE
 VZi3FNxQUSg7Zu7MLk4Q/veiqC1DIb4DwNfp1u250GSco3lFGD
 CnDPQq2f/SjDhtT5JHlwGlUEHJA6Ty93vOuGDKITnWG7i3jjme
 PCtrJI2ebNL3JStLDihDzQ3vlxUFjfkEK/qIV+SQ5/qDpJrT4n
 2LloujuM09zxsrra1y3uQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188648>

Am 16.01.2012 16:49, schrieb Pete Wyckoff:
> Between mine and Jens' there is hopefully something widely useful
> here.

Just while I was planning a v2 and thought about renaming "test_bash"
to "test_interactive", let it take a command to run as optional
argument and document it better you came up with this :-)

So I vote for your patch as it takes my initial idea even further. I
really like that HOME, TERM and SHELL are honored in your version
leaving the user with a fully functional shell of his choice.
