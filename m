From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: last commit in a directory
Date: Tue, 25 Jan 2011 09:47:07 +0100
Message-ID: <4D3E8E0B.2090200@viscovery.net>
References: <4D3E89FA.4080901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Leonid Podolny <leonidp.lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 25 09:47:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PheYW-0006tv-3Y
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 09:47:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998Ab1AYIrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 03:47:11 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:18789 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab1AYIrK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 03:47:10 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PheYN-0001xb-SV; Tue, 25 Jan 2011 09:47:07 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9F1041660F;
	Tue, 25 Jan 2011 09:47:07 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <4D3E89FA.4080901@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165474>

Am 1/25/2011 9:29, schrieb Leonid Podolny:
> I have a really simple question: how do I find a last commit for the given
> directory inside the repository?

git log -1 that/directory

But if you need it in a script, this is preferable:

  lastsha1=$(git rev-list -1 HEAD -- "$directory")

-- Hannes
