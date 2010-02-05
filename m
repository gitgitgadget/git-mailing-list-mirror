From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] git-clean: fix the description of the default behavior
Date: Fri, 05 Feb 2010 10:06:23 +0100
Message-ID: <4B6BDF8F.1080902@drmicha.warpmail.net>
References: <dafb1423c81bc2207d06cf2a97205bcbd9a4968e.1265299086.git.git@drmicha.warpmail.net> <76718491002041316x31f02e0bq5c47a2a96aadb6f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 11:07:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdL4X-0003Bj-1z
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 11:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646Ab0BEJIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 04:08:39 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:47650 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932565Ab0BEJIb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2010 04:08:31 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id CEA82E08C6;
	Fri,  5 Feb 2010 04:08:30 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 05 Feb 2010 04:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=iO1leBGuzD1nrTFrMAcIHLv/bCw=; b=TJ2bHiV5QbJJ3D3NPqY0EMghp9A2vA+ISKXuOllBdrDIFabUvRxLuwqVOXR6m6cLWiF1qYPuGG8jien6NAxYyyovDSe0vXcDoztIp7d3Ud5GEWhQwfsCS0DqzCg6fuK8rajwujY1n6nhOCj4lvczmfvTFhyixQZZsYp9jSKbfHo=
X-Sasl-enc: HkrP8U208f0VLZjIiyo8a1/89Uoj5WXUu+4F9nSGmISG 1265360910
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 221EC4A7709;
	Fri,  5 Feb 2010 04:08:30 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8pre) Gecko/20100201 Lightning/1.0b2pre Shredder/3.0.2pre
In-Reply-To: <76718491002041316x31f02e0bq5c47a2a96aadb6f4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139037>

Jay Soffian venit, vidit, dixit 04.02.2010 22:16:
> On Thu, Feb 4, 2010 at 11:01 AM, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
>> fatal: clean.requireForce defaults to true and -n or -f not given; refusing to clean
> 
> Bike shed:
> 
> fatal: clean.requireForce defaults to true and neither -n nor -f
> given; refusing to clean
> 
> j.

Assuming you're not git-am, you do read between "---" and diff, don't
you? ;)

Michael
