From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 1/2 (v2)] submodule: no [--merge|--rebase] when newly
 cloned
Date: Thu, 17 Feb 2011 20:41:58 +0100
Message-ID: <4D5D7A06.6050700@web.de>
References: <1297959526-8089-1-git-send-email-olsonse@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Spencer E. Olson" <olsonse@umich.edu>
X-From: git-owner@vger.kernel.org Thu Feb 17 20:42:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pq9ju-0007UW-6I
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 20:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757849Ab1BQTmD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 14:42:03 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:47400 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1BQTl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 14:41:59 -0500
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate03.web.de (Postfix) with ESMTP id 77EBC188B2450;
	Thu, 17 Feb 2011 20:41:58 +0100 (CET)
Received: from [93.246.40.171] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Pq9ji-0002PJ-00; Thu, 17 Feb 2011 20:41:58 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <1297959526-8089-1-git-send-email-olsonse@umich.edu>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+3lSBSeuxq1Z6bQVsKmZzpzC0YsubnsJntDcAp
	zKedV+HH+xxNyeqMJTbDOh41tvzdSvGKQO5ov8cVr7MctvO3qv
	qGO3h8xz1+33pq3LZQHg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167101>

Am 17.02.2011 17:18, schrieb Spencer E. Olson:
> Previously, when a new submodule is cloned by running "git submodule update
> [--merge|--rebase]", the newly cloned submodule does not get checked out and a
> rebase or merge is incorrectly attempted against an empty working directory.
> This patch ignores --rebase or --merge for new submodules and instead simply
> checks out the appropriate revision.

Nice work, thanks!

Just a small thing: This problem also happens when the configuration
"submodule.<name>.update" is set to either "rebase" or "merge", not only
when using the command line options. So perhaps you could reword the topic
to something like "submodule: don't merge or rebase when newly cloned" and
adjust both commit messages a bit?

Apart from that:
Acked-by: Jens Lehmann <Jens.Lehmann@web.de>
