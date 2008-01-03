From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 3/3] Replace setenv(GIT_DIR_ENVIRONMENT, ...) with set_git_dir()
Date: Thu, 3 Jan 2008 07:02:23 +0100
Message-ID: <42F546CE-2564-4DFB-B260-FD50BD51F2BB@zib.de>
References: <11956768414090-git-send-email-prohaska@zib.de> <11956768412755-git-send-email-prohaska@zib.de> <Pine.LNX.4.64.0711220121560.27959@racer.site> <7v63zv9fel.fsf@gitster.siamese.dyndns.org> <C50619A0-4A67-4968-8431-D7A685F723B7@zib.de> <7vsl2y90pm.fsf@gitster.siamese.dyndns.org> <52415F60-C080-4260-86CD-32A379482341@zib.de> <474552D6.5060305@viscovery.net> <3B6B19E6-255F-4D8F-B6A3-255A9E8E0AB0@zib.de> <0FFA1D0A-DB70-446C-9C43-A6FBAEFE7CA4@zib.de> <a1bbc6950801022007w164d050bhf8a8a8c0ad6736b@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Johannes Sixt" <j.sixt@viscovery.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Dmitry Kakurin" <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 07:05:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAJCo-0004Jx-G4
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 07:05:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754622AbYACGE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 01:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754809AbYACGE5
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 01:04:57 -0500
Received: from mailer.zib.de ([130.73.108.11]:61718 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753057AbYACGE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 01:04:57 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m0361HYN029061;
	Thu, 3 Jan 2008 07:04:43 +0100 (CET)
Received: from [192.168.178.21] (brln-4db925b2.pool.einsundeins.de [77.185.37.178])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m0361G6w026138
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 3 Jan 2008 07:01:16 +0100 (MET)
In-Reply-To: <a1bbc6950801022007w164d050bhf8a8a8c0ad6736b@mail.gmail.com>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69513>


On Jan 3, 2008, at 5:07 AM, Dmitry Kakurin wrote:

> On Jan 1, 2008 10:52 AM, Steffen Prohaska <prohaska@zib.de> wrote:
>> In conclusion, using setenv() as in the original code instead of
>> set_git_dir() should be safe and this patch is not needed.
>>
>> I tend to revert the changes in msysgit and see if we hit any
>> problems.  But I'll wait until 1.5.4 is released.
>>
>>        Steffen
>
> Please don't revert this change. I've made it in response to git clone
> failing, commit 855f254b2b5b083a63fc8d7709a42e2cbdc5a136.

I know.  But I cannot reproduce the error.

Do you have a test case that demonstrates the problem?

I either want to see the patch upstream in official git or revert
it in msysgit.  But I cannot answer the questions that were
raised after I sent the patch (see earlier in this thread).  And
I can't see the problem that your patch solves, even after
spending some time on reading and instrumenting code.

	Steffen
