From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What's cooking in git.git (Sep 2011, #04; Mon, 12)
Date: Tue, 13 Sep 2011 14:05:14 +0200
Message-ID: <4E6F46FA.90400@drmicha.warpmail.net>
References: <7v4o0h7byd.fsf@alter.siamese.dyndns.org> <7v1uvl2wd1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 13 14:05:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3Rk5-0000jJ-4X
	for gcvg-git-2@lo.gmane.org; Tue, 13 Sep 2011 14:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264Ab1IMMFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 08:05:20 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:57141 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752933Ab1IMMFT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2011 08:05:19 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EAC192B384;
	Tue, 13 Sep 2011 08:05:17 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Tue, 13 Sep 2011 08:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=FvGtsDq2yIdXhYozg2aWcJ
	pBd5U=; b=jqK8tpsR/1S6kljBhLxSzv1ErFn6XpcmK2vldSzKAXXwIHRBD3QAiG
	/K4PyBRrZQrV2p/vjlW/+wh5EJ299p3R5MsUn2PfyyyDZEVZNLLhh+MXu+vqZku6
	ocEGdpKUVszyCCk0eRsTwStTJFzyj/tmey8AJ+mU+wmiBaK3w6YUM=
X-Sasl-enc: OBcOsUXztmc64YCm7XftKHXnU6RRZzaCpbJ+ucuAUabL 1315915517
Received: from localhost.localdomain (vpn-136-057.rz.uni-augsburg.de [137.250.136.57])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B6648660131;
	Tue, 13 Sep 2011 08:05:16 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0.2) Gecko/20110906 Thunderbird/6.0.2
In-Reply-To: <7v1uvl2wd1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181283>

Junio C Hamano venit, vidit, dixit 13.09.2011 00:58:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> * rj/maint-t9159-svn-rev-notation (2011-09-11) 1 commit
>>  - t9159-*.sh: Add an svn version check
> 
> Ack/Nack from people involved in git-svn and/or the patch, please?

Not much time due to conference this week. Don't we have a version check
somewhere else in the tests already? (I may be mixing it up with git-svn
proper.) We should not dupe that and anyways libify or define a
prerequisite.

Michael
