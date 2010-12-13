From: Hans-Christoph Steiner <hans@at.or.at>
Subject: Re: developing a modified Linux-style workflow
Date: Sun, 12 Dec 2010 22:23:48 -0500
Message-ID: <F24A90CB-3B3F-4B45-B638-7E262202CDF0@at.or.at>
References: <7EAE16CF-A9A8-47A6-9294-3646CCDB0E9C@at.or.at> <20101213033145.GA3609@gmail.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 04:24:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRz17-0005mG-6O
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 04:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664Ab0LMDX4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Dec 2010 22:23:56 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:35459 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756618Ab0LMDXz convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 22:23:55 -0500
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BBD0B42B;
	Sun, 12 Dec 2010 22:23:50 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Sun, 12 Dec 2010 22:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=cc:message-id:from:to:in-reply-to:content-type:content-transfer-encoding:mime-version:subject:date:references; s=smtpout; bh=jcQY3G8RPTLxe3PK6FKoUYcDSzA=; b=DnpuI7hSwXa1LOfDpyqKPqQSibylaixJmlqRMcuogpyUXzC1jplMIEqKSvjqmo2uUdaHVZUWzVcK915bOWNWhADfaGB+43SNTVfMu9/Y/HRBLqmPGeWmV6I7Ta2Mo9dMIAY7BfxYn+0K04pOXNKCSSYGUFA1Qx/tZyh6K4s44UE=
X-Sasl-enc: xrP2mtTc/pdtYW3weqVCN9yJNqI1c1J8szq/ekPJ53ox 1292210629
Received: from dhcp-10.4.0.169.at.or.at (ool-182d0ad9.dyn.optonline.net [24.45.10.217])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 9E5D1409BDC;
	Sun, 12 Dec 2010 22:23:49 -0500 (EST)
In-Reply-To: <20101213033145.GA3609@gmail.com>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163511>


On Dec 12, 2010, at 10:31 PM, David Aguilar wrote:

> On Sun, Dec 12, 2010 at 05:24:16PM -0500, Hans-Christoph Steiner =20
> wrote:
>>
>> Hey all,
>>
>> (and my second post on this list...)
>>
>> I've gotten pretty good at git, and its helping me already with
>> managing the very odd workflows I have with the software I work a
>> lot on called Pd (http://puredata.info).  My role in Pd development
>> is like a Linux lieutenant.
>>
>> I also the main dev for an app called Pd-extended, which is based on
>> Pd.  Now I'm stuck trying to figure out how to use git to match my
>> current workflow for Pd-extended, which is a kind of long-lived
>> branch, almost like a friendly fork.  So its kind of close to the
>> Linux workflow with me as a lieutenant, but not quite.
>>
>> What makes it tricky is that I make releases directly from my repo
>> that are widely used.  So my repo is both lieutenant and dictator at
>> the same time.  So that's where I am stumped.  I want to be able to
>> rebase and push to a public repo, but that would be stupid.  So
>> there has got to be another way.
>
> Have you considered periodically merging Pd into Pd-extended
> as an alternative to rebasing?  It might even be easier to
> manage in the long-term.


The thing I really like about the lieutenant workflow is that I can =20
keep my patches at the top of history, and it automatically handles it =
=20
once my patch is handled upstream.  It seems that merging Pd into Pd-=20
extended would leave me with a very complicated history.

=2Ehc


-----------------------------------------------------------------------=
-----

'You people have such restrictive dress for women,=92 she said, hobblin=
g =20
away in three inch heels and panty hose to finish out another pink-=20
collar temp pool day.  - =93Hijab Scene #2", by Mohja Kahf
