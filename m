From: Trevor Harmon <trevor@vocaro.com>
Subject: Re: remote.origin.*pack settings are not honored when repository is specified
Date: Mon, 21 Mar 2011 12:48:04 -0700
Message-ID: <BBA93ABD-C146-4866-AFB9-6E07717AE541@vocaro.com>
References: <982706A6-A00E-43B3-9002-41C8DC084EC9@vocaro.com> <AANLkTina56vfqidyyB0DgkAP2upvkCuW8OshnxzuNVjy@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1082.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Mar 21 20:48:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1l5I-00089V-5l
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 20:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271Ab1CUTrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 15:47:49 -0400
Received: from caiajhbdcaib.dreamhost.com ([208.97.132.81]:54229 "EHLO
	homiemail-a18.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754274Ab1CUTrr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 15:47:47 -0400
X-Greylist: delayed 4615 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Mar 2011 15:47:47 EDT
Received: from homiemail-a18.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a18.g.dreamhost.com (Postfix) with ESMTP id 9EE1A250071;
	Mon, 21 Mar 2011 12:47:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=vocaro.com; h=subject
	:mime-version:content-type:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; q=dns; s=
	vocaro.com; b=mqGKPQl3xKMkQs7dw4PgQgkETG45HQuvtss5qTYnaadHoRkkxu
	ZUon33sh1r1trD4n9QsRA0WmeHuw1NIoR2l0D50kUdNAiQMgkkih/pvqKky5eDo/
	dczXaw67kvJpt1BzpnfzGDMzNmgRP9YvTvfUq9MPazM8jf9NjMNjyxYsc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=vocaro.com; h=subject
	:mime-version:content-type:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; s=
	vocaro.com; bh=zwvhZOnNC2ToTDSWuT0/SAEAvzM=; b=Z/XEfvuhy7NASZ4ZX
	Qko92vTB/s8v0zSo0mi0KFFinJNPM2LbBT4arsfdxJBAP4+e08n1ZIcC50GNDZF7
	YuW+N44SyVoubI0xy4FU2OraHGx5uvlkAuMhAX/Odv7CrZa0T2zZsNYDz/2Yehs2
	Oy03lAAID0sK0XspLVDEE+7Nhg=
Received: from [10.244.200.81] (outbound4.ebay.com [216.113.168.128])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: trevor@vocaro.com)
	by homiemail-a18.g.dreamhost.com (Postfix) with ESMTPSA id 8137B250065;
	Mon, 21 Mar 2011 12:47:46 -0700 (PDT)
In-Reply-To: <AANLkTina56vfqidyyB0DgkAP2upvkCuW8OshnxzuNVjy@mail.gmail.com>
X-Mailer: Apple Mail (2.1082.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169652>

On Mar 21, 2011, at 12:25 PM, Erik Faye-Lund wrote:

> You could use the --upload-pack option when pulling
...
> You should probably look into getting
> it fixed in the external tool, if possible.

Yes, probably the best course of action is to modify the tool so it can accept arbitrary Git parameters as options for its push command, then specify --receive-pack as one of those options. Thanks for your help,

Trevor
