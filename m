From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [TOY PATCH] test-lib: &&-chaining tester
Date: Wed, 06 Oct 2010 10:25:01 +0200
Message-ID: <4CAC325D.1010403@viscovery.net>
References: <1286136014-7728-1-git-send-email-newren@gmail.com>	<20101006053118.GA29289@burratino> <vpqeic3agk8.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, avarab@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Oct 06 10:25:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3PJN-0006cI-0K
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 10:25:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758653Ab0JFIZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Oct 2010 04:25:06 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:34136 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757283Ab0JFIZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Oct 2010 04:25:05 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1P3PJ7-0005ZY-QD; Wed, 06 Oct 2010 10:25:01 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 872F41660F;
	Wed,  6 Oct 2010 10:25:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <vpqeic3agk8.fsf@bauges.imag.fr>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158273>

Am 10/6/2010 10:09, schrieb Matthieu Moy:
> Probably a silly question, but is there any reason why we use these &&
> instead of a "set -e" once and for all?

Because different shells implement different behavior when "set -e" is in
effect and functions, && and || chains, and traps are in the game.

-- Hannes
