From: Andreas Ericsson <ae@op5.se>
Subject: Re: Problem with large files on different OSes
Date: Thu, 28 May 2009 10:52:36 +0200
Message-ID: <4A1E50D4.2010203@op5.se>
References: <m3y6siboij.fsf@localhost.localdomain>	 <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain>	 <alpine.LFD.2.00.0905271312220.3906@xanadu.home>	 <20090527215314.GA10362@coredump.intra.peff.net>	 <alpine.LFD.2.01.0905271457310.3435@localhost.localdomain>	 <f95910c20905271609u63d04965oa38b8af34d7704c1@mail.gmail.com>	 <alpine.LFD.2.01.0905271825520.3435@localhost.localdomain>	 <alpine.LFD.2.00.0905272312370.3906@xanadu.home>	 <loom.20090528T041831-21@post.gmane.org>	 <20090528043019.GA30527@spearce.org> <279b37b20905272252i3d98b6bv698ff636d61ee058@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 10:52:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9bLv-0001QM-NT
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 10:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762112AbZE1Iwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 04:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759462AbZE1Iwe
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 04:52:34 -0400
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:33657 "HELO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759318AbZE1Iwd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 04:52:33 -0400
Received: from source ([72.14.220.158]) by na3sys009aob103.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSh5Q0ufAtx8SjtxqTU+NgLFNyO6wd64X@postini.com; Thu, 28 May 2009 01:52:35 PDT
Received: by fg-out-1718.google.com with SMTP id e12so1960702fga.10
        for <git@vger.kernel.org>; Thu, 28 May 2009 01:52:33 -0700 (PDT)
Received: by 10.86.59.2 with SMTP id h2mr1280734fga.30.1243500753487;
        Thu, 28 May 2009 01:52:33 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id l12sm4677045fgb.16.2009.05.28.01.52.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 01:52:33 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <279b37b20905272252i3d98b6bv698ff636d61ee058@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120172>

Eric Raible wrote:
> On Wed, May 27, 2009 at 9:30 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
>> Eric Raible <raible@gmail.com> wrote:
>>> Nicolas Pitre <nico <at> cam.org> writes:
>>>> On Wed, 27 May 2009, Linus Torvalds wrote:
>>>>
>>>>> +pack.packDeltaLimit::
>>>>> + The default maximum size of objects that we try to delta.
>>>> The option name feels a bit wrong here, like if it meant the max number
>>>> of deltas in a pack.  Nothing better comes to my mind at the moment
>>>> though.
>>> pack.maxDeltaSize sounds weird when said aloud.
>>> How about pack.deltaMaxSize?
>> That sounds like, how big should a delta be?  E.g. set it to 200
>> and any delta instruction stream over 200 bytes would be discarded,
>> causing the whole object to be stored instead.  Which is obviously
>> somewhat silly, but that's the way I'd read that option...
>>
>> --
>> Shawn.
> 
> You're right, that _is_ a strange color for the bike shed...

Since 'delta' names both the action and the result of the action, it's
tricky to get it unambiguous without helping the grammar along a little.

    pack.maxFileSizeToDelta

is probably the shortest we're going to get it while avoiding ambiguity.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
