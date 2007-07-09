From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH] branch.autosetupmerge: allow boolean values, or "all"
Date: Sun, 08 Jul 2007 21:59:46 -0400
Message-ID: <46919692.5020708@gnu.org>
References: <Pine.LNX.4.64.0707062252390.4093@racer.site>	<7vhcof2rur.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0707081336020.4248@racer.site> <7vzm2620wp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 09 03:59:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7iXa-0006TX-RE
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 03:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758910AbXGIB7v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 21:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758898AbXGIB7u
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 21:59:50 -0400
Received: from qb-out-0506.google.com ([72.14.204.226]:18238 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758888AbXGIB7t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 21:59:49 -0400
Received: by qb-out-0506.google.com with SMTP id e11so584915qbe
        for <git@vger.kernel.org>; Sun, 08 Jul 2007 18:59:48 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=QYqe1oyXjTKkOR6G618gaygHWVSMh+Dsk9aVH1eaVB/8Yg2L5pCKxnGPOA1D7ntJrlZNPIdMrz5WCPgbV5wosXkawr+7oFR6Ijy0aYWLGn/CnW1J1Prr4hvflavYv5/CwAFYjR4l6mscxZwNR65/15U0CG2RkhII0K3uNIEZ62I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:sender;
        b=Ue0WPyCD4jTqUuFJExvSGbdITpk8U1A/pQuJjVk0dNp28o7zwpqpwMBpSHZ2LuIKPXzx88mx9sJOrh32mPYn8rvrvlFrYcv/u3aVUa7DIss84eC+AdP58oU9wx1tACkrm7B0NMIvt4dMZZPwc+daKdLz/YaDOcMQHtrt5G1cRBM=
Received: by 10.35.70.17 with SMTP id x17mr5758071pyk.1183946388160;
        Sun, 08 Jul 2007 18:59:48 -0700 (PDT)
Received: from scientist.lan ( [65.94.94.105])
        by mx.google.com with ESMTP id 6sm48112657nzn.2007.07.08.18.59.47
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 08 Jul 2007 18:59:47 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.4 (Macintosh/20070604)
In-Reply-To: <7vzm2620wp.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51944>

	> Having prepared the patch below, I do not think if the original
> patch even wanted to have 'all' semantics.  The surrounding text
> only talks about "off a remote branch" and I strongly suspect
> that nobody wanted to do this for a local branch case at all.

If I remember correctly, the problem was that you are not sure that
remote branches are in refs/remotes.

Paolo
