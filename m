From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 02/12] Do not complain about "no common commits" in an empty repo
Date: Wed, 2 Jul 2008 16:04:33 +0200
Message-ID: <FCE9D8BE-BA1A-46D1-AC45-2DC4E419DE8E@zib.de>
References: <15FB2EE9-298D-41D1-B66A-DDC786282ECB@zib.de> <1214987532-23640-1-git-send-email-prohaska@zib.de> <1214987532-23640-2-git-send-email-prohaska@zib.de> <7vskusd5nr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 02 16:06:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KE2y5-0003co-T3
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 16:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbYGBOEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 10:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbYGBOEj
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 10:04:39 -0400
Received: from mailer.zib.de ([130.73.108.11]:62148 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751404AbYGBOEi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 10:04:38 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m62E49WZ000139;
	Wed, 2 Jul 2008 16:04:15 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db94382.pool.einsundeins.de [77.185.67.130])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m62E48NU019165
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 2 Jul 2008 16:04:09 +0200 (MEST)
In-Reply-To: <7vskusd5nr.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.924)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87139>


On Jul 2, 2008, at 10:58 AM, Junio C Hamano wrote:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>>
>> If the repo is empty, we know that already, thank you very much.
>> So shut fetch-pack up about that case.
>
> Two complaints.

You are right, although I didn't intend to "hide" the patch.  I just
went through the differences between the mainline and 4msysgit and
collected a patch series with all changes I found.  I sent this series
to the list, so that the remaining differences do not get lost
unrecognized.

I didn't mean to bother you with incomplete patches.  Maybe I should
have made my intention clearer by prefixing the subject lines with
WIP (or something similar).  Apologies.


> * What does this have to do with Windows port?  Please don't hide a
>   general interface change in a larger and mostly unrelated topic.

I remember that users of msysgit's net installer complaint about this
warning.  The warning appeared as part of the output of a sequence of
automatically executed commands.  Without context, the users did not
understand what the warning means.


> * Do you think people can tell without reading the code in larger  
> context
>   outside the patch and this commit log text if you are talking  
> about the
>   case you fetch _into_ an empty repository, or if you are  
> attempting to
>   fetch _from_ an empty repository, or what?  Please try to be a bit
>   easier for _readers_.  Being more redundant and verbose is better  
> than
>   being too concise.
>
> About the first point, "no common commits" is just a friendly  
> reminder and
> not even an error.  When you see it, you will learn to expect  
> looooooooong
> download session.
>
> I personally happen to agree with the logic of this patch, though  
> --- if
> you are fetching into an empty repository, you would already expect  
> that
> the download is as big as the other end anyway, so you would not  
> need to
> be further reminded about that.
>
> But that is just one-man's opinion.  Maybe somebody knows a reason  
> why I
> am (and the logic I am agreeing with is) wrong.  Maybe not.  So make  
> the
> "remainder of Windows port" series 11 commits, and send this as a  
> general
> interface fix via the normal channel to be discussed, please.


Dscho, will you send it?  You are the original author.
	
	Steffen
