From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 6/9] Add tests for git hash-object
Date: Tue, 23 Oct 2007 08:59:26 +0200
Message-ID: <471D9BCE.1010709@viscovery.net>
References: <1193118397-4696-1-git-send-email-aroben@apple.com> <1193118397-4696-2-git-send-email-aroben@apple.com> <1193118397-4696-3-git-send-email-aroben@apple.com> <1193118397-4696-4-git-send-email-aroben@apple.com> <1193118397-4696-5-git-send-email-aroben@apple.com> <1193118397-4696-6-git-send-email-aroben@apple.com> <1193118397-4696-7-git-send-email-aroben@apple.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Adam Roben <aroben@apple.com>
X-From: git-owner@vger.kernel.org Tue Oct 23 08:59:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkDjl-00088H-N2
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 08:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752178AbXJWG73 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 02:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752115AbXJWG73
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 02:59:29 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:33271 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbXJWG72 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 02:59:28 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IkDjK-0003Mn-Pt; Tue, 23 Oct 2007 08:59:10 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8A03D6C4; Tue, 23 Oct 2007 08:59:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1193118397-4696-7-git-send-email-aroben@apple.com>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62116>

Adam Roben schrieb:
> +test_expect_success \
> +    'hash a file' \
> +    "test $hello_sha1 = $(git hash-object hello)"

Put tests in double-quotes; otherwise, the substitutions happen before the 
test begins, and not as part of the test.

-- Hannes
