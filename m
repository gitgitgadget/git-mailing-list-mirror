From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: Git and GCC
Date: Wed, 05 Dec 2007 20:28:39 -0800
Message-ID: <1196915319.10408.71.camel@brick>
References: <4aca3dc20712051841o71ab773ft6dd0714ebc355dd5@mail.gmail.com>
	 <20071205.185203.262588544.davem@davemloft.net>
	 <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>
	 <20071205.202047.58135920.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: dberlin@dberlin.org, ismail@pardus.org.tr, gcc@gcc.gnu.org,
	git@vger.kernel.org
To: David Miller <davem@davemloft.net>
X-From: git-owner@vger.kernel.org Thu Dec 06 05:28:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J08M1-00049t-Sh
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 05:28:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbXLFE2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 23:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbXLFE2e
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 23:28:34 -0500
Received: from rv-out-0910.google.com ([209.85.198.186]:40819 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbXLFE2d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 23:28:33 -0500
Received: by rv-out-0910.google.com with SMTP id k20so96709rvb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 20:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=gqON9QxKwGrsxaFZSOUlQ511W9JZU267/fV/jDnVd6w=;
        b=vK4p6knD7XQPW/CLeveqnFvpkdtSA7FFJhsbU9rn5zxTLUWp9pc9YpdHqxvhVHmj2hOH/sqSWeCVKa+vMgnOyGrWWtKtgIFriyz8sLqErIrSPfLlAZjHAQKUEzkgKw0El1XwkTtyAzysbUlr/AhxvUgts2/epE+cAx3Fqn+DOQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=xJpA3muEUFFOJoSDD3r+a6z1vw1/cVhNpOZXX4DS5IQg+8hCvCMcT52RzJ4jta7Xez8Q7rQSNhRwpoiQ/WvQu+lppuYc5+ATOazLGkao4dhz2LWOzL3UA3uZIIXQqNbvLLhio+Av4EDxHNRfrT6IcjHYhlau3uxj64HI20tNK2E=
Received: by 10.141.145.11 with SMTP id x11mr1709971rvn.1196915312666;
        Wed, 05 Dec 2007 20:28:32 -0800 (PST)
Received: from ?192.168.1.101? ( [216.19.190.48])
        by mx.google.com with ESMTPS id c14sm269964rvf.2007.12.05.20.28.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 05 Dec 2007 20:28:31 -0800 (PST)
In-Reply-To: <20071205.202047.58135920.davem@davemloft.net>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67230>


On Wed, 2007-12-05 at 20:20 -0800, David Miller wrote:
> From: "Daniel Berlin" <dberlin@dberlin.org>
> Date: Wed, 5 Dec 2007 22:47:01 -0500
> 
> > The size is clearly not just svn data, it's in the git pack itself.
> 
> And other users have shown much smaller metadata from a GIT import,
> and yes those are including all of the repository history and branches
> not just the trunk.

David, I think it is actually a bug in git gc with the --aggressive
option...mind you, even if he solves that the format git svn uses
for its bi-directional metadata is so space-inefficient Daniel will
be crying for other reasons immediately afterwards...4MB for every
branch and tag in gcc svn (more than a few thousand).

You only need it around for any branches you are planning on committing
to but it is all created during the default git svn import.

FYI

Harvey
