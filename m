From: Adam Roben <aroben@apple.com>
Subject: Re: [PATCH 7/9] git-hash-object: Add --stdin-paths option
Date: Mon, 22 Oct 2007 22:57:08 -0700
Message-ID: <471D8D34.4050104@apple.com>
References: <1193118397-4696-1-git-send-email-aroben@apple.com>
 <1193118397-4696-2-git-send-email-aroben@apple.com>
 <1193118397-4696-3-git-send-email-aroben@apple.com>
 <1193118397-4696-4-git-send-email-aroben@apple.com>
 <1193118397-4696-5-git-send-email-aroben@apple.com>
 <1193118397-4696-6-git-send-email-aroben@apple.com>
 <1193118397-4696-7-git-send-email-aroben@apple.com>
 <1193118397-4696-8-git-send-email-aroben@apple.com>
 <20071023055331.GF14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 07:57:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkClX-00015q-5O
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 07:57:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbXJWF5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 01:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751620AbXJWF5M
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 01:57:12 -0400
Received: from mail-out4.apple.com ([17.254.13.23]:58903 "EHLO
	mail-out4.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751324AbXJWF5L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 01:57:11 -0400
Received: from relay13.apple.com (relay13.apple.com [17.128.113.29])
	by mail-out4.apple.com (Postfix) with ESMTP id E9C681687891
	for <git@vger.kernel.org>; Mon, 22 Oct 2007 22:57:10 -0700 (PDT)
Received: from relay13.apple.com (unknown [127.0.0.1])
	by relay13.apple.com (Symantec Mail Security) with ESMTP id CC10928087
	for <git@vger.kernel.org>; Mon, 22 Oct 2007 22:57:10 -0700 (PDT)
X-AuditID: 1180711d-a15f0bb000000861-61-471d8d36932f
Received: from elliott.apple.com (elliott.apple.com [17.151.62.13])
	by relay13.apple.com (Apple SCV relay) with ESMTP id 4E89228071
	for <git@vger.kernel.org>; Mon, 22 Oct 2007 22:57:10 -0700 (PDT)
Received: from [17.151.66.27] by elliott.apple.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPSA id <0JQC00G4XOJ9LS70@elliott.apple.com> for git@vger.kernel.org;
 Mon, 22 Oct 2007 22:57:09 -0700 (PDT)
In-reply-to: <20071023055331.GF14735@spearce.org>
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62107>

Shawn O. Pearce wrote:
> Adam Roben <aroben@apple.com> wrote:
>   
>> This allows multiple paths to be specified on stdin.
>>     
>
> git-fast-import wasn't suited to the task?
>   

I actually considered using fast-import for the whole shebang, but 
decided that I don't yet understand the workings and structure of 
git-svn well enough to make such a big change.

git-svn uses git-hash-object to both determine a file's hash and insert 
it into the index in one go -- can fast-import do this? Or will it just 
put it in the index and not give you the hash back? The latter was my 
impression.

-Adam
