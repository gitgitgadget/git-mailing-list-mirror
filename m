From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] Makefile: work around ksh's failure to handle missing
 list argument to for loop
Date: Mon, 05 Jul 2010 11:15:04 +0200
Message-ID: <4C31A298.1030005@viscovery.net>
References: <80typu1ozt.fsf@tiny.isode.net> <8YdP-GcDDflOVZnykNVIGceOm01bqeg9PDvdgIfgqUnh29RKC-6Qi8_KBVoqLIt5iyt7g1TX5l96M5KyLrfOqg@cipher.nrlssc.navy.mil> <4C30D4D5.3020900@drmicha.warpmail.net> <4C31796E.9050109@viscovery.net> <4C319478.4070903@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>, gitster@pobox.com,
	git@vger.kernel.org, PWalker752@aol.com, newsletter@dirk.my1.cc,
	bruce.stephens@isode.com, Brandon Casey <drafnel@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Jul 05 11:15:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVhln-0000TQ-HA
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 11:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757151Ab0GEJPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 05:15:12 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:47781 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297Ab0GEJPL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 05:15:11 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OVhlZ-0005wa-8K; Mon, 05 Jul 2010 11:15:05 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E6FD41660F;
	Mon,  5 Jul 2010 11:15:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <4C319478.4070903@drmicha.warpmail.net>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150252>

Am 7/5/2010 10:14, schrieb Michael J Gruber:
> BTW: Is the $$var gmake specific?

No. $ is a (special?) make variable that contains only a dollar sign. To
expand the variable in the Makefile, you have to write $$ (like for any
other Makefile variable whose name has only a single character, like $@,
$<, etc). As a result, you get a single dollar sign in the shell command
text. :-)

-- Hannes
