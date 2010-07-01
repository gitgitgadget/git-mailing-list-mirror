From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v5 2/4] Introduce "double conversion during merge" more
 gradually
Date: Thu, 01 Jul 2010 12:19:49 +0200
Message-ID: <4C2C6BC5.1030905@viscovery.net>
References: <cover.1277974452.git.eyvind.bernhardsen@gmail.com> <3ae294ef30c3539da47d101bc39638e63721eb0e.1277974452.git.eyvind.bernhardsen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 01 12:19:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUGsA-0001dn-GC
	for gcvg-git-2@lo.gmane.org; Thu, 01 Jul 2010 12:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977Ab0GAKTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jul 2010 06:19:53 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:38827 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754314Ab0GAKTw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jul 2010 06:19:52 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OUGs2-0007qd-0i; Thu, 01 Jul 2010 12:19:50 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B363D1660F;
	Thu,  1 Jul 2010 12:19:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <3ae294ef30c3539da47d101bc39638e63721eb0e.1277974452.git.eyvind.bernhardsen@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150025>

Am 7/1/2010 11:09, schrieb Eyvind Bernhardsen:
> +core.mergePrefilter::

BTW, any particular reason that this is in the core namespace rather than
merge namespace? It could be merge.prefilter.

-- Hannes
