From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFD: fast-import is picky with author names (and maybe it should
 - but how much so?)
Date: Fri, 02 Nov 2012 15:47:54 +0100
Message-ID: <5093DD1A.1080104@drmicha.warpmail.net>
References: <5093DC0C.5000603@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 15:48:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUIXa-0004xM-2Y
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 15:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753879Ab2KBOr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2012 10:47:57 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:48817 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751597Ab2KBOr4 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Nov 2012 10:47:56 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 53E7620A49
	for <git@vger.kernel.org>; Fri,  2 Nov 2012 10:47:56 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 02 Nov 2012 10:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=KRrryWUZngwH4ii27Yrxf9
	hW2yM=; b=ewS2so00NXfb0beefzmyup9411oCuApwTKkYYt3s4voEp4zesKdHdo
	Rr+9QgDe6cKh45rFybCIXSEDLt7Lue+lYV4l6EuXqLRWu068dCvdRe4+fF3Nbw5t
	TnYTFZ3t8qkdTaCLA5BQm3GlR13kz0DF/yCaJAcRDuG0cuz6SZooQ=
X-Sasl-enc: BkVztFp8IMhe3CV/MsSzS6nfq/kAZAMZF8UdmQGnaTTs 1351867676
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id F0422482491
	for <git@vger.kernel.org>; Fri,  2 Nov 2012 10:47:55 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <5093DC0C.5000603@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208940>

Some additional input:

[mjg@localhost git]$ git commit --author='"is this<ok@or.not>"
<whats@up>' --allow-empty -m test
[detached HEAD 0734308] test
 Author: is thisok@or.not <whats@up>
[mjg@localhost git]$ git show
commit 0734308b7bf372227bf9f5b9fd6b4b403df33b9e
Author: is thisok@or.not <whats@up>
Date:   Fri Nov 2 15:45:23 2012 +0100

    test
