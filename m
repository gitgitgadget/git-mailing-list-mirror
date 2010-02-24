From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] commit: quote the user name in the example
Date: Wed, 24 Feb 2010 08:49:23 +0100
Message-ID: <4B84DA03.1040809@viscovery.net>
References: <1266980049-5835-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Wed Feb 24 08:49:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkBzy-0006F2-6U
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 08:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755605Ab0BXHt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 02:49:29 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:10006 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755476Ab0BXHt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 02:49:28 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NkBzo-0001Wl-3L; Wed, 24 Feb 2010 08:49:24 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D0E971660F;
	Wed, 24 Feb 2010 08:49:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1266980049-5835-1-git-send-email-kraai@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140916>

Matt Kraai schrieb:
> If the user runs
> 
>  git config --global user.name Your Name
> 
> as suggested, user.name will be set to "Your".  With this patch, the
> suggested command will be
> 
>  git config --global user.name 'Your Name'
> 
> which will set user.name to "Your Name" and hopefully help users avoid
> the former mistake.

Actually, I would prefer that the suggested command is

  git config --global user.name "Your Name"

i.e., with double-quotes, because then the suggestion is also correct for
Windows users who run git from CMD: in this environment, single-quotes do
not quote, but double-quotes do.

-- Hannes
