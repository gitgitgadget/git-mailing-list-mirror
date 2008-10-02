From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] run-command.c: remove run_command_v_opt_cd()
Date: Thu, 02 Oct 2008 12:54:48 +0200
Message-ID: <48E4A878.2090704@viscovery.net>
References: <20081002191425.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 12:56:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlLql-0001x0-S4
	for gcvg-git-2@gmane.org; Thu, 02 Oct 2008 12:56:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbYJBKyx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 06:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753316AbYJBKyx
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 06:54:53 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:51933 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753284AbYJBKyw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 06:54:52 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KlLpY-0001pw-Tr; Thu, 02 Oct 2008 12:54:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6DFB76B7; Thu,  2 Oct 2008 12:54:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081002191425.6117@nanako3.lavabit.com>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97312>

Nanako Shiraishi schrieb:
> This function is not used anywhere.

Indeed. Future callers can use run_command_v_opt_cd_env() instead.

The function is also mentioned in
Documentation/technical/api-run-command.txt, where you should remove it, too.

-- Hannes
