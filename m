From: david@lang.hm
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Fri, 24 Oct 2008 12:54:57 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0810241254330.27333@asgard.lang.hm>
References: <gdok16$vh2$1@ger.gmane.org> <4901077A.7050904@gmx.ch>  <cb7bb73a0810232355u6de0479cyc260c80227f44e59@mail.gmail.com>  <m38wsei8ne.fsf@localhost.localdomain>  <7vabct3l1e.fsf@gitster.siamese.dyndns.org>  <alpine.DEB.1.10.0810241159290.27333@asgard.lang.hm>
  <cb7bb73a0810241242y7467f6fexcca4b7cd768e7992@mail.gmail.com>  <alpine.DEB.1.10.0810241244170.27333@asgard.lang.hm> <cb7bb73a0810241251w4c2486a0x4684a25b364ebbbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Jean-Luc Herren <jlh@gmx.ch>, git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 24 21:56:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtSlh-0000u1-70
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 21:56:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbYJXTzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 15:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751793AbYJXTzI
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 15:55:08 -0400
Received: from mail.lang.hm ([64.81.33.126]:40477 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbYJXTzG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2008 15:55:06 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m9OJsFH8020671;
	Fri, 24 Oct 2008 12:54:15 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <cb7bb73a0810241251w4c2486a0x4684a25b364ebbbb@mail.gmail.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99058>

On Fri, 24 Oct 2008, Giuseppe Bilotta wrote:

> On Fri, Oct 24, 2008 at 9:46 PM,  <david@lang.hm> wrote:
>> On Fri, 24 Oct 2008, Giuseppe Bilotta wrote:
>>>
>>> It seems that tags, hooks, branches and description can be done with.
>>
>> do you mean 'can be done away with'?
>
> Ahem. Yes. I've got a patch ready for zit that gets rid of them.
>
> (A smarter way would be to create a template, but I'm not smart.)
>
>>> info contains exclude which is rather essential,
>>
>> is it? by default everything in this file is commented out. And with you
>> only adding files explicitly why would it ever need to excluded anything?
>
> Zit does
> 		echo "*" > $GIT_DIR/info/exclude
> and yes it sucks to use a whole block for a file that only contains
> one character. Suggestions welcome.

can this be configured in the config file?

> The reason why we want the exclude is that when you do zit status
> somefile you don't want every other file in the directory to come up
> as 'not tracked'.

good point.

David Lang
