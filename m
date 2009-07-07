From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Tue, 07 Jul 2009 08:30:39 +0200
Message-ID: <4A52EB8F.1010806@viscovery.net>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Nick Edelen <sirnot@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 08:31:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MO4Cl-0008TP-Np
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 08:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210AbZGGGao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2009 02:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755667AbZGGGao
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Jul 2009 02:30:44 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:30561 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbZGGGao (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2009 02:30:44 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MO4CO-00052R-Dp; Tue, 07 Jul 2009 08:30:41 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D49AA55DD; Tue,  7 Jul 2009 08:30:39 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122822>

Junio C Hamano schrieb:
> * ne/futz-upload-pack (Wed Jun 10 01:50:18 2009 +0200) 1 commit
>  - Shift object enumeration out of upload-pack

I'm interested in this one because it is a step towards improved behavior
of upload-pack on Windows if the repository is corrupted[*]. This patch
covers the common case where shallow clones are out of the game, but it is
not ready for prime time until its implementation is complete. IIUC, this
should be a fall-out of a GSoC project. Until then I include it in my git.

[*] One test case in t5530 still fails on Windows, because for some reason
errors are not reported correctly. It has to do with the rev-list being
run in a thread and that thread die()s.

-- Hannes
