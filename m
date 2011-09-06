From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv3 5/5] branch: allow pattern arguments
Date: Tue, 06 Sep 2011 18:11:16 +0200
Message-ID: <4E664624.7050209@drmicha.warpmail.net>
References: <cover.1314367414.git.git@drmicha.warpmail.net> <0c487086643fbf0334140365f20fef62242b7dac.1314543252.git.git@drmicha.warpmail.net> <4E661BDE.1080204@elegosoft.com> <4E662C6F.7000205@drmicha.warpmail.net> <CAGdFq_jmW+VZygVj73EP_1oB5DDNp5rYZgZq+i9zf3w6BpsMYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael Schubert <mschub@elegosoft.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 06 18:12:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0yFk-0004ye-Qi
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 18:12:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755248Ab1IFQLY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 12:11:24 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:54560 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755235Ab1IFQLT (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2011 12:11:19 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id DF91324EFD;
	Tue,  6 Sep 2011 12:11:18 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Tue, 06 Sep 2011 12:11:18 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=3Y5iKIZtuGQ36H4VmhSaVN
	V7OOM=; b=MhrjgoXR52uaFnQugEkX5cdoGBT6Ofo8GeNkZc0PlkQjTzTHDpwsY5
	MZRKs5SNNA2OxJ0nY7T8c0Y1htQXcbIBU3cncqGO3KkZqyQMSS3P10QSVsUC5Bk1
	UMvpaKNvlXjYy1Xa5kZlRvTNc1Z9mTUmEO+uENI7B6MD5WKHd0LOQ=
X-Sasl-enc: 1milUYuL8ZU0meVkhO+O2UIHMChAV3DVfVZ81bqmMcDm 1315325478
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B44D38E0244;
	Tue,  6 Sep 2011 12:11:17 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:6.0) Gecko/20110816 Thunderbird/6.0
In-Reply-To: <CAGdFq_jmW+VZygVj73EP_1oB5DDNp5rYZgZq+i9zf3w6BpsMYA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180811>

Sverre Rabbelier venit, vidit, dixit 06.09.2011 16:26:
> Heya,
> 
> On Tue, Sep 6, 2011 at 16:21, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> Have you ever tried to delete a remote branch?
>>
>> git branch -r -d origin/maint # workee
>> git branch -r -d remotes/origin/maint # no workee
>>
>> Without -r, it doesn't work either.
> 
> Heh, I read this as "worktree" / "no worktree" at least 4 times.
> 

Yes, our require_work_tree should really be renamed to

no_worktree_no_workee

The beauty of pidgin english ;)

Michael
