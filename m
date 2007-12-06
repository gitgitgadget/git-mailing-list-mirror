From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: Git and GCC
Date: Wed, 05 Dec 2007 23:49:21 -0800
Message-ID: <1196927361.13109.1.camel@brick>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
	 <20071205.202047.58135920.davem@davemloft.net>
	 <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>
	 <20071205.204848.227521641.davem@davemloft.net>
	 <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>
	 <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Daniel Berlin <dberlin@dberlin.org>,
	David Miller <davem@davemloft.net>, ismail@pardus.org.tr,
	gcc@gcc.gnu.org, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Dec 06 08:49:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0BUG-0001st-BH
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 08:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268AbXLFHtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 02:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753200AbXLFHtP
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 02:49:15 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:7694 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbXLFHtO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 02:49:14 -0500
Received: by rv-out-0910.google.com with SMTP id k20so150040rvb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 23:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=MeU/o1xvgVy36NzsJd+5Y5S3GWHdrZEfa9LiS32TZwQ=;
        b=AdrzRuDp3QlOM/MVBv0B6GF1rbBFPWizjQNYDlJ+XOng2NxAQnK02ioB1thnn95lBRxjKPvNhpjs9a/qLqI6BssUPa2l/4Wv1Qnv7lsCeaLz0mYzsWEjJ1DyT1SpmcaqKg0qsEK6ZzDhXOr7+SPSLQ5FadUp1K9PPZ4QMsUwNBo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=hnq5xcmYY8IhrU/jqmMQ0ejfE0v10L5+JzLAB8ku5LkgI/MKUhxm/+FUXPZ+KNkgEwJPO8vAOGKeYLvHNTTndP7q0hYqhPFJW+Nak/5V3WBn5quJyXDbZyTXygCrOrqe89Ae1fjPhxlCJ+n2ZP1HlkypxZznbeCCxU+22cPmALM=
Received: by 10.141.43.5 with SMTP id v5mr820119rvj.1196927354129;
        Wed, 05 Dec 2007 23:49:14 -0800 (PST)
Received: from ?192.168.1.101? ( [216.19.190.48])
        by mx.google.com with ESMTPS id k41sm51390rvb.2007.12.05.23.49.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Dec 2007 23:49:12 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67266>


> 	git repack -a -d --depth=250 --window=250
> 

Since I have the whole gcc repo locally I'll give this a shot overnight
just to see what can be done at the extreme end or things.

Harvey
