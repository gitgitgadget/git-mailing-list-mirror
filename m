From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] mergetool: add support for ECMerge
Date: Tue, 9 Oct 2007 14:49:52 +0200
Message-ID: <A3F377CC-DCAB-42E0-8522-8A1D6EE735E9@zib.de>
References: <11918785613855-git-send-email-prohaska@zib.de> <11918785611059-git-send-email-prohaska@zib.de> <20071008214451.GB31713@thunk.org> <1C50C046-3D61-4D55-8D38-B2D563C1FF2A@zib.de> <Pine.LNX.4.64.0710091335580.4174@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 14:50:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfEX9-0003gb-OK
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 14:50:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752094AbXJIMtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 08:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752568AbXJIMtu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 08:49:50 -0400
Received: from mailer.zib.de ([130.73.108.11]:47036 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbXJIMtu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 08:49:50 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l99CmKPP015015;
	Tue, 9 Oct 2007 14:49:42 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l99CmKjo024221
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Tue, 9 Oct 2007 14:48:20 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.64.0710091335580.4174@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60396>


On Oct 9, 2007, at 2:37 PM, Johannes Schindelin wrote:

> On Tue, 9 Oct 2007, Steffen Prohaska wrote:
>
>> I work on the msysgit project and I'd like to have mergetool  
>> available
>> before I advertise git on Windows. It makes merging so much easier ;)
>
> I would _hate_ to rely on a closed source program (in addition to  
> Windows
> itself) in msysGit.

It's only an option. You can also choose kdiff3 if you like, or  
vimdiff or
emacs merge. But personally, I prefer ECMerge because is seems to  
support
a faster and safer workflow (at least for me).

Before submitted this patch I thought about a general mechanism to  
easily
specify any tool that supports command line argument. But just adding  
them
tool by tool as needed looks easier to me, and hopefully to the user. We
can include the correct command line in git-mergetool and only require
the location of the program from the user.


> And it seems that you cannot even get ECMerge for free in general.

True. But does it matter? I can't get Windows for free and git runs  
on it.


> What does TortoiseCVS use?

Don't know.

	Steffen
