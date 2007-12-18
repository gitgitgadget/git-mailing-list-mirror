From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Add format-patch option --no-name-prefix.
Date: Tue, 18 Dec 2007 16:54:58 +0100
Message-ID: <4767ED52.9010004@viscovery.net>
References: <1197992574-3464-1-git-send-email-pascal@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pascal@obry.net
To: Pascal Obry <pascal.obry@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 16:55:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4emy-0005N5-6s
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 16:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758AbXLRPzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 10:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755665AbXLRPzB
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 10:55:01 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:44600 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754518AbXLRPzA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 10:55:00 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1J4emo-0005bR-HR; Tue, 18 Dec 2007 16:55:14 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 79DF654D; Tue, 18 Dec 2007 16:54:58 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1197992574-3464-1-git-send-email-pascal@obry.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68766>

Pascal Obry schrieb:
> This option can be used to generate a patch file
> where file names are relative to the Git root
> directory. Such a patch can then be applied with
> the standard patch tool using option -p0.

While I've always wondered what the a/ and b/ prefixes were good for (and
I still do), I also wonder what's so different between typing

     patch -p0
and
     patch -p1

that we need another diff option for it. Ok, on my keyboard 0 is typed
with the right hand, and 1 with the left hand, but... ??

-- Hannes
