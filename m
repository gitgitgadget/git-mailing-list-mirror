From: Adam Roben <aroben@apple.com>
Subject: Re: [PATCH] git-svn: Add 'find-rev' command
Date: Sun, 29 Apr 2007 13:31:34 -0700
Message-ID: <31790C65-1FE6-4BD4-B8D3-B285F0F0422A@apple.com>
References: <1177835727239-git-send-email-aroben@apple.com> <20070429183515.GF12375@untitled>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Apr 29 22:32:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiG3v-0003uy-7W
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 22:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031395AbXD2UcA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 16:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031410AbXD2UcA
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 16:32:00 -0400
Received: from mail-out3.apple.com ([17.254.13.22]:54195 "EHLO
	mail-out3.apple.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031395AbXD2Ub7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Apr 2007 16:31:59 -0400
Received: from relay5.apple.com (a17-128-113-35.apple.com [17.128.113.35])
	by mail-out3.apple.com (8.13.8/8.13.8) with ESMTP id l3TKVvmC010922;
	Sun, 29 Apr 2007 13:31:57 -0700 (PDT)
Received: from relay5.apple.com (unknown [127.0.0.1])
	by relay5.apple.com (Symantec Mail Security) with ESMTP id 285BC29C006;
	Sun, 29 Apr 2007 13:31:57 -0700 (PDT)
X-AuditID: 11807123-9fdd7bb0000013cb-ae-463500bd2e4f 
Received: from [17.219.212.71] (unknown [17.219.212.71])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by relay5.apple.com (Apple SCV relay) with ESMTP id A012130400B;
	Sun, 29 Apr 2007 13:31:49 -0700 (PDT)
In-Reply-To: <20070429183515.GF12375@untitled>
X-Mailer: Apple Mail (2.752.3)
X-Brightmail-Tracker: AAAAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45836>

On Apr 29, 2007, at 11:35 AM, Eric Wong wrote:

> Also, if you have time, can you get this (and 'log') to understand
> revision numbers even if they're not from the working HEAD?  Thanks.

    Won't the following code accomplish that for find-rev? Perhaps I  
misunderstand you.

>
>> +sub cmd_find_rev {
>> +	my $revision_or_hash = shift;
>> +	my $result;
>> +	if ($revision_or_hash =~ /^r\d+$/) {
>> +		my $head = shift;
>> +		$head ||= 'HEAD';
>> +		my @refs;
>> +		my (undef, undef, undef, $gs) = working_head_info($head, \@refs);

-Adam
