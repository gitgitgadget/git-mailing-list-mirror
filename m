From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: remotely deleting a branch
Date: Mon, 01 Jun 2009 12:59:13 +0200
Message-ID: <4A23B481.6000302@isy.liu.se>
References: <1de9d39c0906010316v657f2624i3f16b8b5bea73122@mail.gmail.com> <4A23AE5A.4040804@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jean-luc malet <jeanluc.malet@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 13:22:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB5ak-0000Xb-0Y
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 13:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755407AbZFALWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 07:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755902AbZFALWA
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 07:22:00 -0400
Received: from bogotron.isy.liu.se ([130.236.48.26]:65092 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754916AbZFALWA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 07:22:00 -0400
X-Greylist: delayed 1349 seconds by postgrey-1.27 at vger.kernel.org; Mon, 01 Jun 2009 07:22:00 EDT
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 46D8125AA4;
	Mon,  1 Jun 2009 12:59:32 +0200 (MEST)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 19348-07; Mon,  1 Jun 2009 13:32:53 +0200 (MEST)
Received: from [192.168.13.34] (f051132050.adsl.alicedsl.de [78.51.132.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 68E3025AA0;
	Mon,  1 Jun 2009 12:59:14 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
In-Reply-To: <4A23AE5A.4040804@isy.liu.se>
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120461>

This should of course have been cc to the list too...

Gustaf Hendeby wrote:
> jean-luc malet wrote:
>> hi!
>> I created a remote branch by doing
>> $ git push origin mynewbranch
>> I done some work on mynewbranch, commited, pushed changes to origin,
>> merged it to master and pushed to origin and deleted the mynewbranch
>> localy because I don't need it anymore
>> now I want to "undo" the git push origin mynewbranch ie remotely
>> delete the branch from the repository
>> I tried git push --mirror but it deleted all remote branches that I
>> didn't worked on... I don't want to have it be a mirror... but
>> something like
>> $ git branch -r -d origin/mynewbranch
>> $ git push
>>    ---> deleting origin/mynewbranch
>>
>> how shall I do that?
>> thanks
>> JLM
>>
> 
> Hi Jean-Luc!
> 
> Have a look at the help for push, you will find
> 
>   git push origin :mynewbranch
> 
> to be what you are looking for.  It is listed quite far down as an example.
> 
> /Gustaf
> 
