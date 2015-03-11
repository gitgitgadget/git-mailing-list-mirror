From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 0/2] log decorations for HEAD
Date: Wed, 11 Mar 2015 09:02:38 +0100
Message-ID: <54FFF69E.3090104@drmicha.warpmail.net>
References: <54FEC8D0.2060304@drmicha.warpmail.net>	<cover.1425995310.git.git@drmicha.warpmail.net> <xmqqr3sw234j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Julien Cretel <j.cretel@umail.ucc.ie>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 11 09:02:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVbbM-0005Ij-JZ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 09:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbbCKICn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 04:02:43 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:44338 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750848AbbCKICk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Mar 2015 04:02:40 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 6B27C20886
	for <git@vger.kernel.org>; Wed, 11 Mar 2015 04:02:38 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute5.internal (MEProxy); Wed, 11 Mar 2015 04:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=wu0198N7zlmqFxVPriR69Q
	ojXEo=; b=cxwl8Bbw8e80S57HqhDbh1cezneEaruKVchg853SOsrQzMa6wJ/8eH
	tNH0tkbCT7kwVDS1nI6Pjpz0AdpfgP9ZGw5vtd1b7qYtTt7wohPUODdPtx6ovqdR
	pW/ypd96q28YKNn5LDwG/x1k9RjeXr5BXoTleJKF+1cXjOb3qBvgk=
X-Sasl-enc: 8mjbPsWVsfI9TCBSWa/TW3xlEPC6EOwO4SfmKR3HR5zE 1426060959
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 70CE968018B;
	Wed, 11 Mar 2015 04:02:39 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <xmqqr3sw234j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265314>

Junio C Hamano venit, vidit, dixit 10.03.2015 18:06:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> So it didn't take too long to convince me after all :)
>>
>> Here comes Junio's version, preceded by a cleanup of the color
>> setting and resetting for decorations.
>>
>> Junio C Hamano (1):
>>   log: decorate HEAD with branch name
>>
>> Michael J Gruber (1):
>>   log-tree: properly reset colors
>>
>>  log-tree.c                        | 76 ++++++++++++++++++++++++++++++++++-----
>>  t/t4013/diff.log_--decorate_--all |  2 +-
>>  t/t4207-log-decoration-colors.sh  | 16 ++++-----
>>  3 files changed, 77 insertions(+), 17 deletions(-)
> 
> Hmph, is the "do not leak commit color" one the same as 5ee87585
> (log --decorate: do not leak "commit" color into the next item,
> 2015-03-04) aka $gmane/264788 [*1*] or is there something I missed?
> 

Uh, I missed that one. The commit msg confuses me somewhat (color.diff
vs color.decorate), but the patch to log-tree.c is the same, and so I
assume the patch to t4207 is the same, too. 2/2 from here should go on
top of 7/7 from there, accordingly.

> [References]
> 
> *1* http://thread.gmane.org/gmane.comp.version-control.git/264063/focus=264788
> 
> 
> 
> 
