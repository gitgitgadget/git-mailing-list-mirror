From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] revision: --ancestry-path
Date: Wed, 21 Apr 2010 09:47:47 +0200
Message-ID: <4BCEADA3.7090504@viscovery.net>
References: <201004201649.31084.johan@herland.net> <7viq7lg8f2.fsf@alter.siamese.dyndns.org> <7v39ypg4gm.fsf_-_@alter.siamese.dyndns.org> <201004210934.30226.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Apr 21 09:47:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4Uf8-0003kI-EZ
	for gcvg-git-2@lo.gmane.org; Wed, 21 Apr 2010 09:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234Ab0DUHrw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Apr 2010 03:47:52 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:11401 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868Ab0DUHrw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Apr 2010 03:47:52 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1O4Uex-0000HT-N2; Wed, 21 Apr 2010 09:47:47 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 6D2B91660F;
	Wed, 21 Apr 2010 09:47:47 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <201004210934.30226.johan@herland.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145414>

Am 4/21/2010 9:34, schrieb Johan Herland:
> I can confirm that this patch works with my original (more complicated) 
> scenario. I've also played around with combinations of --ancestry-path, --
> graph and --parents (and even --boundary), and AFAICS, the new option does 
> not clobber the other options, and (IMHO) it all behaves correctly in the 
> scenarios I've tested.

How about possible interactions with --reverse; --date-order/--topo-order,
--parents (important for gitk); --simplify-by-decoration (useful for your
problem that triggered this); --full-history and --simplify-merges with
path limiting?

-- Hannes
