From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] handle_alias: provide GIT_CWD to !alias
Date: Wed, 27 Apr 2011 10:10:26 +0200
Message-ID: <4DB7CF72.3080205@drmicha.warpmail.net>
References: <4DA59B27.50506@ge.infn.it> <e8c9aa9160f922f728d56387e5e86eb50220774f.1302699792.git.git@drmicha.warpmail.net> <7v1v0od557.fsf@alter.siamese.dyndns.org> <4DB7BBEF.8010409@drmicha.warpmail.net> <BANLkTinEiT1_8czdY2DtBnY-5CqN1XAVcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Matej Batic <matej.batic@ge.infn.it>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 10:10:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QEzpd-00022Z-Pq
	for gcvg-git-2@lo.gmane.org; Wed, 27 Apr 2011 10:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752973Ab1D0IKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 04:10:37 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:45391 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752226Ab1D0IK2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2011 04:10:28 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 51C9E20E02;
	Wed, 27 Apr 2011 04:10:28 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 27 Apr 2011 04:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=3D1fHMLe1FbT0gJIz3Y+YNkMyDk=; b=ABiMuny91ZVeLJ0J3z2wU0E9OSTzcINqPi3sOtnc8TQWnvJYpJmTYhgQ/RAjIF12ksLHWhljSa0/IHwbcfzLYjWtSGkBvuvipy25oz3y2lVN15snGxjmE1KxnvW2n0tgxk/oFS1GkvxAc9lgct9V++kOCexLqC0QxhTZiyxIo1I=
X-Sasl-enc: vCB/lqG8TyYgYWtctKzCJUQNd3TyC4sfZbnSPPZSdqlI 1303891828
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 99330440E52;
	Wed, 27 Apr 2011 04:10:27 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <BANLkTinEiT1_8czdY2DtBnY-5CqN1XAVcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172186>

Nguyen Thai Ngoc Duy venit, vidit, dixit 27.04.2011 09:40:
> On Wed, Apr 27, 2011 at 1:47 PM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> A more important point is the prefix-less case (i.e. we are in topdir):
>> Should GIT_YOUNAMEIT be empty then? I would say yes (just like
>> "rev-parse --show-prefix"), Duy said no. We need a third vote :)
> 
> I said no because you named it GIT_CWD. If it's GIT_PREFIX, then empty
> prefix is normal, no objections.

We have a winner then! Patch upcoming.

Michael
