From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Can I prevent someone clone my git repository?
Date: Thu, 08 Jan 2009 09:59:41 +0100
Message-ID: <4965C07D.705@viscovery.net>
References: <856bfe0e0901072303i4fcd3bf6u99790ab9f4170937@mail.gmail.com> <7vr63e42ke.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Emily Ren <lingyan.ren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 10:01:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKqlU-0001h5-66
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 10:01:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbZAHI74 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 03:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753851AbZAHI74
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 03:59:56 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:38843 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807AbZAHI7z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 03:59:55 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LKqjv-0001oK-Nh; Thu, 08 Jan 2009 09:59:44 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8A2A9A865; Thu,  8 Jan 2009 09:59:41 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7vr63e42ke.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104902>

Junio C Hamano schrieb:
> The git-daemon transport deliberately omits authentication, and you cannot
> restrict when they come over the git native transport using a URL like
> git://your-host/repository.git

But you can wrap git daemon by tcpd and configure hosts.allow and
hosts.deny (with all its caveats), if this suits your needs.

-- Hannes
