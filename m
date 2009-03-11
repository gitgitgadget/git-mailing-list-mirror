From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH] Removed unnecessary use of global variables.
Date: Thu, 12 Mar 2009 06:42:37 +0900
Message-ID: <20090312064237.6117@nanako3.lavabit.com>
References: <1236730168-7164-1-git-send-email-kusmabite@gmail.com>
 <alpine.DEB.1.00.0903111126280.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 11 22:45:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhWEM-0006zR-JX
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 22:44:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727AbZCKVnW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2009 17:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbZCKVnW
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Mar 2009 17:43:22 -0400
Received: from karen.lavabit.com ([72.249.41.33]:52107 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751256AbZCKVnW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2009 17:43:22 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 5160611B8CF;
	Wed, 11 Mar 2009 16:43:20 -0500 (CDT)
Received: from 7328.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id CKARRTXRMUFQ; Wed, 11 Mar 2009 16:43:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=byEBRJPtdEcvQIlGynr+lcT722CtEt7RWhW+8/oQBn4FpKmSVz6vkf1Yi+hk2mjkfCRBRglX8Uf96Dx62AibMRHl/wJxGSRQqxrgdztHrKDO1PATPLW2XFWcrGjZdlJc+WwTHuaY8JGRM8CICw6wXKYWSQEBohQYjHNj4s5qs8U=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <alpine.DEB.1.00.0903111126280.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112979>

Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> Hi,
>
> On Wed, 11 Mar 2009, Erik Faye-Lund wrote:
>
>> git_config() now takes a third data-parameter that is passed back
>> to the callback-function. At the time this code was written, that
>> parameter did not exist, so a somewhat nasty (but by all means
>> correct) use of global variables was introduced. In commit
>> ef90d6d4208a5130185b04f06e5f90a5f9959fe3 Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> introduced a parameter for similar
>> purposes.
>
> We tend to quote commits in this form: ef90d6d(Provide git_config with a 
> callback-data parameter)

Your review comments are a subset of the ones Junio sent about 8 hours before you did, and are almost identical except for the comment on the subject line yours didn't have. I'm curious about two things.

1. Are you and Junio one same person, and if so what made you change your mind during these 8 hours ;-)?

2. Junio said "ef90d6d (Provide git_config with a callback-data parameter, 2008-05-14)" and yours is slightly different. Both are equally readable but I think it would help to make sure everybody uses the same format within one project. Do we need a helper command that everybody can use?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
