From: Andreas Ericsson <ae@op5.se>
Subject: Re: NT directory traversal speed on 25K files on Cygwin
Date: Mon, 27 Feb 2006 10:19:09 +0100
Message-ID: <4402C40D.2010805@op5.se>
References: <Pine.LNX.4.63.0602222259480.6682@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com> <7vwtfmihts.fsf@assigned-by-dhcp.cox.net> <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com> <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se> <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com> <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com> <20060226195552.GA30735@trixie.casa.cgf.cx> <20060226231701.GA11961@nospam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christopher Faylor <me@cgf.cx>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 10:19:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDeXI-00046f-6l
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 10:19:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718AbWB0JTO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 04:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbWB0JTN
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 04:19:13 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:44458 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751710AbWB0JTM
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 04:19:12 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 19A906BD22; Mon, 27 Feb 2006 10:19:10 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@wingding.demon.nl
In-Reply-To: <20060226231701.GA11961@nospam.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16832>

Rutger Nijlunsing wrote:
> On Sun, Feb 26, 2006 at 02:55:52PM -0500, Christopher Faylor wrote:
> 
>>On Thu, Feb 23, 2006 at 03:07:07PM +0100, Alex Riesen wrote:
>>
>>>filesystem is slow and locked down, and exec-attribute is NOT really
>>>useful even on NTFS (it is somehow related to execute permission and
>>>open files.  I still cannot figure out how exactly are they related).
>>
>>Again, it's not clear if you're talking about Windows or Cygwin but
>>under Cygwin, in the default configuration, the exec attribute means the
>>same thing to cygwin as it does to linux.
> 
> 
> I don't know about native Windows speed, but comparing NutCracker with
> Cygwin on a simple 'find . | wc -l' already gives a clue that looking
> at Cygwin to benchmark NT file inspection IO will give a skewed
> picture:
> 

Well, naturally. Cygwin is a userland implementation of a sane 
filesystem on top of a less sane one. File IO is bound to be slower when 
one FS is emulated on top of another. I think cygwin users are aware of 
this and simply accept the speed-for-sanity tradeoff. I know I would.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
