From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: How to git checkout a orgin(unstage) version file in another
 directoy?
Date: Thu, 17 Feb 2011 09:26:21 +0100
Message-ID: <4D5CDBAD.4050700@drmicha.warpmail.net>
References: <loom.20110217T074533-358@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chunlin Zhang <zhangchunlin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 17 09:29:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpzF8-0004Dq-1X
	for gcvg-git-2@lo.gmane.org; Thu, 17 Feb 2011 09:29:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752667Ab1BQI33 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 03:29:29 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33424 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751375Ab1BQI32 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Feb 2011 03:29:28 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id BC5FC206C3;
	Thu, 17 Feb 2011 03:29:27 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 17 Feb 2011 03:29:27 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=u8GXtaxOakBcz5aT7Ql//KC4yQM=; b=K2CAx/7mnRAP25OnAMVAqInYOFg/XsnsfWWrv0z4H0zhqAkNMYPsZo99Pkds2sMMApno7x/zgU6G6YxJEIOMtIncIy+DkqZtf3oJj4b+XY59ZaiozR/UhgyqbzhYCowJigImamgFgGw5nzOARgeVrvBLnKd/noLQKAasK0+Fq1g=
X-Sasl-enc: Gqbeh98vtNTsHcACHYRfAO4UO2jTBYvjmuWN/4FCn3H0 1297931367
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 4044E408C89;
	Thu, 17 Feb 2011 03:29:27 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.7
In-Reply-To: <loom.20110217T074533-358@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167055>

Chunlin Zhang venit, vidit, dixit 17.02.2011 08:00:
> I am writing a script for git-gui's "Tools" menu to diff a file.
> I want to checkout an origin file in a tmp directory and use the diff tool.
> Now it is ok to those unstage file,but to those staged file,
> I found that I do not know how to checkout the orgin(unstage) version.
> 
> In detail,I change current directory to a tmp directory,
> and use for example 
> 'git --work-tree=. --git-dir="/media/linux/t/kernel/.git" checkout README'
>  to checkout origin version.
> 
> Does anyone can help with this? 
> I look the git help and can not find way till now.
> 
> Thanks!
> 

I'm not sure what you mean by "origin" version, but if you mean the
version from the current revision (before making and staging changes),
you would check out from HEAD instead of from the index:

git --work-tree=. --git-dir="/media/linux/t/kernel/.git" checkout HEAD
-- README

Michael
