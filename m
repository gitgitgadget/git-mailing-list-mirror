From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH, v2] tag: implement --[no-]strip option
Date: Tue, 15 Nov 2011 07:42:15 +0100
Message-ID: <4EC209C7.6090805@viscovery.net>
References: <1321307019-5557-1-git-send-email-kirill@shutemov.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
X-From: git-owner@vger.kernel.org Tue Nov 15 07:42:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQCiw-0000o6-A9
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 07:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751812Ab1KOGmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 01:42:21 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:29896 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab1KOGmV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 01:42:21 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RQCil-0004SB-Rh; Tue, 15 Nov 2011 07:42:16 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8E7931660F;
	Tue, 15 Nov 2011 07:42:15 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.23) Gecko/20110920 Thunderbird/3.1.15
In-Reply-To: <1321307019-5557-1-git-send-email-kirill@shutemov.name>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185435>

Am 11/14/2011 22:43, schrieb Kirill A. Shutemov:
> From: "Kirill A. Shutemov" <kirill@shutemov.name>
> 
> --strip::
> 	Remove from tag message lines staring with '#', trailing spaces

s/staring/starting/

> 	from every line and empty lines from the beginning and end.
> 	Enabled by default. Use --no-strip to overwrite the behaviour.
> 
> --no-strip is useful if you want to take a tag message as-is, without
> any stripping.

I would like to know why this is useful. Tag messages are for human
consumption. What benefit is it that whitespace is not stripped? Why are
lines starting with '#' so important that they need to stay in the tag
message?

-- Hannes
