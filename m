From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH 0/5] ff-refs: builtin command to fast-forward local refs
Date: Tue, 17 Nov 2015 16:28:44 +0100
Message-ID: <564B47AC.7070609@drmicha.warpmail.net>
References: <1447207885-10911-1-git-send-email-rappazzo@gmail.com>
 <56431B69.9010007@drmicha.warpmail.net>
 <CANoM8SV77Jg8qYsn7UZ=a18WvrA_ayAWCnAjN9Tf6Re=r1Ggsg@mail.gmail.com>
 <CANoM8SWxMeDjwy-GwVc+En8D7N8LyzzsBKtX_MbiS4Z49DjD7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 17 16:29:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyiBg-0001s2-8m
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 16:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752301AbbKQP2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 10:28:48 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47484 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750867AbbKQP2r (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Nov 2015 10:28:47 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id E707920307
	for <git@vger.kernel.org>; Tue, 17 Nov 2015 10:28:45 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 17 Nov 2015 10:28:45 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=L4xiqqzjt/88JnSvHcdEFe9YdjY=; b=ey3eIF
	8pIcCVIZTJSEYgWeuDfDirM1qvCTU0JEarkSf+oW5EKt/hHrDqaWjHVEgAx/NgSk
	zt4MN641M3gjiPsOfTSXrnG+S0ApuI1STohLsxBWdB6YEKejF0j2yhinP+2yU54G
	tYm+jgGVt4Ws35MpEeTnpsozk/Wq8sIdDpYdc=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=L4xiqqzjt/88JnS
	vHcdEFe9YdjY=; b=A3YrorstsUUKg/2UAYosQAsibf1oZUQNOhR2VjmVEC4Uilm
	Y/DtdLVzbJSHe8NuEHOxU6300VNeVk9SGCTuuWT+Kq6v/ryEVEQhG9BxXhEmdvfY
	gVuOYht36OI4IfsD6PONHdagurxrXAoQSJ4+DsLAOGUscOXYXk25IiyvpebY=
X-Sasl-enc: HnCVDlU6fSIBSfevXSRTrScpPhSC56RMXIoKMnfAmWLa 1447774125
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5B02EC018FD;
	Tue, 17 Nov 2015 10:28:45 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CANoM8SWxMeDjwy-GwVc+En8D7N8LyzzsBKtX_MbiS4Z49DjD7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281410>

Mike Rappazzo venit, vidit, dixit 17.11.2015 14:58:
> (This message is off list)
[cut the message part, though no big secrets there]

Hi Mike,

I don't think there's a point in discussing this off-list.

Your intentions are clearer now, yes, or else I would have asked more.

I still don't like the idea of having a new command just for the purpose
of fast-forwarding local branches from specified upstreams.

What's wrong with "git merge --ff-only" once you check them out? We have
all the gory messages when you checkout a branch or use the git prompt
or "branch -vv". And if you don't - how is forgetting to "ff-refs"
better than forgetting to "merge --ff-only"?

In short, I don't see a problem that this is solving, but maybe it's
because we use local branches differently, I dunno.

If other people were interested they should or would have come up with
comments, I think (as a general rule).

Cheers,
Michael
