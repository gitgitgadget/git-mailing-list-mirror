From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Is a given file known to git?
Date: Tue, 11 Mar 2008 10:36:41 +0100
Message-ID: <47D652A9.4090304@viscovery.net>
References: <47D6317D.7030700@melosgmbh.de> <47D636FC.2060203@viscovery.net> <47D65074.4000505@melosgmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: spearce@spearce.org, git@vger.kernel.org
To: Christoph Duelli <duelli@melosgmbh.de>
X-From: git-owner@vger.kernel.org Tue Mar 11 10:37:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ0vD-0006mb-Lm
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 10:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbYCKJgp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 05:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751274AbYCKJgp
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 05:36:45 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:47757 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbYCKJgo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 05:36:44 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JZ0tr-0003V6-0r; Tue, 11 Mar 2008 10:35:59 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 15FA26EF; Tue, 11 Mar 2008 10:36:42 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <47D65074.4000505@melosgmbh.de>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76819>

Christoph Duelli schrieb:
> Yes, thank you, Johannes and Shawn, this works.
> (A bit slow, though: with this test enabled my script takes 77 secs;
> without it it takes 0.3 secs. The time is spent in 9000 calls to the
> above test (the rev-parse version). (ok, the fact that there is a Perl
> system call around it might take some time, too).)

Oh, you said "a particular path from a bash script". If you had said "9000
particular paths, and I have perl wrapped around it", then there might be
(much) better solutions. Like parsing the output of "git ls-files
--others" or "git ls-tree -r" into a hash and then lookup therein.

-- Hannes
