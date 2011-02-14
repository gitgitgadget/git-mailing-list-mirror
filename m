From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 14:43:10 +0100
Message-ID: <4D59316E.5090203@drmicha.warpmail.net>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com> <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org> <87k4h34bhj.fsf@catnip.gol.com> <7vr5bbupj4.fsf@alter.siamese.dyndns.org> <AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com> <4D58D2DF.1050205@viscovery.net> <AANLkTikTfyHBOvQmjhT8yTziL4R67+AAk0O-Nk1tBSaL@mail.gmail.com> <4D5906FD.7030502@drmicha.warpmail.net> <AANLkTi=RcJfEGv966VCrOMPE640xyyw1wEFFkdA9fFWq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Miles Bader <miles@gnu.org>, Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 14:46:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Poykw-0006ge-4V
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 14:46:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753707Ab1BNNqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 08:46:17 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:42089 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751079Ab1BNNqQ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 08:46:16 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C0816206EF;
	Mon, 14 Feb 2011 08:46:15 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 14 Feb 2011 08:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=nDRTnk+QzTbublRJ9Boue/ozvSo=; b=cdF1ccq0nekTh5VBB0XUSav56BlP1KSEWaqVZ19IymetpTVLCEZ6VCATiAmPLB9b8sJG9yXYY91ZuYmiFD/x53D41jdnR1Vbga0lmdw/aY12vh8+srrYGrx2Qqlu1wk1B6UsAbLcIQSgUOLuXdxWN/crpzZ10CM00R5hqJzXanM=
X-Sasl-enc: Dxies4YX1oQ+7/jvrL5jPzdzP1CX9qD+kKxy5JFeeZSI 1297691175
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id C26E240D255;
	Mon, 14 Feb 2011 08:46:14 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTi=RcJfEGv966VCrOMPE640xyyw1wEFFkdA9fFWq@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166709>

Nguyen Thai Ngoc Duy venit, vidit, dixit 14.02.2011 14:14:
> On Mon, Feb 14, 2011 at 5:42 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> Full disclaimer: I have an alias "staged" for "diff --cached" myself...
> 
> Be careful with your fingers. There's a command named "git stage".

I know. Can we remove it as part of 1.8.0? It's our only builtin alias.

Michael
