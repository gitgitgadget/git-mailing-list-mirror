From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: push.default, was Re: What's cooking in git.git (Mar 2009, #04; Sat, 14)
Date: Wed, 18 Mar 2009 06:30:53 +0900
Message-ID: <20090318063053.6117@nanako3.lavabit.com>
References: <7vr60z8fkl.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0903171125420.6393@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 17 22:33:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljgus-0000Na-JV
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 22:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbZCQVb4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 17:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752579AbZCQVbz
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 17:31:55 -0400
Received: from karen.lavabit.com ([72.249.41.33]:35896 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998AbZCQVbz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 17:31:55 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 7C0E411B846;
	Tue, 17 Mar 2009 16:31:52 -0500 (CDT)
Received: from 3365.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id IEF3SYRBIRGY; Tue, 17 Mar 2009 16:31:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=DwiZWI57os9FYELWn52+jWI81lS2kioosrDuVgipfyA27LVavDivLpFPqBPGiNLqyQFvSFseZufMZ6DFXGvzAvcNVQzTc2p1OcXFY8K1RXzG3keHNQ7U7XJUydIQCWTLhTZ/p9kqx2pS60OiTTggXitGcZYxcITcQfKUaSiYlS8=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <alpine.DEB.1.00.0903171125420.6393@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113527>

Quoting Johannes Schindelin <Johannes.Schindelin@gmx.de>:

> On Sat, 14 Mar 2009, Junio C Hamano wrote:
>
>> * fg/push-default (Wed Mar 11 23:01:45 2009 +0100) 1 commit
>>  - New config push.default to decide default behavior for push
>> 
>> Replaced the old series with the first step to allow a smooth 
>> transition. Some might argue that this should not give any warning but 
>> just give users this new configuration to play with first, and after we 
>> know we are going to switch default some day, start the warning.
>
> IIRC Steffen posted a patch series earlier, where he initialized 
> remote.origin.push upon clone (I am not sure if he provided a 
> corresponding patch for checkout --track), but personally, I think that 
> would be nicer than having a push.default.

Isn't recent trend to avoid such inconsistency between behavior in an existing repository and behavior in a newly created repository? For example, Jeff calls such inconsistency in

  http://thread.gmane.org/gmane.comp.version-control.git/100339/focus=100433

as "this breaks in my repo, but when I make a test repo it works". Junio even called it 'madness' (^_^;)

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
