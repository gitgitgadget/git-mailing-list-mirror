From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCHv2 2/2] rev-list: documentation and test for --left/right-only
Date: Tue, 22 Feb 2011 08:23:19 +0100
Message-ID: <4D636467.3060808@drmicha.warpmail.net>
References: <a3224c4269b26c366bb5b5df691f22f17b767f83.1298304396.git.git@drmicha.warpmail.net> <4D625972.4090500@drmicha.warpmail.net> <c0fce67ba8ab8e4ead233950d74048a95d3b64a6.1298304396.git.git@drmicha.warpmail.net> <AANLkTikDUOkRUhXi4o-u-h8Es+sFQj=k9nx3VOOPuJ_K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 08:26:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prmdr-0000CT-Q1
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 08:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041Ab1BVH0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Feb 2011 02:26:34 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40083 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752777Ab1BVH0e (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Feb 2011 02:26:34 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id C11FA206A1;
	Tue, 22 Feb 2011 02:26:33 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 22 Feb 2011 02:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=SqY8OFUpq8YW1ZKzR5TaA3JPlPA=; b=LDwrVezCRblfS+Ub3koTq+Ry4Xx6mL8ZTtN2t5t26DCRnGY6SgKTu/mDPFv0IIXSnP73bJXFibEKJPoEGu1LQlgwXbShx/EJoIFuGGjQoMSVGyjtGNVSTWM4EBpvnASDAoct/zpeVuK2zm9JyUrB5PzvmwzG8Vqa0eNaKdK7gcw=
X-Sasl-enc: zMKMJCFStOPEVd13PWguwU25lm6p4MsOJyv3KMoxOhGW 1298359593
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 23D76409A86;
	Tue, 22 Feb 2011 02:26:33 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <AANLkTikDUOkRUhXi4o-u-h8Es+sFQj=k9nx3VOOPuJ_K@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167529>

Jay Soffian venit, vidit, dixit 21.02.2011 18:37:
> On Mon, Feb 21, 2011 at 11:09 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> +More precisely, `--cherry-pick --right-only --ignore-merges` gives the
> 
> Nit: s/ignore-merges/no-merges/
> 
> j.

Thanks. I think I applied our usual rev-flag to option mapping which
failed me here.

Michael
