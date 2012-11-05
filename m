From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Support for a series of patches, i.e. patchset or changeset?
Date: Mon, 05 Nov 2012 15:40:11 +0100
Message-ID: <5097CFCB.7090506@drmicha.warpmail.net>
References: <CAMPhdO_33CPJv2hAvPuJ10KZ7v_fgP9P2kV_WLVK2tapjQQ5=A@mail.gmail.com> <5097C190.80406@drmicha.warpmail.net> <CAMPhdO-1ar52QGuSzbyFBSKMf48fDb6Bbxw5u3PCuVYxkO2=3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 15:40:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVNqp-0008DO-NQ
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 15:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499Ab2KEOkP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 09:40:15 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:44136 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932490Ab2KEOkN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Nov 2012 09:40:13 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id EF72720AAE;
	Mon,  5 Nov 2012 09:40:12 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Mon, 05 Nov 2012 09:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=vhbh3gdfbb0lXm58V7VCiq
	v5XL0=; b=g75cTjyMBZbYcnOe8Sv0T9J5rGRZwyXx9CYjjT+bUBnRfIB+JyBOAj
	sP2cAKwNfVb7t+je3lptIFg+PasofSCJ7XL9TpvBCtCIM5RV8SAstenNKq9qWJvJ
	rgy906xH6dyNm8F9niaqwLG4PETPquOfQjkibcMffeBjIZo/88JCs=
X-Sasl-enc: loJB3dKdeTLErAFwQTsjvcGx4TUwUqN/hQDX2pyk+Xsu 1352126412
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 775794825CF;
	Mon,  5 Nov 2012 09:40:12 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <CAMPhdO-1ar52QGuSzbyFBSKMf48fDb6Bbxw5u3PCuVYxkO2=3w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209062>

Eric Miao venit, vidit, dixit 05.11.2012 15:12:
> The problem is, most cases we have no idea of the base rev1, and commit rev2
> which it's leading up to. E.g. for a single patch which is between
> commit rev1..rev2,
> how do we find out rev1 and rev2.

So, then the question is: What do you know/have? Is your patch the
output of "git format-patch", "git diff", or just some sort of diff
without any git information?

Michael
