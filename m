From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-rebase--interactive.sh: Add new command "shell"
Date: Thu, 04 Nov 2010 11:24:42 +0100
Message-ID: <4CD289EA.7050800@viscovery.net>
References: <1288847836-84882-1-git-send-email-kevin@sb.org> <vpq39rhzdht.fsf@bauges.imag.fr> <914D7AE3-22D5-4069-B815-2B11A2897BE9@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Nov 04 11:24:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDx01-000106-EV
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 11:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375Ab0KDKYs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 06:24:48 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:53075 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755083Ab0KDKYr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 06:24:47 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PDwzr-0008KY-Dt; Thu, 04 Nov 2010 11:24:43 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2CB941660F;
	Thu,  4 Nov 2010 11:24:43 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <914D7AE3-22D5-4069-B815-2B11A2897BE9@sb.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160712>

Am 11/4/2010 9:53, schrieb Kevin Ballard:
> +#  pause = exit to the shell

The short form could be just the dash -. I'd describe the command as

#  pause,- = interrupt automatic processing of commits

or similar to avoid the term "shell".

-- Hannes
