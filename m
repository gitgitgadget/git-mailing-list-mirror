From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH v4 00/13] New remote-hg helper
Date: Wed, 31 Oct 2012 10:30:50 +0100
Message-ID: <5090EFCA.7070606@drmicha.warpmail.net>
References: <1351396453-29042-1-git-send-email-felipe.contreras@gmail.com> <20121029085045.GA5023@sigill.intra.peff.net> <CAMP44s0RVe6i4DpNmaV_n7_5KO_aq2WxCPVafjsTukExRSR5Jw@mail.gmail.com> <20121029212643.GA20513@sigill.intra.peff.net> <CAMP44s3L0ycSQFU9s157V7e-GryUdojtQ3Vk_-d2wtPf9NFtbg@mail.gmail.com> <20121029215631.GF20513@sigill.intra.peff.net> <alpine.DEB.1.00.1210301809060.7256@s15462909.onlinehome-server.info> <CAMP44s3CEGqUav-ijnzm7osD70LsjRLyOEeV3bF-LWYTCEPCSQ@mail.gmail.com> <alpine.DEB.1.00.1210302027410.7256@s15462909.onlinehome-server.info> <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 10:31:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTUde-0007BS-Bx
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 10:31:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932870Ab2JaJa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 05:30:56 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35523 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932190Ab2JaJay (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2012 05:30:54 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 05A062014E;
	Wed, 31 Oct 2012 05:30:53 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 31 Oct 2012 05:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=KHBLGbf6V+aexR84ISpoNe
	44QBc=; b=F6PAmratqkMx/NTCFIwNVIimnTpEWkAsWNCAQqi4ouSr0FYAFy9/21
	JUhCyzdkD+8ZeU58bTmYR17mBGjApOD3GgfGvH1ppjDN+1s7BuKkGmrIIyYqLF3f
	0I8t6yUrBwHMvUplGiaGzhCWlEvpuZBxicFWialV3A1mPGNHDnCDI=
X-Sasl-enc: biWb/rDlXQQoz6D5lnL5IiMNIMEvOx2nh9FMTRppoiMT 1351675852
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id DDB174827D8;
	Wed, 31 Oct 2012 05:30:51 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121016 Thunderbird/16.0.1
In-Reply-To: <CAMP44s0akZ7_Nd1Q1AaZJuXnyTJv2MzNqDus76Y82y4LbWVO+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208802>

[quotes heavily cut down by me]
Felipe Contreras venit, vidit, dixit 30.10.2012 21:15:
> Hi,
> 
> On Tue, Oct 30, 2012 at 8:33 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> On Tue, 30 Oct 2012, Felipe Contreras wrote:
>>
>>> But you mentioned something about cooperation, and I've yet to see how
>>> is it that you are planning to cooperate. If you say you don't have time
>>> to spend on this, I don't see why I should worry about testing this
>>> series of patches.
>>
>> It has been mentioned before that the communication style including all
>> these snarky and nasty comments is not helpful.
> 

For the record, Johannes is not the only one being kept from looking at
this series (further) by the tone of this discussion. Per hominem
attacks are neither professional nor helpful. We prefer to discuss code
here, just code. From my comments on an earlier version of your series
you can see I've tried. The way other comment threads on this series
unfolded made me choose to be a mere by-stander again.

>> and I've yet to see how is it that you are planning to cooperate.
> 
> This is also a fact. You haven't provided a branch, you haven't reviewed
> my implementation, you haven't tried it. You mentioned something about

This does not become true through iteration. Max' recent post 'On
git-remote-hg (the "native" one)' [1] points at the msysgit wiki on
remote-hg [2] and his remote-hg branch [3], which is based on and points
at Sverre's original branch [4] and mine [5] which is [4] being
regularly rebased on origin/next. The msysgit devel branch is in heavy
use; I don't use mine often but run the test suite on every rebase
before pushing out.

If the issues that Sverre and Dscho tried to address with their git.git
core (non-helper) patches turn out to be non-issues then I assume
everyone will be happy, including them. You and they have thought a lot
about these things and the way hg-git sync can work. There seems to be
diagreement about the way fast-export/the remote helpers communicate
which revs and refs that are to be synced and updated. This is not
hg-specific, and I suggest to try and clarify that issue as thoroughly
and calmly as possible. Everyone will benefit, and it will make clearer
which tests are appropriate, and accordingly which fixes fix real problems.

Orthogonal to this, it seems that all hg-git interfaces could take
advantage of a "git heads" feature if we resurrect the old ideas (can't
find the thread right now).

Hoping for the best,
Michael

[1] http://permalink.gmane.org/gmane.comp.version-control.git/201083
[2] https://github.com/msysgit/msysgit/wiki/Guide-to-git-remote-hg
[3] https://github.com/fingolfin/git/tree/remote-hg
[4] https://github.com/SRabbelier/git/tree/remote-hg
[5] https://github.com/mjg/git/tree/remote-hg
