From: Mathias Lafeldt <misfire@debugon.org>
Subject: Re: [PATCH] git-svn: allow the mergeinfo property to be set
Date: Mon, 04 Oct 2010 09:56:14 +0200
Message-ID: <4CA9889E.1020604@debugon.org>
References: <20100924162704.GA4513@dcvr.yhbt.net> <1285386710-27905-1-git-send-email-stevenrwalter@gmail.com> <20100925042457.GA28899@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Steven Walter <stevenrwalter@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Oct 04 09:56:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2fug-0002E2-Vy
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 09:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926Ab0JDH4m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 03:56:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:50405 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752886Ab0JDH4l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 03:56:41 -0400
Received: from [172.20.2.23] (p578D1CEB.dip.t-dialin.net [87.141.28.235])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0M2HgG-1Om6xP292q-00s7AA; Mon, 04 Oct 2010 09:56:16 +0200
User-Agent: Thunderbird 2.0.0.24 (X11/20100411)
In-Reply-To: <20100925042457.GA28899@dcvr.yhbt.net>
X-Provags-ID: V02:K0:jJ0y+stcnu/q1bltw1dfHwhWMAKnKVBx7sU+F66UQMC
 KN4hKYvRyt9/Wfd1HCsvUgFsQV8Sp0DvxdvrKGCsMZzYC7Ehff
 Q4Z4aLJanftLusSeLPvPKDGU2FHqJkWq29b3gIu20N8TmHnDzJ
 q9ceBTNrIEIamN4KS8GCFxrPz10wIT6gdBD5CKFaEizfqy5oM+
 JO9CykUYEbTFZo70X5E92XeXVLx3mGyl7+5APpUiKo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158006>

Eric Wong wrote:
> Steven Walter <stevenrwalter@gmail.com> wrote:
>> As a first step towards preserving merges across dcommit, we need a
>> mechanism to update the svn:mergeinfo property.
>>
>> Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
> 
> Thanks Steven,
> 
> I fixed a bashism and style issues in test case, but nonetheless acked
> and pushed it out to git://git.bogomips.org/git-svn along with a few
> others I had forgotten to tell Junio about while I was on vacation:
> 
> Eric Wong (1):
>       Documentation/git-svn: discourage "noMetadata"
> 
> Mathias Lafeldt (1):
>       git-svn: fix processing of decorated commit hashes
> 
> Steven Walter (2):
>       git-svn: check_cherry_pick should exclude commits already in our history
>       git-svn: allow the mergeinfo property to be set
> 

So, is Junio aware of those patches? Or is it better to resubmit my fix
separately?

-Mathias
