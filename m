From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [BUG?] git rebase -i
Date: Fri, 14 Dec 2007 08:30:49 +0100
Message-ID: <47623129.2030303@viscovery.net>
References: <2791F15A-EB72-4FE4-8DB3-7A4B4DCB07B3@frim.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Pieter de Bie <frim@frim.nl>
X-From: git-owner@vger.kernel.org Fri Dec 14 08:31:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J350u-0008Um-Tj
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 08:31:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829AbXLNHaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 02:30:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755606AbXLNHaz
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 02:30:55 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:14740 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199AbXLNHay (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 02:30:54 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J350o-0007K3-K0; Fri, 14 Dec 2007 08:31:10 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 43D3A6B7; Fri, 14 Dec 2007 08:30:49 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <2791F15A-EB72-4FE4-8DB3-7A4B4DCB07B3@frim.nl>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68254>

Pieter de Bie schrieb:
> Another thing to note is
> that the 1.5.4.rc0 tries to apply 215 patches, while the 1.5.3.5 tries
> to apply 206 patches.

This is to be expected: 1.5.3.5 counts the comment lines at the top of the
action file, of which there are exactly 9, 1.5.4.rc0 does not count them.

-- Hannes
