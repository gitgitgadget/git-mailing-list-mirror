From: Adam Roben <aroben@apple.com>
Subject: Re: [PATCH] Add commit.editor configuration variable
Date: Wed, 18 Jul 2007 23:17:55 -0700
Message-ID: <47EE39C7-0D57-48EC-B5A0-C10E49997E32@apple.com>
References: <11848235881723-git-send-email-aroben@apple.com> <7v7iox3oz8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0 (Apple Message framework v895)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 08:18:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBPKp-0006hu-K2
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 08:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbXGSGR4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 02:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751952AbXGSGR4
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 02:17:56 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:61030 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbXGSGR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 02:17:56 -0400
Received: from relay8.apple.com (relay8.apple.com [17.128.113.38])
	by mail-out4.apple.com (Postfix) with ESMTP id B51E9C67BE6;
	Wed, 18 Jul 2007 23:17:55 -0700 (PDT)
Received: from relay8.apple.com (unknown [127.0.0.1])
	by relay8.apple.com (Symantec Mail Security) with ESMTP id A5760400EF;
	Wed, 18 Jul 2007 23:17:55 -0700 (PDT)
X-AuditID: 11807126-a7448bb0000007e3-90-469f0213122e
Received: from [17.112.108.175] (unknown [17.112.108.175])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by relay8.apple.com (Apple SCV relay) with ESMTP id 7C95C40080;
	Wed, 18 Jul 2007 23:17:55 -0700 (PDT)
In-Reply-To: <7v7iox3oz8.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Apple Mail (2.895)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52942>

On Jul 18, 2007, at 11:08 PM, Junio C Hamano wrote:

> I do not think commit.editor is a good name.  Wouldn't we want
> that customized editor for "git tag -a" as well?  Probably
> core.editor would come nicely next to core.pager we already
> have.

    I considered core.editor, but if it's an editor that is *only*  
used for commit messages then that seems to be a too-general name, and  
something like core.commit_message_editor seemed far too long. Any  
suggestions?

    I had forgotten about "git tag -a" -- I will add support for that  
as well.

-Adam
