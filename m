From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Deprecation/Removal schedule
Date: Wed, 7 Feb 2007 11:13:31 +0100
Message-ID: <200702071113.31938.jnareb@gmail.com>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net> <200702070933.21804.jnareb@gmail.com> <20070207093311.258490@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: junkio@cox.net, ae@op5.se, torvalds@linux-foundation.org,
	mdw@distorted.org.uk, peff@peff.net, raa.lkml@gmail.com,
	spearce@spearce.org, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 07 11:12:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEjmg-0005x5-EJ
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 11:12:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161129AbXBGKML (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 05:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030619AbXBGKML
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 05:12:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:51465 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030618AbXBGKMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 05:12:09 -0500
Received: by ug-out-1314.google.com with SMTP id 44so139705uga
        for <git@vger.kernel.org>; Wed, 07 Feb 2007 02:12:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RQtwfAlXL+1zzzYmP4WvNAYotz85qiWRpwGzsSZqzG1+hwAtfOfQPsvrio4aNgQVfEoKo4ScDspgbeV8PUVxBCxMVVB501+zUoBuHFtDr1Qu1SUNeW3R0dJI+N9jquqM99zQh6gHQ+7Bg94mgJoB5KBHhL7IqORk/MenMNRhT6o=
Received: by 10.82.188.15 with SMTP id l15mr1850560buf.1170843120105;
        Wed, 07 Feb 2007 02:12:00 -0800 (PST)
Received: from host-81-190-29-4.torun.mm.pl ( [81.190.29.4])
        by mx.google.com with ESMTP id j3sm770046ugd.2007.02.07.02.11.59;
        Wed, 07 Feb 2007 02:11:59 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20070207093311.258490@gmx.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38907>

Johannes Schindelin wrote:
> Jakub Narebski wrote:
>> Junio C Hamano wrote:
>> 
>>> In 1.5.0, you will still see git-resolve and git-diff-stages,
>>> but they will be removed by 1.5.1.
>> 
>> Well, it is not as if we cannot obtain equivalent of git-diff-stages
>> without this command. Stages are <ours>, <theirs> and <ancestor>
>> (git-merge-base <ours> <theirs>) so I think we can use git-diff-tree
>> with appropriate arguments...
> 
> Not exactly. The stages are in the index. For example, when you have
> conflicts, the stages might not reflect _any_ tree at all! This is
> because _part_ of the changes could be merged, and _part_ of the
> changes conflict.   
> 
> But it does not matter anyway. Good bye diff-stages!

Hmmm... I do wonder if git-diff-stages precedes introduction of combined 
diff format...

-- 
Jakub Narebski
Poland
