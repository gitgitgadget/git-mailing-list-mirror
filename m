From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3 3/3] Don't expand CRLFs when normalizing text during
 merge
Date: Fri, 25 Jun 2010 07:45:28 +0200
Message-ID: <4C244278.10407@viscovery.net>
References: <cover.1277408598.git.eyvind.bernhardsen@gmail.com> <90f38b5f5c49f9b9f5427a026e51f867a1121982.1277408598.git.eyvind.bernhardsen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 07:45:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OS1jO-0004HH-T5
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 07:45:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068Ab0FYFpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jun 2010 01:45:34 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:26018 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab0FYFpd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jun 2010 01:45:33 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OS1jE-0003ee-OF; Fri, 25 Jun 2010 07:45:28 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 587151660F;
	Fri, 25 Jun 2010 07:45:28 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <90f38b5f5c49f9b9f5427a026e51f867a1121982.1277408598.git.eyvind.bernhardsen@gmail.com>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149666>

Am 6/24/2010 22:44, schrieb Eyvind Bernhardsen:
> There's no need to expand CRLFs when convert_to_working_tree() is called
> to normalize text for a merge since the text will be converted back
> immediately.  Improves performance of merges with conflicting line
> endings when core.eol=crlf or core.autocrlf=true.

Pardon me, first you make a big deal about normalization for merges, only
that you finally omit it? What am I missing?

BTW, most of the new functions you introduced violate the style: they
should have the opening brace on the next line.

-- Hannes
