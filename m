From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 5/5] rebase -i: avoid exporting GIT_AUTHOR_* variables
Date: Wed, 26 Sep 2007 13:18:51 +0200
Message-ID: <46FA401B.9000303@viscovery.net>
References: <Pine.LNX.4.64.0709251640360.28395@racer.site>	<Pine.LNX.4.64.0709251643310.28395@racer.site>	<46FA358E.40500@viscovery.net> <86zlz9smqr.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Sep 26 13:19:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaUv1-0007s8-Ii
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 13:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609AbXIZLSz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 07:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755533AbXIZLSz
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 07:18:55 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:37958 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459AbXIZLSy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 07:18:54 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IaUup-0002Ut-V6; Wed, 26 Sep 2007 13:18:52 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 7949B54D; Wed, 26 Sep 2007 13:18:51 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <86zlz9smqr.fsf@lola.quinscape.zz>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59224>

David Kastrup schrieb:
> If $USE_OUTPUT can be either shell function or executable or shell
> function plus args, however...

UTSL: $USE_OUTPUT is either 'output' (ie. a shell function) or empty.

-- Hannes
