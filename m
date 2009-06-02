From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v7 3/3] diff: generate pretty filenames in prep_temp_blob()
Date: Tue, 02 Jun 2009 09:04:08 +0200
Message-ID: <4A24CEE8.4090702@viscovery.net>
References: <1243758952-28972-1-git-send-email-davvid@gmail.com> <1243758952-28972-2-git-send-email-davvid@gmail.com> <1243758952-28972-3-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org, peff@peff.net,
	markus.heidelberg@web.de, jnareb@gmail.com
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 09:04:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBO2y-0001vD-SU
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 09:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757375AbZFBHEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 03:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756728AbZFBHEV
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 03:04:21 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:53687 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756691AbZFBHEV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 03:04:21 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MBO2b-0006aT-OG; Tue, 02 Jun 2009 09:04:10 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 821BEFCD2; Tue,  2 Jun 2009 09:04:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1243758952-28972-3-git-send-email-davvid@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120497>

David Aguilar schrieb:
> Naturally, prep_temp_blob() did not care about filenames.
> As a result, GIT_EXTERNAL_DIFF and textconv generated
> filenames such as ".diff_XXXXXX".
> 
> This modifies prep_temp_blob() to generate user-friendly
> filenames when creating temporary files.
> 
> Diffing "name.ext" now generates "XXXXXX_name.ext".
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>

This series (as per 003b33a from Junio's pu):

Tested-by: Johannes Sixt <j6t@kdbg.org> (Windows)

-- Hannes
