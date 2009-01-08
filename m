From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Can I prevent someone clone my git repository?
Date: Thu, 08 Jan 2009 10:41:30 +0100
Message-ID: <4965CA4A.3070101@viscovery.net>
References: <856bfe0e0901072303i4fcd3bf6u99790ab9f4170937@mail.gmail.com>	 <7vr63e42ke.fsf@gitster.siamese.dyndns.org>	 <4965C07D.705@viscovery.net> <856bfe0e0901080133q68d0008ao1abf9d235e70279e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Emily Ren <lingyan.ren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 08 10:43:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKrPq-00061o-Iu
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 10:43:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbZAHJlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 04:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752664AbZAHJlj
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 04:41:39 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:60291 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbZAHJli (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 04:41:38 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LKrOP-0001E2-N8; Thu, 08 Jan 2009 10:41:34 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 64372A865; Thu,  8 Jan 2009 10:41:30 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <856bfe0e0901080133q68d0008ao1abf9d235e70279e@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104909>

Emily Ren schrieb:
> Could you give me a detailed steps on how to wrap git daemon by tcpd?

Sorry, no, I haven't done that myself. I would look into /etc/xinetd.d/*
how tcpd is used with other protocols and merge that information with the
examples in the man page of git daemon.

-- Hannes
