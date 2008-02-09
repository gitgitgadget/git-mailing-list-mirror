From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Minor annoyance with git push
Date: Sat, 9 Feb 2008 12:22:33 +0100
Message-ID: <3AA71024-080B-4252-8416-82AE38A4498E@zib.de>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <46a038f90802072050s46ffe305mcffffa068511e3b8@mail.gmail.com> <7vwspfkhxm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 12:23:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNnnb-0007cU-1T
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 12:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756260AbYBILV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 06:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756292AbYBILV5
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 06:21:57 -0500
Received: from mailer.zib.de ([130.73.108.11]:55851 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753160AbYBILVz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 06:21:55 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m19BLalZ016899;
	Sat, 9 Feb 2008 12:21:38 +0100 (CET)
Received: from [192.168.178.21] (brln-4db92967.pool.einsundeins.de [77.185.41.103])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m19BLZXB028833
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sat, 9 Feb 2008 12:21:35 +0100 (MET)
In-Reply-To: <7vwspfkhxm.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73211>


On Feb 8, 2008, at 8:48 AM, Junio C Hamano wrote:

> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
>
>> Because when I "git checkout bla-stale-branch" to help a fellow
>> developer again, I have to remember to "git merge
>> origin/bla-stale-branch" to get a much needed fast-forward before
>> starting to work.
>
> Perhaps it might make sense to have a checkout hook that notices
> the branch that is being checked out is meant to build on top of
> a corresponding remote tracking branch, and performs the
> necessary fast-forward when that is the case.

Or just print a warning that there are new commits on the
tracked branch and leave the decision how to proceed to
the user?

	Steffen
