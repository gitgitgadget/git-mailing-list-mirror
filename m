From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH v2] git-clone: Add option --branch to override initial  branch
Date: Thu, 12 Mar 2009 13:18:49 +0900
Message-ID: <buoocw7s79y.fsf@dhlpc061.dev.necel.com>
References: <alpine.DEB.1.00.0903030047130.10279@pacific.mpi-cbg.de>
	<1236040414-19089-1-git-send-email-torarnv@gmail.com>
	<7vbpsh93q5.fsf@gitster.siamese.dyndns.org>
	<loom.20090309T143413-334@post.gmane.org>
	<94a0d4530903090901o6e8c2a40k676387f90ee461b3@mail.gmail.com>
	<4d8e3fd30903110152m1b52de30ge630d6b9f6a4c7fe@mail.gmail.com>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	torarnv@gmail.com, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 05:20:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhcPN-0004g7-Qj
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 05:20:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbZCLETH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 00:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbZCLETH
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 00:19:07 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:44339 "EHLO
	tyo201.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbZCLETG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 00:19:06 -0400
Received: from relay21.aps.necel.com ([10.29.19.50])
	by tyo201.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id n2C4Io8q024077;
	Thu, 12 Mar 2009 13:18:50 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay21.aps.necel.com with ESMTP; Thu, 12 Mar 2009 13:18:50 +0900
Received: from dhlpc061 ([10.114.114.241] [10.114.114.241]) by relay31.aps.necel.com with ESMTP; Thu, 12 Mar 2009 13:18:49 +0900
Received: by dhlpc061 (Postfix, from userid 31295)
	id CB30352E276; Thu, 12 Mar 2009 13:18:49 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
Blat: Foop
In-Reply-To: <4d8e3fd30903110152m1b52de30ge630d6b9f6a4c7fe@mail.gmail.com>
	(Paolo Ciarrocchi's message of "Wed, 11 Mar 2009 09:52:28 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113001>

Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> writes:
> $ git clone -n URL
> $ git checkout -b foo origin/bar
>
> That being said, I see the following command as an improvement over
> the actual GIT UI:
>
>  $ git clone git://URI -b bar

Note that in your original advice, foo and bar can be different, and
it's not clear to me what "-b bar" should do...

Personally I frequently use foo == bar (no local master branch), but I
think another common pattern is foo != bar, but foo or bar == "master".

Maybe a syntax similar to push, like "-b LOCAL_BR:REMOTE_BR",
with "-b BR" being shorthand for "-b BR:BR"?

-Miles

-- 
Happiness, n. An agreeable sensation arising from contemplating the misery of
another.
