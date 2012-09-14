From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list/log: document logic with several limiting options
Date: Fri, 14 Sep 2012 09:50:26 +0200
Message-ID: <5052E1C2.1050008@pobox.com>
References: <b23f3c547358b79731c7a25d9ac496138e6ab74d.1347374615.git.git@drmicha.warpmail.net> <7vsjaoil6d.fsf@alter.siamese.dyndns.org> <50509171.9060604@drmicha.warpmail.net> <7vbohbdufz.fsf@alter.siamese.dyndns.org> <50518B13.5010702@drmicha.warpmail.net> <7vvcfh62l3.fsf@alter.siamese.dyndns.org> <5052E0D8.3040500@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Sep 14 09:50:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCQfd-0006K1-5u
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 09:50:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756571Ab2INHu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 03:50:29 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:56951 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756440Ab2INHu2 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 03:50:28 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 36858209F1
	for <git@vger.kernel.org>; Fri, 14 Sep 2012 03:50:28 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 14 Sep 2012 03:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=cZE5EG6qUzoklq04YyA0vO
	LpYhA=; b=XFUNVDbMn0FzLrRbAV2MxQ86kVp/3hHe85wXDkZqGFN28RuotZ6MCQ
	j0McNBOOBqMFm8xSZEX9iuwk7omCcZ5xjRwdgzW5U85zwcZ4zM5joMhCW7aEJi5y
	2pl8YU5q54mElqZIdmEg10pToCKdZSjL2FBvE6MGFUJtX3wWQjCSk=
X-Sasl-enc: u72b0DNfhAb3cr4d5JKFBFck2n2dRO93ka1HhOILCgco 1347609027
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id A53604825A8;
	Fri, 14 Sep 2012 03:50:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <5052E0D8.3040500@drmicha.warpmail.net>
X-Enigmail-Version: 1.4.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205463>

Michael J Gruber venit, vidit, dixit 14.09.2012 09:46:
[snipped, just adding]

...and maybe the meaning of "(or ...)" and "*or*" isn't what I think it
is either?
