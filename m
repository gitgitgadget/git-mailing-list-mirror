From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH] rebase: Allow to turn of ignore-if-in-upstream
Date: Sat, 04 Sep 2010 17:03:22 +0200
Message-ID: <4C825FBA.8070605@drmicha.warpmail.net>
References: <4C3C1FE9.40605@drmicha.warpmail.net>	<645d8a9bf671937c1a6962b49cf1c512e0af0d82.1279008702.git.git@drmicha.warpmail.net> <AANLkTikjTgc2OVuyFTHdnHNDq9II-lGSvmin-4EWELPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Erik Faye-Lund <kusmabite@googlemail.com>, git@vger.kernel.org,
	Marat Radchenko <marat@slonopotamus.org>,
	Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Sep 06 08:17:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsV0l-0006Pi-T7
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 08:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041Ab0IFGQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 02:16:55 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:52210 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751736Ab0IFGQy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 02:16:54 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 0C52B327;
	Mon,  6 Sep 2010 02:16:54 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Mon, 06 Sep 2010 02:16:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=0rNjtsCMNA1V0aWYncGS0Eff9as=; b=TUUVRdwmSzbNeJW8BkHKUL8ZRWItJzLoyFOIZviWoP2J+ID9zErgtFYgv+OwE2NXxZAt9FZ9Jm7qEal0YlrqNz3yvORsk9FJ7CmN1apItF8Cu/xBsS/NgXfpGGhXssqUz4aUL11JpsfXyN9Vd8n6lrWZIpivx5KOp2ZUqXKEYRM=
X-Sasl-enc: kB9PtnEbvNIR+WcV8f0wLE1M3MfXZO+R14uFJYGZg/WR 1283753813
Received: from localhost.localdomain (unknown [195.113.246.47])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0F1FB4058A7;
	Mon,  6 Sep 2010 02:16:52 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Lightning/1.0b2pre Thunderbird/3.1.2
In-Reply-To: <AANLkTikjTgc2OVuyFTHdnHNDq9II-lGSvmin-4EWELPg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155532>

Erik Faye-Lund venit, vidit, dixit 13.07.2010 21:33:
> s/of/off/ in the subject ;)
> 
> On Tue, Jul 13, 2010 at 10:13 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> git-rebase uses "format-patch --ignore-if-in-upstream" do determine
>> which commits to apply. This may or may not be desired: a user may want
>> to transplant all commits, or may opt to avoid the possibly time
>> consuming calculation of patch-ids.
>>
>> Therefore, introduce rebase.cherry (defaulting to true) and --cherry and
>> --no-cherry options (to override the config), where --cherry means the
>> current behavior and --no-cherry avoids "--ignore-if-in-upstream".
>>
>> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
>> ---
>> RFC for obvious reasons (doc, tests).
> 

Pinging this one. Is there any interest? Erik is right, off course ;)

Michael
