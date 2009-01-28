From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Windows: Fix intermittent failures of t7701
Date: Wed, 28 Jan 2009 08:26:50 +0100
Message-ID: <498008BA.2000201@viscovery.net>
References: <497F076F.8060509@viscovery.net> <alpine.DEB.1.00.0901271740320.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 28 08:28:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS4qb-0005m0-1r
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 08:28:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbZA1H07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 02:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbZA1H07
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 02:26:59 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:56754 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbZA1H06 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 02:26:58 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LS4p0-0006PK-Uf; Wed, 28 Jan 2009 08:26:51 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 6956D6C4; Wed, 28 Jan 2009 08:26:50 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <alpine.DEB.1.00.0901271740320.3586@pacific.mpi-cbg.de>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107489>

Johannes Schindelin schrieb:
> I use this trick in my valgrind series:
> 
> 	($PROGRAM; echo $? > exit.code) | $OTHER_PROGRAM &&
> 	test 0 = "$(cat exit.code)"

Ah, using a file as temporary storage? Why not simply

	$PROGRAM > data &&
	$OTHER_PROGRAM < data

Hm? ;)

-- Hannes
