From: Christoph Duelli <duelli@melosgmbh.de>
Subject: Re: Is a given file known to git?
Date: Tue, 11 Mar 2008 10:41:32 +0100
Message-ID: <47D653CC.3070306@melosgmbh.de>
References: <47D6317D.7030700@melosgmbh.de> <47D636FC.2060203@viscovery.net> <47D65074.4000505@melosgmbh.de> <47D652A9.4090304@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 10:44:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ11b-0000Mc-Ff
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 10:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752339AbYCKJnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 05:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752374AbYCKJnM
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 05:43:12 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:38037 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702AbYCKJnL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 05:43:11 -0400
X-Greylist: delayed 8784 seconds by postgrey-1.27 at vger.kernel.org; Tue, 11 Mar 2008 05:43:11 EDT
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: hvKqOO6Ph79JHUJJIwMxXgzUdNi97hMDGc5n+ojdbo9B56/YXBytmKws+HDNQA471tmH
Received: from mail.melosgmbh.de
	(p5B07A7E6.dip0.t-ipconnect.de [91.7.167.230])
	by post.webmailer.de (mrclete mo6) (RZmta 16.8)
	with ESMTP id z0484ek2B8EPX2 ; Tue, 11 Mar 2008 10:43:10 +0100 (MET)
	(envelope-from: <duelli@melosgmbh.de>)
X-Spam-Status: No, hits=0.0 required=4.0
	tests=AWL: 0.035,BAYES_00: -1.665,TOTAL_SCORE: -1.630
X-Spam-Level: 
Received: from [172.27.1.229] ([172.27.1.229])
	(authenticated user duelli@melosgmbh.de)
	by mail.melosgmbh.de (Kerio MailServer 6.4.1 patch 1);
	Tue, 11 Mar 2008 10:43:09 +0100
User-Agent: Thunderbird 2.0.0.12 (X11/20080213)
In-Reply-To: <47D652A9.4090304@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76823>

Johannes Sixt schrieb:
> Christoph Duelli schrieb:
>> Yes, thank you, Johannes and Shawn, this works.
>> (A bit slow, though: with this test enabled my script takes 77 secs;
>> without it it takes 0.3 secs. The time is spent in 9000 calls to the
>> above test (the rev-parse version). (ok, the fact that there is a Perl
>> system call around it might take some time, too).)
> 
> Oh, you said "a particular path from a bash script". If you had said "9000
> particular paths, and I have perl wrapped around it", then there might be
> (much) better solutions. Like parsing the output of "git ls-files
> --others" or "git ls-tree -r" into a hash and then lookup therein.
> 
> -- Hannes
Right you are ;-)
I just assumed that such a test would be quick, so I didn't worry about 
speed back then. But yes, parsing the output of "igt ls-files" would 
solve that nicely.

Thank you.

-- 
Christoph Duelli
