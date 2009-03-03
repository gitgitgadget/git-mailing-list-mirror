From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCHv4 2/2] git submodule: Fix adding of submodules at paths
 with ./, .. and //
Date: Tue, 03 Mar 2009 16:28:23 +0100
Message-ID: <49AD4C97.6010806@viscovery.net>
References: <49AD3A29.10404@drmicha.warpmail.net> <1236092901-28500-1-git-send-email-git@drmicha.warpmail.net> <1236092901-28500-2-git-send-email-git@drmicha.warpmail.net> <1236092901-28500-3-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Andrei Thorp <garoth@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 03 16:30:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeWZG-0006bb-8s
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 16:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbZCCP2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 10:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754024AbZCCP2d
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 10:28:33 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:53681 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735AbZCCP2c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 10:28:32 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LeWXf-0005wa-I4; Tue, 03 Mar 2009 16:28:23 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 30E0F6B7; Tue,  3 Mar 2009 16:28:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <1236092901-28500-3-git-send-email-git@drmicha.warpmail.net>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112085>

Michael J Gruber schrieb:
> Make 'git submodule add' normalize the submodule path in the
> same way as 'git ls-files' does, so that 'git submodule init' looks up
> the information in .gitmodules with the same key under which 'git
> submodule add' stores it.
> 
> This fixes 4 known breakages.
> ---

OK!

Tested-by: Johannes Sixt <j6t@kdbg.org> (AIX)

but really, I ran only: cd t && make *submodule*

You certainly will sign off this patch?

-- Hannes
