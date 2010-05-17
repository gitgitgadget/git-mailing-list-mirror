From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Error: Unable to append to logs/HEAD: Permission denied
Date: Mon, 17 May 2010 09:54:34 +0200
Message-ID: <4BF0F63A.1080005@drmicha.warpmail.net>
References: <1274051912050-5063068.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git_user101 <m.aqadjanimemar@student.ru.nl>
X-From: git-owner@vger.kernel.org Mon May 17 09:54:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODv9s-0008Q2-WD
	for gcvg-git-2@lo.gmane.org; Mon, 17 May 2010 09:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754355Ab0EQHyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 May 2010 03:54:36 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:53829 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754102Ab0EQHyf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 May 2010 03:54:35 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3FBB2F783B;
	Mon, 17 May 2010 03:54:27 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Mon, 17 May 2010 03:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=K0qcI16FGA3LtGXT1kh5p0n3XG8=; b=qIWzWPF9pE7ScT4FEEPIbYTzrdoKEnFprcSka0H1EAjF687di7TNGy44oyWQbFcC/IIFSI/yx/jTYcuNYcHRhMpsYFbX/SG86/FZkNAaqkjPL4Q7aWCqRyxwtmzpU79nfZOrzafX2nj7w4x53IxBTa8GxRL6qJjfsjNzCB+NMGc=
X-Sasl-enc: ZYXxuLzbqcWStl/RYM+YRRQMYRb+xTEcsW1NKWj9B7tc 1274082866
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id ACDEE556CB;
	Mon, 17 May 2010 03:54:26 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100503 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <1274051912050-5063068.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147215>

git_user101 venit, vidit, dixit 17.05.2010 01:18:
> 
> Hi,
> when I use the command: git push
> I get these two errors:
> ...
> error: Unable to append to logs/HEAD: Permission denied
> ...
> error: failed to push some refs to 'ssh://remote server'
> 
> However, the changes are pushed in the remote repository.
> 
> Does somebody have any ideas?
> Thanx,

Is this a shared repo by any chance (i.e. accessed by different user
ids, not just by different people using the same git-account)?

Michael
