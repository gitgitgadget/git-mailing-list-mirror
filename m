From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Fri, 18 Jan 2008 14:23:38 +0100
Message-ID: <B2CF21CC-2EB0-403C-B7FF-34A2702C81E4@zib.de>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org> <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> 
 <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <7E3714CE-0073-4E42-A455-36D595946A6C@zib.de> <alpine.LSU.1.00.0801181308080.5731@racer.site>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jan 18 14:24:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFrCl-0006O4-GE
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 14:24:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757753AbYARNXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 08:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757976AbYARNXt
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 08:23:49 -0500
Received: from mailer.zib.de ([130.73.108.11]:59894 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757753AbYARNXs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 08:23:48 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0IDMZZ5024605;
	Fri, 18 Jan 2008 14:22:35 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0IDMYMn018227
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Fri, 18 Jan 2008 14:22:34 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0801181308080.5731@racer.site>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71017>


On Jan 18, 2008, at 2:09 PM, Johannes Schindelin wrote:

> On Fri, 18 Jan 2008, Steffen Prohaska wrote:
>
>>
>> On Jan 18, 2008, at 11:40 AM, Junio C Hamano wrote:
>>
>>>  * crlf (Steffen Prohaska and Dmitry Potapov)
>>
>> I am working on an alternative to the patch I sent last week. I  
>> hope I
>> can present the two approaches soon.
>>
>> The first approach is a lazy check in crlf_to_git() that warns  
>> about an
>> irreversible conversion; or dies if safecrlf=true.  This is  
>> relatively
>> simple code but at least for git-add a workaround is needed to  
>> suppress
>> printing a warning twice.  The runtime overhead is negligible.
>>
>> The second approach adds a new machinery is_worktree_crlfsafe()
>> that could be run independently of the crlf_to_git() conversion.
>
> From the sound of it, I like the first approach much better.

Ok.  I'll start with cleaning up the first approach tomorrow and
send resend the patch.


>> I do not expect that this topic will be ready for 1.5.4.
>
> What with our ongoing discussion when to go out of preview phase for
> msysGit, I think this makes sense.

I'll work on creating an improved installer that installs only a
subset of the commands.  I'll exclude commands that are not yet
ready for Windows (e.g.  git-svn, ...).

After we have the first version of this installer we can further
discuss if we leave the preview phase.

	Steffen
