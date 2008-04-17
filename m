From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Problem with tar while installing git
Date: Thu, 17 Apr 2008 13:46:24 +0200
Message-ID: <48073890.8060405@viscovery.net>
References: <4c610e240804170435p7a628e4bo84c92f4eb4bb7a34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Miguel Vaz <hepaminondas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 13:47:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmSaF-0007vP-WF
	for gcvg-git-2@gmane.org; Thu, 17 Apr 2008 13:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbYDQLqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2008 07:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbYDQLqf
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Apr 2008 07:46:35 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:45016 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbYDQLqe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2008 07:46:34 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JmSZT-00034m-8i; Thu, 17 Apr 2008 13:46:31 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8EE7B6D9; Thu, 17 Apr 2008 13:46:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <4c610e240804170435p7a628e4bo84c92f4eb4bb7a34@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79788>

Miguel Vaz schrieb:
> make[1]: Entering directory `/home/mvaz/git-1.5.5/templates'
> install -d -m 755 '/home/mvaz/local/share/git-core/templates/'
> (cd blt && tar cf - .) | \
> (cd '/home/mvaz/local/share/git-core/templates/' && umask 022 && tar xf -)
> tar: This does not look like a tar archive
> tar: Skipping to next header
> tar: Archive contains obsolescent base-64 headers
> tar: Error exit delayed from previous errors
> make[1]: *** [install] Error 2
> make[1]: Leaving directory `/home/mvaz/git-1.5.5/templates'
> make: *** [install] Error 2
> 
> Any thoughts?

If you type 'cd templates && cd blt', does the shell echo something back
to you? Yes? Does 'unexport CDPATH' make a difference?

-- Hannes
