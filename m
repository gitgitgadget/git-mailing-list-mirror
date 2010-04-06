From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFD} Use regex's in :/ revision naming machinery
Date: Tue, 06 Apr 2010 09:55:48 +0200
Message-ID: <4BBAE904.6010105@viscovery.net>
References: <alpine.LFD.2.00.1004051551180.21411@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 06 09:56:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz3do-0002QD-9n
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 09:56:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757366Ab0DFHz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 03:55:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:51590 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757280Ab0DFHz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 03:55:56 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Nz3dV-0006rj-Ct; Tue, 06 Apr 2010 09:55:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 22FEE1660F;
	Tue,  6 Apr 2010 09:55:49 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <alpine.LFD.2.00.1004051551180.21411@i5.linux-foundation.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144112>

Am 4/6/2010 1:00, schrieb Linus Torvalds:
> I never use ':/', and part of it is that it's so horribly cumbersome. I'd 
> _like_ to use it to do things like 
> 
> 	gitk :/slabh..

Rhethoric question: Do you mean history _starting_ at the commit that
contains "slabh" or _ending_ at the commit that contains "slabh" followed
by two arbitrary characters?

If :/ is pattern-ized in some way, then IMO pattern matching syntax would
be more use-friendly than (extended) regular expresssions, particluarly
also because the single-character wildcard would be ? and avoid the
otherwise overloaded dot.

-- Hannes
