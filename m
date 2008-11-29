From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2008, #06; Wed, 26)
Date: Fri, 28 Nov 2008 16:13:12 -0800
Message-ID: <7voczz4cfb.fsf@gitster.siamese.dyndns.org>
References: <7v7i6qc8r0.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0811272347010.30769@pacific.mpi-cbg.de>
 <7vtz9s8uzu.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0811281225040.30769@pacific.mpi-cbg.de>
 <20081128192033.GF23984@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Nov 29 01:15:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6DUB-000794-Ml
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 01:15:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbYK2ANm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 19:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbYK2ANm
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 19:13:42 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53314 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbYK2ANm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 19:13:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 810F082D12;
	Fri, 28 Nov 2008 19:13:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CBB8782D11; Fri,
 28 Nov 2008 19:13:15 -0500 (EST)
In-Reply-To: <20081128192033.GF23984@spearce.org> (Shawn O. Pearce's message
 of "Fri, 28 Nov 2008 11:20:33 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 93590C92-BDAA-11DD-B9BF-465CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101893>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> ...
>> In other words, unless there is more interest in that feature, enough to 
>> generate a well-understood design before a good implementation, I'd rather 
>> see this patch series dropped.
>
> Ack.  I agree with every remark made by Dscho, and also want to cry "wolf".
>
> I haven't had time to read the patch series.  Its big and intrusive
> and I just don't need the feature.

Well, "me neither".  Although I personally think resisting changes until
it becomes absolutely necessary is a good discipline, we also need to
recognise that there is a chicken-and-egg problem.  When you have a
potentially useful feature, unless people actually try using it in the
field, you won't discover the drawbacks in either the design nor the
implementation, let alone any improvements.

> But I feel like if it were in fact merged I'll fall over some bug
> in it sometime soon and be forced to stop and debug it.

Exactly.  That is how you make progress.

Having said that, I am willing to carry it over in 'next' outside 'master'
for the 1.6.1 cycle, as three people who are most likely to be able to fix
any potential issues are not using that feature.

> Heck at
> the least I'll have to go back to JGit's index code and implement
> the new file format.

I am sorry to dissapoint you but I am planning to use the first one in the
series, which is the one that adds extended index flag bits, for the fix
to an unrelated feature.
