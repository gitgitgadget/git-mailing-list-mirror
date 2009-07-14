From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] t4202-log.sh: Test git log --no-walk sort order
Date: Tue, 14 Jul 2009 14:21:48 +0200
Message-ID: <4A5C785C.6060706@viscovery.net>
References: <alpine.DEB.1.00.0907141243410.3155@pacific.mpi-cbg.de> <1247573287-9526-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Paolo Bonzini <bonzini@gnu.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jul 14 14:22:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQh1O-0005px-As
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 14:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752338AbZGNMWD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 08:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbZGNMWD
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 08:22:03 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38806 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103AbZGNMWC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 08:22:02 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MQh12-000842-OY; Tue, 14 Jul 2009 14:21:56 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 3C5F74E4; Tue, 14 Jul 2009 14:21:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1247573287-9526-1-git-send-email-git@drmicha.warpmail.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123240>

Michael J Gruber schrieb:
> +test_expect_success 'git log --no-walk <commits> sorts by commit time' '
...
> +test_expect_success 'git show <commits> does not sort by commit time' '

Thanks, but sorry that I'm nit-picking here: You say what git show does
not do, but shouldn't you say what git show should do?

	'git show shows commits in command line order'

-- Hannes
