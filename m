From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC PATCH 0/2] Teach fetch and pull to recursively fetch submodules
 too
Date: Mon, 30 Aug 2010 19:41:33 +0200
Message-ID: <4C7BED4D.7050806@web.de>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 19:42:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq8N1-00081v-6v
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 19:42:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376Ab0H3Rlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 13:41:35 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:59382 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756370Ab0H3Rle (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 13:41:34 -0400
Received: from smtp03.web.de  ( [172.20.0.65])
	by fmmailgate01.web.de (Postfix) with ESMTP id A1A8E166E3C8D;
	Mon, 30 Aug 2010 19:41:33 +0200 (CEST)
Received: from [93.240.103.177] (helo=[192.168.178.29])
	by smtp03.web.de with asmtp (WEB.DE 4.110 #24)
	id 1Oq8MP-00059L-00; Mon, 30 Aug 2010 19:41:33 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <7vocckhcb6.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18joEdPMlAXIKjI0bywBB6UqdfxrLO1RpNgQIan
	fVdGW7kbBMDYeiENRnA5gDLfNIAU3R84fFnSyD4SygyEO5KOea
	LaDEGVEdOtRnvL6QtlDQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154837>

Am 30.08.2010 07:58, schrieb Junio C Hamano:
> I am not sure what you mean by "all submodules" nor "all repos", though.
> In order to trigger the feature this series introduces, users have a means
> to initialize all submodules in one go (update --recursive --init), and
> wouldn't that be sufficient?

I was thinking about adding a "fetch.recursive" config option which
would allow setting the - now hardcoded - default in .git/config or
~/.gitconfig, but I'm not quite sure that is needed.
