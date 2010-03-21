From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] .mailmap: Entries for Alex =?ISO-8859-1?Q?Benn=E9e=2C?=
 =?ISO-8859-1?Q?_Deskin_Miller=2C_Vitaly_=22=5FVi=22_Shukela?=
Date: Sun, 21 Mar 2010 14:36:13 +0100
Message-ID: <4BA620CD.3060101@drmicha.warpmail.net>
References: <cd13e44f33c1f6bc9ec11903c3041199c9c464ee.1268996321.git.git@drmicha.warpmail.net> <7vr5nfowgz.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.1003201405100.31128@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sun Mar 21 14:36:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtLK8-0004oW-5F
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 14:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789Ab0CUNfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 09:35:54 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58918 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752571Ab0CUNfx (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Mar 2010 09:35:53 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 213F0E9781;
	Sun, 21 Mar 2010 09:35:53 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 21 Mar 2010 09:35:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=jqkXfXsxlEVW0kr46upPgiW+Ajg=; b=hyZytQ998LP88+ZArLUPKSuSlhCrtciXofvrA1iNeqyAP4oraZLjo3vr+S68RcKXup9gFaQxHwJbnsVvyp29xzx2LLRvao+aquNWpmFtHfdBaCYNnBxUwJYxy4XamchrGBlpRXE20KxiyYWmQwLXhb5SfvNW4dWoNRGRO7WmlPo=
X-Sasl-enc: Mq703vdQleLCeoZIvwAItK/I66hEW5/0ZHsLhEMJPjij 1269178552
Received: from localhost.localdomain (p3EE280DF.dip0.t-ipconnect.de [62.226.128.223])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 400D13A9EA;
	Sun, 21 Mar 2010 09:35:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <alpine.LFD.2.00.1003201405100.31128@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142826>

Nicolas Pitre venit, vidit, dixit 20.03.2010 19:10:
> On Sat, 20 Mar 2010, Junio C Hamano wrote:
> 
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> With the current .mailmap, git shortlog shows the following for these:
>>
>> Thanks for doing the gruntwork; very much appreciated.
>>
>> I'll backburner this and wait until the people who are described by these
>> entries say they want these entries in the .mailmap file.  If they do not
>> like the variant that your patch suggested, and if they care, then we will
>> get updates that should be applied.  Otherwise they themselves don't care,
>> so why should we ;-)?
> 
> I think at least one person (Michael) cared, so if the people described 
> by those entries don't provide feedback then that means they don't care 
> and you shouldn't wait after them to apply the patch including those 
> entries.

Maybe I should have cc'ed Vitaly, the others are straight typo fixes.
(One may even argue that Vitaly's change is, too.) Smothering on the
backburner for a while, is fine, though ;)

I think for git.git it's simple enough to have "consistent" authorship
information, partly due to the scale, partly due to the fact that by
definition, submitters have a certain affluence with Git...

Also, if used without "-e", shortlog coalesces authors by full name. I
reckon this is the most common way it is used, and it's the mode for
which I provided cleanup.

If you distinguish by e-mail (-e) then there are many obvious multiple
entries, but it's not up to me to decide which is the main e-mail
address. One could take the latest one used, but some people distinguish
between work for hire (maybe for several employers) and private submissions.

Michael
