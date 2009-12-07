From: walter harms <wharms@bfs.de>
Subject: Re: help: bisect single file from repos
Date: Mon, 07 Dec 2009 17:05:10 +0100
Message-ID: <4B1D27B6.7010900@bfs.de>
References: <4B1CFC4C.6090406@bfs.de> <4B1D1A5A.9060004@drmicha.warpmail.net>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Dec 07 17:05:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHg5c-00051y-6U
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 17:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934614AbZLGQFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 11:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933600AbZLGQFT
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 11:05:19 -0500
Received: from mx.sz.bfs.de ([194.94.69.70]:34097 "EHLO mx.sz.bfs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933585AbZLGQFR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 11:05:17 -0500
Received: from mail.sz.bfs.de (mail.sz.bfs.de [192.168.0.1])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx.sz.bfs.de (BfS Mail Relay SZ) with ESMTP
	id C51B7288DB2; Mon,  7 Dec 2009 17:05:22 +0100 (CET)
Received: from localhost (unknown [192.168.2.47])
	by mail.sz.bfs.de (BfS Mail Hub) with ESMTP id 8F3B7E390A;
	Mon,  7 Dec 2009 17:05:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bfs.de
Received: from mail.sz.bfs.de ([192.168.2.193])
	by localhost (amavis-sz.sz.bfs.de [192.168.2.47]) (amavisd-new, port 10024)
	with ESMTP id rTmypqDgje5K; Mon,  7 Dec 2009 17:05:13 +0100 (CET)
Received: from dc-slave2-fr.fr.bfs.de (unknown [10.177.18.200])
	by mail.sz.bfs.de (BfS Mail Hub) with ESMTP id F3891E3900;
	Mon,  7 Dec 2009 17:05:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dc-slave2-fr.fr.bfs.de (Postfix) with ESMTP id 99FE9DB260;
	Mon,  7 Dec 2009 17:05:11 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dc-slave2-fr.fr.bfs.de (Postfix) with ESMTP id 6F0B4DB261;
	Mon,  7 Dec 2009 17:05:11 +0100 (CET)
X-Virus-Scanned: by amavisd-new-2.4.2 (20060627) (Debian) at fr.bfs.de
Received: from dc-slave2-fr.fr.bfs.de ([127.0.0.1])
	by localhost (dc-slave2-fr.fr.bfs.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A9Mex4GOGBSs; Mon,  7 Dec 2009 17:05:11 +0100 (CET)
Received: from [134.92.181.33] (unknown [134.92.181.33])
	by dc-slave2-fr.fr.bfs.de (Postfix) with ESMTP id 15736DB260;
	Mon,  7 Dec 2009 17:05:10 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <4B1D1A5A.9060004@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134762>



Michael J Gruber schrieb:
> walter harms venit, vidit, dixit 07.12.2009 13:59:
>> Hi list,
>> i am new to git (using: git version 1.6.0.2).
> 
> though your git is not that new ;)
> 
>> I would like to bisect a single file but i have only commit id, no tags.
>>
>> Background:
>> I have a copy of the busybox git repos, and i know there is (perhaps) a bug
>> in ash.c.
>>
>> how can i do that ?
> 
> You don't need any tags for bisecting. The man page of git-bisect has
> several examples on how to use it. Do you have a test script which
> exposes the bug?
> 

unfortunately no, the error shows up very nicely when booting my embdedded system
but not else (this is the reason i would to bisect that file only and not busybox
completely). And from the man pages i got the impression that it is only possible the
start with a tag.

i already had the hint that i need to do:
git bisect start bad_commit_id good_commit_id -- ash.c

Ntl, there is one more question, how can i make sure that
i use the right version ? first i toughed  that cherry-pick is the right idea
but it seems that that will apply onyl certain patches ?

re,
 wh
