From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v2] user-manual: add advanced topic "bisecting merges"
Date: Thu, 8 Nov 2007 16:07:22 +0100
Message-ID: <C46133BD-4B1D-418A-BC7E-8BA3C815D5DD@zib.de>
References: <20071104112302.GA2119@ins.uni-bonn.de> <11944722214046-git-send-email-prohaska@zib.de> <4732B899.6000908@viscovery.net> <6E62E205-0951-4CCB-A807-AC107E40ACE1@zib.de> <4732D2CC.1010008@viscovery.net> <4732D7F6.7040006@op5.se> <4732DC98.70304@viscovery.net> <97F64156-A457-4BC1-84BE-108369FFD18C@zib.de> <5498B368-053A-424E-B901-A55B66FF5801@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, Andreas Ericsson <ae@op5.se>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Thu Nov 08 16:06:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq8xg-0004Kl-6w
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 16:06:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759430AbXKHPGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 10:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759130AbXKHPGJ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 10:06:09 -0500
Received: from mailer.zib.de ([130.73.108.11]:36475 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754348AbXKHPGH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 10:06:07 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lA8F64eo000648;
	Thu, 8 Nov 2007 16:06:04 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lA8F64cW006791
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 8 Nov 2007 16:06:04 +0100 (MET)
In-Reply-To: <5498B368-053A-424E-B901-A55B66FF5801@lrde.epita.fr>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64036>


On Nov 8, 2007, at 3:51 PM, Benoit Sigoure wrote:

> On Nov 8, 2007, at 1:54 PM, Steffen Prohaska wrote:
>
>> Do you use rebase like this in real life?
>>
>> I thought of the text as background information that might
>> be helpful for users who want do decide wether to merge or
>> to rebase. The problem described may be valuable information
>> supporting a decision about a recommended workflow for a group
>> of users.
>
> You're missing the point.  Johannes suggested that you rebase  
> *only* for bisecting purpose.  Once you find the culprit commit,  
> throw away your rebased stuff.

I got this point. I also noted that it might be time consuming
if you need to resolve conflicts.

The original discussion in which Junio explained the problem
with bisecting merges was about workflows. The question then was
if users should _always_ rebase if possible to make bisecting
easier. It was really a workflow question.

Well, the context of the original discussion is no longer
present in the patch I sent. Therefore, Johannes' comments
absolutely make sense. Actually I find them really inspiring as
I have not thought before about rebasing temporarily, just for
finding a commit. Now I learnt that this could be a useful tool.


> I've never thought about doing this myself, but it's a very clever  
> way of tackling this problem.

Apparently, you haven't thought about this solution either ;)

	Steffen
