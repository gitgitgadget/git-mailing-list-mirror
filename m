From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 0/3] check for unpushed remotes in submodules
Date: Fri, 29 Jul 2011 00:14:50 +0200
Message-ID: <4E31DF5A.4050307@web.de>
References: <1311790250-32454-1-git-send-email-iveqy@iveqy.com> <7v39hqmb30.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	hvoigt@hvoigt.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 29 00:15:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmYr6-0003eN-R7
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 00:15:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754794Ab1G1WO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 18:14:57 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:44154 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774Ab1G1WOz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 18:14:55 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate03.web.de (Postfix) with ESMTP id E513419637707;
	Fri, 29 Jul 2011 00:14:53 +0200 (CEST)
Received: from [93.240.106.134] (helo=[192.168.178.43])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QmYqz-0001UR-00; Fri, 29 Jul 2011 00:14:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <7v39hqmb30.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18SEx8xbo/J5KM6fF3ymHpMTv/7mJjbFm+mRxhh
	FlkgwNHOtSZ97+bbGg5MZLDCKI8IBsuSJRFQeOTIzM5iT9oyC2
	mYViSwkickqeFV2BT76Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178118>

Am 28.07.2011 21:58, schrieb Junio C Hamano:
> Fredrik Gustafsson <iveqy@iveqy.com> writes:
> 
>> Regarding the discussion of superprojects with submodules that have no
>> remote tracking branches: A push will still be denied.
> 
> I have marked one part of the data synchronized across machines as
> "private" submodule (which contains my gpg keychains, encrypted password
> files, personaly memos, etc.) and push only the outer "shell" superproject
> (which has tools that I use everywhere to go to $HOME/bin among other
> things) to certain machines without the private parts, and the
> superproject is designed to work without a checkout (nor clone) of a
> submodule.
> 
> With this patch series, it sounds like I cannot use this repository
> structure anymore, which is sad.

Thanks for bringing this use case up. Now I understand why you asked if
submodules without remote tracking branches should be checked too. We
discussed that and couldn't think of a scenario where the user doesn't
want to have remote tracking branches in a submodule, but we missed the
use case you described here. Back to the drawing board ...
