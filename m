From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/2] add tests for merge-index / merge-one-file
Date: Fri, 29 Apr 2011 08:12:47 +0200
Message-ID: <4DBA56DF.5070000@viscovery.net>
References: <20110428223822.GA16004@sigill.intra.peff.net> <20110428223949.GA16027@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Aman Gupta <themastermind1@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 29 08:12:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFgwj-0003Ez-Pj
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 08:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753878Ab1D2GMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 02:12:54 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43727 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311Ab1D2GMx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 02:12:53 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QFgwZ-0002mR-OD; Fri, 29 Apr 2011 08:12:47 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 77BC71660F;
	Fri, 29 Apr 2011 08:12:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110428223949.GA16027@sigill.intra.peff.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172425>

Am 4/29/2011 0:39, schrieb Jeff King:
> +	sed s/2/two/ <file >tmp &&

You are not using -e; will all seds out there grok this?

-- Hannes
