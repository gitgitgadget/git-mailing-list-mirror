From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] post-receive-email: explicitly set Content-Type header
Date: Tue, 20 Sep 2011 11:32:54 +0200
Message-ID: <4E785DC6.80105@viscovery.net>
References: <1316505154-3904-1-git-send-email-zapped@mail.ru> <1316506023-5098-1-git-send-email-zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alexey Shumkin <zapped@mail.ru>
X-From: git-owner@vger.kernel.org Tue Sep 20 11:33:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5whQ-0005qV-I7
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 11:33:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616Ab1ITJdC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 05:33:02 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:49110 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401Ab1ITJdB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 05:33:01 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1R5whC-0007WQ-SS; Tue, 20 Sep 2011 11:32:55 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8962C1660F;
	Tue, 20 Sep 2011 11:32:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.22) Gecko/20110902 Thunderbird/3.1.14
In-Reply-To: <1316506023-5098-1-git-send-email-zapped@mail.ru>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181746>

Am 9/20/2011 10:07, schrieb Alexey Shumkin:
> Some email clients (e.g. claws-mail) incorrectly display
> message body when there is no Content-Type header and charset
> explicitly defined.
> So, set explicitly Content-Type header and charset
> can be defined with hooks.emailcharset config variable.

Please write full sentences with complete punctuation and capitalization.
Perhaps you meant to say:

  Some email clients (e.g. claws-mail) display the message body
  incorrectly when the charset is not defined explicitly in a
  Content-Type header. Insert a Content-Type header in the message.

  The charset can be defined with the config variable
  hooks.emailcharset.

> +# hooks.emailcharset
> +#   The charset used in Content-Type header. UTF-8, if not specified.

How can you be sure that the output produced by git log etc. that are used
in the script are in the encoding specified by this variable? IOW,
wouldn't log.outputencoding be the better choice to use in the
Content-Type header?

-- Hannes
