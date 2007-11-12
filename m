From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 12 Nov 2007 15:27:40 +0100
Message-ID: <087FCF8E-74BF-42EA-B7E2-4622DD0F5F9B@zib.de>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <7vr6j6ve90.fsf@gitster.siamese.dyndns.org> <7vir4d40sw.fsf@gitster.siamese.dyndns.org> <7vwsso3poo.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711121203150.4362@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 15:29:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IraHq-00005q-Rw
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 15:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758391AbXKLO2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 09:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755056AbXKLO2n
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 09:28:43 -0500
Received: from mailer.zib.de ([130.73.108.11]:54511 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758249AbXKLO2m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 09:28:42 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lACEQR27001828;
	Mon, 12 Nov 2007 15:26:27 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lACEQM2i003879
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 12 Nov 2007 15:26:27 +0100 (MET)
In-Reply-To: <Pine.LNX.4.64.0711121203150.4362@racer.site>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64627>


On Nov 12, 2007, at 1:21 PM, Johannes Schindelin wrote:

>> * sp/refspec-match (Sun Nov 11 15:01:48 2007 +0100) 4 commits
>>  - refactor fetch's ref matching to use refname_match()
>>  - push: use same rules as git-rev-parse to resolve refspecs
>>  - add refname_match()
>>  - push: support pushing HEAD to real branch name
>>
>> This changes the semantics slightly but I think it is a move in
>> the right direction.
>
> We could add a "--matching" option and output a warning when it is not
> passed.  I would like this pretty soon, and would not be sad if it  
> went
> into 'next' before this topic.

Is this the road towards
1) "git push --matching" push matching branches.
2) "git push --current" push only current branch.
3) "git push" report error if the config does not contain a Push line.
    (after it reported a warning for a while).

I'd like to see this too. Unfortunately it's unlikely that I'll start
working on it before next weekend.

"--matching" would be a no-op at this time. Only a warning would be  
printed
if it is missing. Right?

	Steffen
