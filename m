From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Merging a branch when I don't want conflicts
Date: Mon, 18 May 2009 11:01:56 +0200
Message-ID: <4A112404.6060004@viscovery.net>
References: <93c3eada0905171930m36765d4fued9c2efdc57e51a4@mail.gmail.com>	 <4A10FDC6.2040706@viscovery.net> <93c3eada0905180105n641614eodb0469dceca20bc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Mon May 18 11:02:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5yjY-0008SD-FZ
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 11:02:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753901AbZERJB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 05:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753278AbZERJB5
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 05:01:57 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:60133 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbZERJB4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 05:01:56 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M5yjL-0004Hj-Pj; Mon, 18 May 2009 11:01:56 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 48855FCD2; Mon, 18 May 2009 11:01:55 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <93c3eada0905180105n641614eodb0469dceca20bc9@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Geoff Russell schrieb:
> The file is data coming out of an interactive program which reads
> the entire file, edits and then writes the entire file at which point
> this file is correct
> and all previous versions are obsolete.  I don't really want a merge
> at all, but just
> want to replace the file in the master with the version on the branch.

Ah, so finally you say what you mean ;)

You can define a custom merge driver that always returns the content of
the second branch. See 'man gitattributes'.

-- Hannes
