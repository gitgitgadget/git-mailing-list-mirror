From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix indentation problem in git-ls-files(1)
Date: Tue, 16 Mar 2010 08:05:20 +0100
Message-ID: <4B9F2DB0.30400@viscovery.net>
References: <m2tyswb1jp.fsf@igel.home>	<7v3a0fr740.fsf@alter.siamese.dyndns.org> <m3r5nzw05p.fsf@hase.home>	<ca433831003070927h4c3e24e1m75c7be88355f9663@mail.gmail.com> <m23a01yzcc.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Tue Mar 16 08:06:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrQqK-0005SZ-8J
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 08:06:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937461Ab0CPHFZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 03:05:25 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42617 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937452Ab0CPHFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 03:05:25 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NrQq8-0004ub-LM; Tue, 16 Mar 2010 08:05:20 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 598351660F;
	Tue, 16 Mar 2010 08:05:20 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <m23a01yzcc.fsf@igel.home>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142323>

Andreas Schwab schrieb:
> The nested list in the description of the -t option wasn't properly
> indented.  Additionally, make it a horizontal labeled list since the
> labels are all short.

IMHO, converting a vertical list to a horizontal list is a step in the
wrong direction, even if the labels are short. It is far easier to scan a
vertical list for a match than a horizontal list.

-- Hannes
