From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC] clone: inform the user we are checking out
Date: Mon, 07 May 2012 11:26:04 +0200
Message-ID: <4FA7952C.90702@viscovery.net>
References: <1336381787-6484-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 11:26:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRKCt-0005sf-O7
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 11:26:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755789Ab2EGJ0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 May 2012 05:26:10 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:47229 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755564Ab2EGJ0K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 May 2012 05:26:10 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SRKCk-00074D-0O; Mon, 07 May 2012 11:26:06 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4ABB51660F;
	Mon,  7 May 2012 11:26:05 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <1336381787-6484-1-git-send-email-kusmabite@gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197247>

Am 5/7/2012 11:09, schrieb Erik Faye-Lund:
> When cloning a large repository over a local file-system
...
> $ git clone some-repo.git some-other-repo
> Cloning into 'some-other-repo'...    <happens instantly>
> done.                                <hangs for minutes>
> $
...
> I asked git
> to clone, and it told me it finished, only to hang around for
> several minutes while, judging by the output, doing nothing.

We have a nice "Checking out files" progress indicator. I wonder why you
do not see it.

At any rate, it's better to write "done" only after we're really done.

-- Hannes
