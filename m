From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH 3/3] grep: add support for grepping in submodules
Date: Thu, 30 Sep 2010 13:28:56 +0200
Message-ID: <4CA47478.6030207@viscovery.net>
References: <1285792134-26339-1-git-send-email-judge.packham@gmail.com> <1285792134-26339-4-git-send-email-judge.packham@gmail.com> <4CA3BBD7.3090006@web.de> <7v4od8ma0j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 13:29:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1HK0-0005KF-GF
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 13:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498Ab0I3L3C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 07:29:02 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:26425 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998Ab0I3L3B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 07:29:01 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P1HJp-0000ej-7a; Thu, 30 Sep 2010 13:28:57 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D6CEE1660F;
	Thu, 30 Sep 2010 13:28:56 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.12) Gecko/20100914 Thunderbird/3.0.8
In-Reply-To: <7v4od8ma0j.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157640>

Am 9/30/2010 0:59, schrieb Junio C Hamano:
> A few more things to think about.
> 
> 1. What does this mean:
> 
>     $ git grep --recursive -e frotz master next
> 
> It recurses into the submodule commits recorded in 'master' and 'next'
> commits in the superproject, right?

And what does it mean if you add --cached? Does it grep in the index of
the submodules, or does it grep in the rev of the submodule that is
recorded in the index of the supermodule?

-- Hannes
