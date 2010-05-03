From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: RFD: Shipping GitBrowser.js for instaweb
Date: Mon, 03 May 2010 09:57:12 +0200
Message-ID: <4BDE81D8.8070505@drmicha.warpmail.net>
References: <4BDDA780.7090500@drmicha.warpmail.net> <m3wrvmf4ei.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 03 09:57:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8qWm-0003Wr-VJ
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 09:57:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261Ab0ECH5P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 03:57:15 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:33013 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932153Ab0ECH5P (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 May 2010 03:57:15 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id A5260F200A;
	Mon,  3 May 2010 03:57:14 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 03 May 2010 03:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=VUdIpmUf0A5ygY+9Z5ek1T+nJP8=; b=PL8BsqxbdLkrcIpu7sof2bHLfcpLVFaHKK7E5QpZSS5mVTsAm7tPB/DXrhbV/eerK+vWHKWRZKSEt3yo2o8J9J7fSx9cg/cFN2Caoqs5LHUcN3kGBGhWitnBChfqslnDvn//MZQMtOV6FOW+JKwmuRZeALheo/e91H+HIeKfLt4=
X-Sasl-enc: jvla1q4UnAGs+pukLP9ZRpraPc8irBYy3xEGFv9zhSMR 1272873434
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1C5E51ABCD;
	Mon,  3 May 2010 03:57:13 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.5pre) Gecko/20100429 Lightning/1.0b2pre Lanikai/3.1b2pre
In-Reply-To: <m3wrvmf4ei.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146221>

Jakub Narebski venit, vidit, dixit 02.05.2010 22:14:
> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
>> I was wondering whether it would make sense to ship GitBrowser.js with
>> Git and how much it would take to do so.
>>
>> My personal answer to the 1st Q is Yes: instaweb as well as simple
>> gitweb installs would benefit from a graphical DAG viewer.
>>
>> About the required effort I have no clue: I find it difficult to see
>> through which repo contains current gitweb, current repo.or.cz mods, and
>> especially the GitBrowser integration bits. Maybe we could ship the
>> integration bits without the actual GitBrowser if that is more feasible?
> 
> The integration parts are actually present in gitweb, I think.  It is
> a matter of configuration to enable 'graphiclog' link like in
> http://repo.or.cz
> 
> GitBrowser.js is not, I think, the best solution for having graphical
> history in gitweb, but would do...

After having a more thorough look at it I agree... We don't want to
inflate $GIT_DIR/gitweb more than necessary.

But what are the alternatives? Something svg/canvas would be nice, I
guess. The ruby frontends with graphlog don't convince me at all
(neither performance-wise nor layout-wise).

Michael
