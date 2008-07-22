From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Hacks for AIX
Date: Tue, 22 Jul 2008 16:42:07 -0500
Message-ID: <egpEt3GbPWBZ1DtILuSJ02MgOG3IyxmMVqfP6ebtANiJ-7fx7sn29Q@cipher.nrlssc.navy.mil>
References: <5855afd30807161057v54ed4112jaea3bc07cebf44d4@mail.gmail.com> <7v3am9sn2p.fsf@gitster.siamese.dyndns.org> <7vd4l9c5ud.fsf@gitster.siamese.dyndns.org> <hT7kYDX9f_eBxi8JC0s7jG9oqm8sZ1QCTlEg1n8Dqus7U98hWLWnBA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Chris Cowan <chris.o.cowan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:43:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPdf-0001Y8-88
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753154AbYGVVmT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753166AbYGVVmT
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:42:19 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50505 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753006AbYGVVmS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:42:18 -0400
Received: by mail.nrlssc.navy.mil id m6MLg8jj025849; Tue, 22 Jul 2008 16:42:08 -0500
In-Reply-To: <hT7kYDX9f_eBxi8JC0s7jG9oqm8sZ1QCTlEg1n8Dqus7U98hWLWnBA@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 22 Jul 2008 21:42:07.0949 (UTC) FILETIME=[CA34EFD0:01C8EC43]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89546>

Brandon Casey wrote:
> Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>>     * /usr/bin/patch - really old version, doesn't do well with some
>>>> diff formats.   I avoid using it.
>>> t4109 seems to use patch to produce expected output for the tests; we
>>> should ship a precomputed expected results.  Do you know of any other
>>> places "patch" is used?
>> As usual, I won't commit this patch unless I hear from people who
>> potentially would benefit from it.  I do not need such a patch myself and
>> I really shouldn't be spending too much of my time on these.
> 
> 
> Unless I'm doing something wrong, this doesn't apply cleanly to master.

I figured out that your patch was against maint.

I see it is now applied to master and it helps out on solaris with old patch.

Now I need to get rid of 'diff -U0' in t1002-read-tree-m-u-2way.sh.

-brandon
