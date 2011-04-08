From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Tracking file metadata in git -- fix metastore or enhance git?
Date: Fri, 08 Apr 2011 12:01:14 +0200
Message-ID: <4D9EDCEA.9010903@drmicha.warpmail.net>
References: <BANLkTikkb3DUOtP9NUtNMNV5Z+oJ7AFHfg@mail.gmail.com> <Pine.BSM.4.64L.1104071923580.4692@herc.mirbsd.org> <BANLkTink-c8JuxnMBCAmXiVwFkBxJrTucw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Thorsten Glaser <tg@mirbsd.de>, Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 12:01:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q88VG-0006Md-Be
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 12:01:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965Ab1DHKBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 06:01:17 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:54015 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751568Ab1DHKBQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 06:01:16 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 26E9020A60;
	Fri,  8 Apr 2011 06:01:16 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 08 Apr 2011 06:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=5u2/PgXGOqw9SozWUA3GfT8E4GY=; b=s+OpYVPRJzH0Q94788JtGn5WO60uVFoSOpKymkEf2MsLwfMKPtDYBfNcNYk6Bzaakx9H3QoaIyzqomG1tzrhMP10g8TXSaWpJr/1d4j5UfLMUVpWXroc9v3TrpDxUL/Um/we7nIW0afZ9QkKz2Ihgv2hvErfl58VTu5acO4I2Mo=
X-Sasl-enc: 7Rs6kd1xUeC+TdWaMookYuWf22Ix00OKcKVxWBBnBw5q 1302256875
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 833774049B9;
	Fri,  8 Apr 2011 06:01:15 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <BANLkTink-c8JuxnMBCAmXiVwFkBxJrTucw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171121>

Richard Hartmann venit, vidit, dixit 08.04.2011 02:29:
> On Thu, Apr 7, 2011 at 21:27, Thorsten Glaser <tg@mirbsd.de> wrote:
> 
>> but seeing that people seem to want to use
>> git for keeping their /etc (I use RCS, myself, but volunteered my
>> C skill to change metastore if it needs be) there is definitively
>> a market for having it there, in a standardised manner.
> 
> etckeeper does exist and it's very useful.

While I think there is some consensus not to have attribs (besides x) in
core git, contrib/ may be a good place.

Note that etckeeper and metastore predate our notes feature. By now, a
notes tree is a perfect place to store meta information. You can attach
notes to blobs perfectly (see textconv-cache). That may be an option for
a reimplementation, depending on how you want the versioning of the
files to be related with the versioning of the meta data.

Michael
