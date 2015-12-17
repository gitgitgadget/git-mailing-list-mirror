From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCHv2] submodule: Port resolve_relative_url from shell to C
Date: Thu, 17 Dec 2015 20:17:32 +0100
Message-ID: <56730A4C.4080102@kdbg.org>
References: <1450311999-3992-1-git-send-email-sbeller@google.com>
 <1450311999-3992-2-git-send-email-sbeller@google.com>
 <5673052F.7050000@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, jens.lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 20:17:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9e3Y-0006sb-Aa
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 20:17:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754865AbbLQTRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 14:17:36 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:21850 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752431AbbLQTRf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2015 14:17:35 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pM34F5XTCz5tlC;
	Thu, 17 Dec 2015 20:17:33 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 50A4A53B7;
	Thu, 17 Dec 2015 20:17:33 +0100 (CET)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
In-Reply-To: <5673052F.7050000@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282667>

Am 17.12.2015 um 19:55 schrieb Johannes Sixt:
> As to the implementation, find a patch below that removes the ifdefs
> and a few other suggestions.

The word "offers" is missing in this last half-sentence ;)
